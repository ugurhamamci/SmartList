import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/models/enums.dart';
import 'package:smartlist/models/shopping_list.dart';

void main() {
  final now = DateTime.utc(2026, 7, 24, 12);

  ShoppingList build({
    int itemCount = 0,
    int completedItemCount = 0,
    Map<String, MemberRole> memberRoles = const {},
    DateTime? lastActivityAt,
  }) {
    return ShoppingList(
      id: 'list-1',
      title: 'Weekly shop',
      ownerId: 'owner-1',
      createdAt: now,
      updatedAt: now,
      createdBy: 'owner-1',
      updatedBy: 'owner-1',
      itemCount: itemCount,
      completedItemCount: completedItemCount,
      memberRoles: memberRoles,
      memberCount: memberRoles.isEmpty ? 1 : memberRoles.length,
      lastActivityAt: lastActivityAt,
    );
  }

  group('progress', () {
    test('is zero for an empty list rather than dividing by zero', () {
      expect(build().progress, 0);
    });

    test('reports the completed fraction', () {
      expect(build(itemCount: 4, completedItemCount: 1).progress, 0.25);
    });

    test('clamps to one when counters disagree', () {
      expect(build(itemCount: 2, completedItemCount: 5).progress, 1);
    });
  });

  group('remainingItemCount', () {
    test('never reports a negative remainder', () {
      expect(build(itemCount: 2, completedItemCount: 5).remainingItemCount, 0);
    });

    test('subtracts completed from total', () {
      expect(build(itemCount: 5, completedItemCount: 2).remainingItemCount, 3);
    });
  });

  group('isFullyPurchased', () {
    test('is false for an empty list', () {
      expect(build().isFullyPurchased, isFalse);
    });

    test('is true once every item is ticked off', () {
      expect(build(itemCount: 3, completedItemCount: 3).isFullyPurchased, true);
    });
  });

  group('roleOf', () {
    test('returns the stored role', () {
      final list = build(memberRoles: {'a': MemberRole.editor});
      expect(list.roleOf('a'), MemberRole.editor);
    });

    test('falls back to guest for a non-member', () {
      expect(build().roleOf('stranger'), MemberRole.guest);
    });
  });

  group('sortTimestamp', () {
    test('prefers lastActivityAt when present', () {
      final activity = now.add(const Duration(hours: 3));
      expect(build(lastActivityAt: activity).sortTimestamp, activity);
    });

    test('falls back to updatedAt', () {
      expect(build().sortTimestamp, now);
    });
  });

  group('json round trip', () {
    test('preserves the role map and counters', () {
      final list = build(
        itemCount: 3,
        completedItemCount: 1,
        memberRoles: {'a': MemberRole.owner, 'b': MemberRole.viewer},
      );

      final restored = ShoppingList.fromJson(list.toJson());

      expect(restored.itemCount, 3);
      expect(restored.completedItemCount, 1);
      expect(restored.memberRoles['a'], MemberRole.owner);
      expect(restored.memberRoles['b'], MemberRole.viewer);
    });
  });
}
