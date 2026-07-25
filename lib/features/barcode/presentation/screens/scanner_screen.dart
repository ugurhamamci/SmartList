import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Tarayıcının ne aradığı.
enum ScanPurpose {
  /// Ürün barkodu (EAN / UPC / ISBN).
  product,

  /// Listeye katılma QR kodu.
  joinList,
}

/// Taramanın sonucu.
class ScanResult {
  const ScanResult({required this.code, required this.format});

  final String code;

  /// Tarayıcının bildirdiği format adı; günlüğe ve geçmişe yazılır.
  final String format;
}

/// Kamera ile barkod ve QR okur.
///
/// Kamera bulunamazsa veya izin verilmezse akış tıkanmaz: elle kod girme
/// alanına düşer. Bu, kamerası olmayan bir masaüstü tarayıcıda önizleme
/// yapılabilmesi için de gerekli.
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({this.purpose = ScanPurpose.product, super.key});

  final ScanPurpose purpose;

  /// Tarayıcıyı açar ve okunan kodu döndürür; vazgeçilirse `null`.
  static Future<ScanResult?> open(
    BuildContext context, {
    ScanPurpose purpose = ScanPurpose.product,
  }) {
    return Navigator.of(context).push<ScanResult>(
      MaterialPageRoute(builder: (_) => ScannerScreen(purpose: purpose)),
    );
  }

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController _controller = MobileScannerController(
    // Yalnızca beklenen formatlar dinlenir; gereksiz çözümleme yapılmaz.
    formats: widget.purpose == ScanPurpose.joinList
        ? const [BarcodeFormat.qrCode]
        : const [
            BarcodeFormat.ean13,
            BarcodeFormat.ean8,
            BarcodeFormat.upcA,
            BarcodeFormat.upcE,
            BarcodeFormat.code128,
            // ITF-14 kolideki ürün kodudur; paket barkodu okunduğunda da
            // ürünü çözebiliyoruz.
            BarcodeFormat.itf14,
          ],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  final _manualController = TextEditingController();

  /// Aynı kodun iki kez işlenmesini engeller: kamera saniyede birkaç kare
  /// çözer ve ilk okumadan sonra ekran kapanana kadar yenileri gelebilir.
  bool _handled = false;

  bool _cameraFailed = false;
  String? _cameraError;
  bool _torchOn = false;

  @override
  void dispose() {
    _manualController.dispose();
    // Kamerayı kapatmak asenkron; `dispose` bunu bekleyemez, kapanmasını
    // arka planda tamamlamasına bırakıyoruz.
    unawaited(_controller.dispose());
    super.dispose();
  }

  void _submit(String code, String format) {
    if (_handled || !mounted) {
      return;
    }
    _handled = true;
    Navigator.of(context).pop(ScanResult(code: code, format: format));
  }

  void _onDetect(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;
      if (value != null && value.trim().isNotEmpty) {
        _submit(value.trim(), barcode.format.name);
        return;
      }
    }
  }

  void _submitManual() {
    final value = _manualController.text.trim();
    if (value.isEmpty) {
      return;
    }
    _submit(value, 'manual');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;
    final isJoin = widget.purpose == ScanPurpose.joinList;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isJoin ? 'QR ile Katıl' : 'Barkod Tara',
          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        actions: [
          if (!_cameraFailed)
            PressScale(
              onTap: () async {
                await _controller.toggleTorch();
                if (mounted) {
                  setState(() => _torchOn = !_torchOn);
                }
              },
              semanticLabel: 'Işık',
              child: Icon(
                _torchOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
              ),
            ),
          SizedBox(width: spacing.small),
        ],
      ),
      body: _cameraFailed
          ? _manualEntry(context, isJoin: isJoin)
          : Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                  errorBuilder: (context, error) {
                    // Kamera açılamadı: kullanıcıyı boş siyah ekranda
                    // bırakmak yerine elle girişe geçiyoruz.
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && !_cameraFailed) {
                        setState(() {
                          _cameraFailed = true;
                          _cameraError = error.errorCode.name;
                        });
                      }
                    });
                    return const ColoredBox(color: Colors.black);
                  },
                ),

                // Hedef çerçevesi
                Center(
                  child: Container(
                    width: 260,
                    height: isJoin ? 260 : 170,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(spacing.radiusCard),
                    ),
                  ),
                ),

                // Alt bilgi ve elle giriş bağlantısı
                Positioned(
                  left: spacing.containerMargin,
                  right: spacing.containerMargin,
                  bottom: DesignTokens.space10,
                  child: Column(
                    children: [
                      Text(
                        isJoin
                            ? 'Katılmak istediğiniz listenin QR kodunu çerçeveye getirin'
                            : 'Ürünün barkodunu çerçeveye getirin',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spacing.gutter),
                      TextButton(
                        onPressed: () => setState(() => _cameraFailed = true),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Kodu elle gir'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  /// Kamera yoksa veya kullanıcı tercih ederse kodu elle girme ekranı.
  Widget _manualEntry(BuildContext context, {required bool isJoin}) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return ColoredBox(
      color: scheme.surface,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(spacing.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isJoin ? Icons.qr_code_2 : Icons.numbers,
                size: 64,
                color: scheme.primary,
              ),
              SizedBox(height: spacing.gutter),
              Text(
                isJoin ? 'Davet kodunu girin' : 'Barkodu elle girin',
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: spacing.small),
              Text(
                _cameraError == null
                    ? 'Kamera kullanmadan devam edebilirsiniz.'
                    : 'Kameraya erişilemedi. Kodu elle girebilirsiniz.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: spacing.sectionGap),
              TextField(
                controller: _manualController,
                autofocus: true,
                keyboardType: isJoin
                    ? TextInputType.text
                    : TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submitManual(),
                decoration: InputDecoration(
                  hintText: isJoin ? 'Örn: 82Xq4T' : 'Örn: 8690526016917',
                  prefixIcon: const Icon(Icons.keyboard),
                ),
              ),
              SizedBox(height: spacing.gutter),
              FilledButton(
                onPressed: _submitManual,
                child: const Text('Devam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
