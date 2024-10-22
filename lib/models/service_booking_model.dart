class ServiceBookingModel {
  final String vehicleImage;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleYear;
  final String vehicleregistrationNumber;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String bookingTitle;
  final String receiveFormattedDate;
  final int receiveTimestampDate;
  final String deliveryFormattedDate;
  final int deliveryTimestampDate;
  final String assignedMechanic;
  final String mechanicUID;
  final String status;

  ServiceBookingModel(
      {required this.vehicleImage,
      required this.vehicleMake,
      required this.vehicleModel,
      required this.vehicleYear,
      required this.vehicleregistrationNumber,
      required this.customerName,
      required this.customerPhone,
      required this.customerEmail,
      required this.bookingTitle,
      required this.receiveFormattedDate,
      required this.receiveTimestampDate,
      required this.deliveryFormattedDate,
      required this.deliveryTimestampDate,
      required this.assignedMechanic,
      required this.mechanicUID,
      required this.status});

  Map<String, dynamic> toJson() => {
        "vehicleImage": vehicleImage,
        "vehicleMake": vehicleMake,
        "vehicleModel": vehicleModel,
        "vehicleYear": vehicleYear,
        "vehicleregistrationNumber": vehicleregistrationNumber,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "customerEmail": customerEmail,
        "bookingTitle": bookingTitle,
        "receiveFormattedDate": receiveFormattedDate,
        "receiveTimestampDate": receiveTimestampDate,
        "deliveryFormattedDate": deliveryFormattedDate,
        "deliveryTimestampDate": deliveryTimestampDate,
        "assignedMechanic": assignedMechanic,
        "mechanicUID": mechanicUID,
        "status": status,
      };
}
