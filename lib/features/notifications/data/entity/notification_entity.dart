class NotificationEntity {
  final String id;
  final String body;
  final bool isReaded;
  final String timeStamp;

  NotificationEntity({
    required this.id,
    required this.body,
    required this.isReaded,
    required this.timeStamp,
  });
}
