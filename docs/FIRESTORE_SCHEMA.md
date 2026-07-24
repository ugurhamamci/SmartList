# SmartList — Cloud Firestore schema

The schema is designed so that the common reads are single-document or
single-query operations, and so that the security rules can authorise any
operation from at most one extra document read.

## Conventions

Every mutable document carries the same audit block:

| Field | Type | Notes |
|---|---|---|
| `createdAt` | timestamp | Server-assigned; immutable after creation |
| `createdBy` | string (uid) | Immutable after creation |
| `updatedAt` | timestamp | Server-assigned on every write |
| `updatedBy` | string (uid) | The caller that performed the write |
| `deletedAt` | timestamp \| null | Soft delete marker; `null` means live |
| `version` | int | Increments on every write; optimistic concurrency |

Soft delete is the default: the client stamps `deletedAt` and filters it out of
queries. A hard delete is reserved for owners and for the account-deletion Cloud
Function, so an accidental removal is recoverable and an audit trail survives.

## Collections

```
users/{userId}
  settings/preferences            singleton preferences document
  device_tokens/{installationId}  FCM registrations, keyed by installation
  favorites/{favoriteId}
  recent_searches/{queryHash}     id is a hash of the normalised query
  barcode_history/{scanId}
  voice_commands/{commandId}
  statistics/{periodId}           backend-written aggregates
  notifications/{notificationId}  backend-written fan-out

shopping_lists/{listId}
  items/{itemId}
  members/{userId}                document id is the member's uid
  activity_logs/{logId}           append-only
  invitations/{invitationId}
  presence/{userId}               per-list heartbeat

chat_rooms/{listId}               id equals the list id
  messages/{messageId}
  typing/{userId}

categories/{categoryId}           global (curated) or user-owned
shopping_templates/{templateId}   public (curated) or user-owned
shared_links/{linkId}             resolvable unauthenticated
subscriptions/{userId}            backend/webhook-written only
premium_features/{featureId}
roles/{roleId}
permissions/{permissionId}
feedback/{feedbackId}
bug_reports/{reportId}
analytics_events/{eventId}        write-only sink
```

## Key design decisions

**Membership is denormalised onto the list.** `shopping_lists/{id}` carries
`memberIds: string[]` and `memberRoles: map<uid, role>`. This does two things:
`memberIds array-contains uid` answers "lists I belong to" in one query, and the
security rules authorise every subcollection operation from a single `get()` on
the parent list rather than a per-request membership lookup. The rules enforce
that the two fields stay consistent with each other and with `memberCount`.

**A chat room shares its id with its list.** `chat_rooms/{listId}` means a
member of a list is a participant of exactly one room, and the room's rules can
reuse the list's role map.

**Read receipts and reactions are maps, not arrays.** `readBy` and `reactions`
are keyed by uid, so each participant only ever writes their own key. Concurrent
writes merge instead of overwriting one another, which an array append cannot
guarantee.

**Item ordering uses a sparse double.** `items.sortOrder` is spaced by
`AppConstants.sortOrderGap`, so a drag-and-drop reorder writes one document — the
moved item takes the midpoint between its new neighbours — instead of
renumbering the collection.

**Presence is per-list and self-healing.** `shopping_lists/{id}/presence/{uid}`
holds a heartbeat republished on an interval. A record whose `lastSeenAt` is
older than `AppConstants.presenceTimeout` is treated as offline, so a crashed or
disconnected client does not leave a permanently "online" indicator.

**Statistics are pre-aggregated.** The statistics screen reads one document per
period instead of scanning a user's purchase history. Aggregates are written
only by the Cloud Function that folds `activity_logs` forward; the rules make
them read-only to clients.

**Entitlements are backend-only.** `isPremium` and `subscriptionTier` on the
user document, and everything under `subscriptions/`, are rejected on client
writes. A client that wants a premium capability checks the tier; it can never
grant itself one.

**Activity logs are append-only.** The rules forbid update and delete, which
makes the trail tamper-evident and safe to use as the input to aggregation.

## Roles

| Capability | Owner | Editor | Viewer | Guest |
|---|:---:|:---:|:---:|:---:|
| Read list and items | ✅ | ✅ | ✅ | ✅ |
| Create / edit / delete items | ✅ | ✅ | — | — |
| Toggle item completion | ✅ | ✅ | ✅ | — |
| Send chat messages | ✅ | ✅ | ✅ | — |
| Invite members | ✅ | ✅ | — | — |
| Manage members and roles | ✅ | — | — | — |
| Delete or transfer the list | ✅ | — | — | — |

Viewers are restricted by field, not just by document: the rules allow a viewer
to change only `isCompleted`, `completedAt`, `purchasedBy`, `purchasedAt` and the
audit fields on an item.

## Indexes

`firestore.indexes.json` defines the composite indexes. The ones that matter
most:

- `shopping_lists`: `memberIds array-contains` + `deletedAt` + `updatedAt desc`
  — the home screen query.
- `shopping_lists`: the same prefix plus `isArchived`, `isPinned`, `isFavorite`
  or `categoryId` for each filter chip.
- `items`: `deletedAt` + `sortOrder`, plus variants for the completion,
  category and priority sort modes.
- `items` (collection group): `purchasedBy` + `purchasedAt desc` — the
  statistics and "most purchased" queries.
- `invitations` (collection group): `inviteeEmail` + `status` + `createdAt desc`
  — pending invitations for the signed-in address, across all lists.
- `messages`: `deletedAt` + `createdAt desc` — paginated chat history.

Large free-text fields (`notes`, `body`, `description`) and map fields
(`memberRoles`, `reactions`, `metadata`) carry index exemptions, because
indexing them costs write throughput and storage for queries that are never
issued.

## Deploying

```sh
firebase deploy --only firestore:rules,firestore:indexes,storage
```

Run the rules against the emulator before deploying:

```sh
firebase emulators:start --only firestore,storage
```
