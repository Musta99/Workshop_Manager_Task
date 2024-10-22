import 'package:car_workshop/models/service_booking_model.dart';
import 'package:car_workshop/models/user_data_model.dart';
import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:car_workshop/providers/user_authentication_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseCloudStore {
  // User Information Save to FireStore----------------------------- //
  Future saveUserInfo(BuildContext context, email, password, userName) async {
    UserModel userModel = UserModel(
      userEmail: email,
      userPassword: password,
      userId: FirebaseAuth.instance.currentUser!.uid,
      userRole: Provider.of<UserAuthenticationProvider>(context, listen: false)
          .selectedRole,
      userName: userName,
    );

    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userModel.toJson());
  }

  // Service Booking Information Save to FireStore----------------------------- //
  Future saveServiceBookingInfo(BuildContext context, vehicleRegistration, name,
      phone, email, booking) async {
    ServiceBookingModel serviceBookingModel = ServiceBookingModel(
      vehicleImage:
          Provider.of<HomeScreenProvider>(context, listen: false).imageUrl,
      vehicleMake: Provider.of<HomeScreenProvider>(context, listen: false)
          .selectedManufacturer,
      vehicleModel:
          Provider.of<HomeScreenProvider>(context, listen: false).selectedModel,
      vehicleYear:
          Provider.of<HomeScreenProvider>(context, listen: false).selectedYear,
      vehicleregistrationNumber: vehicleRegistration,
      customerName: name,
      customerPhone: phone,
      customerEmail: email,
      bookingTitle: booking,
      receiveFormattedDate:
          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectReceiveDate,
      receiveTimestampDate:
          Provider.of<HomeScreenProvider>(context, listen: false)
              .timestapReceiveDate!,
      deliveryFormattedDate:
          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectDeliveryDate,
      deliveryTimestampDate:
          Provider.of<HomeScreenProvider>(context, listen: false)
              .timestapDeliveryDate!,
      assignedMechanic: Provider.of<HomeScreenProvider>(context, listen: false)
          .selectedMechanic!
          .userName,
      mechanicUID: Provider.of<HomeScreenProvider>(context, listen: false)
          .selectedMechanic!
          .userId,
      status: "In Progress",
    );

    await FirebaseFirestore.instance
        .collection("ReservationData")
        .doc(vehicleRegistration)
        .set(
          serviceBookingModel.toJson(),
        );
  }

  // Service Booking Delete From FireStore----------------------------- //
  Future deleteReservation(String value) async {
    await FirebaseFirestore.instance
        .collection("ReservationData")
        .doc(value)
        .delete();
  }

  // Mechanic Changing Service Status to Completed in FireStore----------------------------- //
  Future updateServiceStatus(value) async {
    await FirebaseFirestore.instance
        .collection("ReservationData")
        .doc(value)
        .update({
      "status": "Completed",
    });
  }
}
