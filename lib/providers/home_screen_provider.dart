import 'package:car_workshop/models/all_user_model.dart';
import 'package:car_workshop/models/mechanic_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenProvider extends ChangeNotifier {
  // ============= Car Manufacturer Select for Admin View Screen============== //
  String selectedManufacturer = "";
  void chooseManufacturer(value) {
    selectedManufacturer = value;
    notifyListeners();
  }

  // ============= Car Model Select for Admin View Screen============== //
  String selectedModel = "";
  void chooseModel(value) {
    selectedModel = value;
    notifyListeners();
  }

  // ============= Car Model year Select for Admin View Screen============== //
  String selectedYear = "";
  void chooseYear(value) {
    selectedYear = value;
    notifyListeners();
  }

  // ============= Vehicle Receive Date for Booking Reservation Admin View Screen============== //
  String selectReceiveDate = "Vehicle Receive Date";
  void receiveDate(value) {
    selectReceiveDate = DateFormat('dd-MM-yyyy').format(value);
    notifyListeners();
  }

  int timestapReceiveDate = 0;

  void receiveTimestamp(value) {
    timestapReceiveDate = value.millisecondsSinceEpoch;
    notifyListeners();
  }

  // ============= Vehicle Delivery Date for Booking Reservation Admin View Screen============== //
  String selectDeliveryDate = "Vehicle Delivery Date";
  void deliveryDate(value) {
    selectDeliveryDate = DateFormat('dd-MM-yyyy').format(value);
    notifyListeners();
  }

  int timestapDeliveryDate = 0;

  void deliveryTimestamp(value) {
    timestapDeliveryDate = value.millisecondsSinceEpoch;
    notifyListeners();
  }

  // List of Mechanic Name ----------------------- //
  List<MechanicUser> mechanicName = [];

  void getMechanicName() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .where("userRole", isEqualTo: "Mechanic")
        .get();

    for (var doc in querySnapshot.docs) {
      mechanicName.add(
        MechanicUser(
          userId: doc["userId"],
          userEmail: doc["userEmail"],
          userName: doc["userName"],
        ),
      );
    }

    notifyListeners();
  }

  // ============= Mechanic Selection for Booking Reservation Admin View Screen============== //
  MechanicUser? selectedMechanic;
  void chooseMechanic(value) {
    selectedMechanic = value;
    notifyListeners();
  }

  // ============= Data View format Daily/Weekly/Monthly for Booking Reservation Admin View Screen============== //
  String initialFormat = "Daily";

  void changeToDaily() {
    initialFormat = "Daily";
    notifyListeners();
  }

  void changeToWeekly() {
    initialFormat = "Weekly";
    notifyListeners();
  }

  void changeToMonthly() {
    initialFormat = "Monthly";
    notifyListeners();
  }

  // ============= Date Pick for daily/weekly/monthly view for Booking Reservation Admin View Screen============== //
  String pickedDate = DateFormat("dd-MM-yyyy").format(
    DateTime.now(),
  );

  void changeDate(value) {
    pickedDate = DateFormat("dd-MM-yyyy").format(value);
    notifyListeners();
  }

  // For Weekly Purpose =======
  String startWeek = "";
  String endWeek = "";
  void getWeek(value) {
    DateTime startOfWeek = value.subtract(Duration(days: value.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    startWeek = DateFormat("dd-MM-yyyy").format(startOfWeek);
    endWeek = DateFormat("dd-MM-yyyy").format(endOfWeek);
    notifyListeners();
  }

  // For Monthly Purpose =======
  String startMonth = "";
  String endMonth = "";
  void getMonth(value) {
    DateTime startOfMonth = DateTime(value.year, value.month, 1);
    DateTime endOfMonth = DateTime(value.year, value.month + 1, 0);
    startMonth = DateFormat("dd-MM-yyyy").format(startOfMonth);
    endMonth = DateFormat("dd-MM-yyyy").format(endOfMonth);

    notifyListeners();
  }

  // UserRole fetch Function to check whether user is Admin/Mechanic-------------------------//
  String userRole = "";
  String userEmail = "";
  String userName = "";

  void allUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection("UserData")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

      userRole = documentSnapshot["userRole"];
      userEmail = documentSnapshot["userEmail"];
      userName = documentSnapshot["userName"];
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  // Vehicle Brand fetch Function to display in dropdown-------------------------//
  List vehicleBrand = [];
  Future fetchVehicleBrand() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Vehicle")
        .doc("Brand")
        .get();
    vehicleBrand = documentSnapshot["brand"];
    notifyListeners();

    print(vehicleBrand.toString());
  }

  // Vehicle Model fetch according to Brand Function to display in dropdown-------------------------//
  List vehicleModel = [];
  Future fetchVehicleModel() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Vehicle")
        .doc("Model")
        .get();

    vehicleModel = documentSnapshot[selectedManufacturer];

    notifyListeners();
  }

  // Vehicle Image fetch according to Brand Function to display in dropdown-------------------------//
  String imageUrl = "";

  Future fetchBrandImage() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Vehicle")
        .doc("Image")
        .get();

    imageUrl = documentSnapshot[selectedManufacturer];

    notifyListeners();
    print(imageUrl.toString());
  }
}
