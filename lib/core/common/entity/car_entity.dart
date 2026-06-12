class CarEntity {
  final String id;
  final String imagePath;
  final String title;
  final double price;
  final String year;
  final bool isFavorite;
  final int mileage;
  final String location;
  final String chatRoomId;
  final int phoneNumber;
  final int whatsappNumber;
  final bool isPaid;
  final String? trackingId;

  CarEntity({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.year,
    required this.isFavorite,
    required this.mileage,
    required this.location,
    required this.chatRoomId,
    required this.phoneNumber,
    required this.whatsappNumber,
    this.isPaid = false,
    this.trackingId,
  });
}
