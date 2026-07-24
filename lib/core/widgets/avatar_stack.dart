import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Bir üyenin avatarında gösterilecek bilgi.
class AvatarData {
  const AvatarData({required this.initials, this.photoUrl, this.label});

  final String initials;
  final String? photoUrl;

  /// Ekran okuyucuya verilecek ad.
  final String? label;
}

/// Tek üye avatarı.
///
/// Fotoğraf yoksa veya yüklenemezse baş harflere düşer — ağ hatasında boş
/// gri daire bırakmaz.
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    required this.data,
    this.size = DesignTokens.avatarSmall,
    this.borderColor,
    this.borderWidth = 2,
    super.key,
  });

  final AvatarData data;
  final double size;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget fallback() {
      return ColoredBox(
        color: scheme.primaryContainer,
        child: Center(
          child: Text(
            data.initials,
            style: TextStyle(
              fontFamily: DesignTokens.fontFamily,
              // Baş harf, avatar boyutuyla birlikte ölçeklenir.
              fontSize: size * 0.38,
              fontWeight: FontWeight.w700,
              color: scheme.onPrimary,
            ),
          ),
        ),
      );
    }

    final url = data.photoUrl;

    return Semantics(
      label: data.label,
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? scheme.surfaceContainerLowest,
            width: borderWidth,
          ),
        ),
        child: ClipOval(
          child: url == null || url.isEmpty
              ? fallback()
              : CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => ColoredBox(
                    color: scheme.surfaceContainer,
                  ),
                  errorWidget: (_, _, _) => fallback(),
                ),
        ),
      ),
    );
  }
}

/// Üst üste binen avatar dizisi ve taşan üye sayısı için `+N` rozeti.
///
/// Tasarımda `flex -space-x-3` ile 12px negatif aralık kullanılıyor.
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    required this.members,
    this.maxVisible = 2,
    this.size = DesignTokens.avatarSmall,
    this.overlap = DesignTokens.avatarOverlap,
    super.key,
  });

  final List<AvatarData> members;

  /// Bu sayıdan fazlası `+N` rozetinde toplanır.
  final int maxVisible;
  final double size;

  /// Negatif değer avatarları üst üste bindirir.
  final double overlap;

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;
    final visible = members.take(maxVisible).toList();
    final hidden = members.length - visible.length;

    return Semantics(
      label: '${members.length} üye',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < visible.length; i++)
            Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : overlap),
              child: MemberAvatar(data: visible[i], size: size),
            ),
          if (hidden > 0)
            Padding(
              padding: EdgeInsets.only(left: overlap),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: scheme.surfaceContainerLowest,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$hidden',
                    style: TextStyle(
                      fontFamily: DesignTokens.fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: scheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
