import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:car_workshop/services/firebase_cloudstore.dart';
import 'package:car_workshop/utils/app_colors.dart';
import 'package:car_workshop/view_model/service_reservation.dart';
import 'package:car_workshop/widgets/common_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ServiceBookingDetails extends StatelessWidget {
  final String bookingTitle;
  final String imageUrl;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleModelYear;
  final String vehicleRegNumber;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String receiveDate;
  final String deliverydate;
  final String assignedMechanic;
  final String serviceStatus;
  ServiceBookingDetails({
    Key? key,
    required this.bookingTitle,
    required this.imageUrl,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleModelYear,
    required this.vehicleRegNumber,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.receiveDate,
    required this.deliverydate,
    required this.assignedMechanic,
    required this.serviceStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.0346,
                          backgroundColor: AppColor().commonColor,
                          child: Icon(
                            FontAwesomeIcons.chevronLeft,
                            size: MediaQuery.of(context).size.height * 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Reservation Details",
                        style: GoogleFonts.roboto(
                          fontSize: MediaQuery.of(context).size.height * 0.024,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Colors.transparent,
                      )
                    ],
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imageUrl,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  // =============> Vehicle Issue <=================
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: AppColor().shadowColor,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        bookingTitle,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  // ===========> Vehicle Details <====================
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: AppColor().shadowColor,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.023,
                                child: Icon(
                                  FontAwesomeIcons.car,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                "Vehicle Details",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.021),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  // Vehicle Make ------------------------>
                                  ReUsableRow(
                                      title: "Vehicle Make: ",
                                      dataValue: vehicleMake),
                                  // Vehicle Model ------------------------>
                                  ReUsableRow(
                                      title: "Vehicle Model: ",
                                      dataValue: vehicleModel),
                                  // Vehicle Model Year ------------------------>
                                  ReUsableRow(
                                      title: "Vehicle Model Year:",
                                      dataValue: vehicleModelYear),
                                  // Vehicle Registration Number ------------------------>
                                  ReUsableRow(
                                      title: "Registration Number:",
                                      dataValue: vehicleRegNumber)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),

                  // ===========> Customer Details <====================
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: AppColor().shadowColor,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.023,
                                child: Icon(
                                  Icons.person,
                                  size:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                "Customer Details",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.021),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  // Vehicle Make ------------------------>
                                  ReUsableRow(
                                      title: "Customer Name: ",
                                      dataValue: customerName),
                                  // Vehicle Model ------------------------>
                                  ReUsableRow(
                                      title: "Customer Phone: ",
                                      dataValue: customerPhone),
                                  // Vehicle Model Year ------------------------>
                                  ReUsableRow(
                                      title: "Customer Email: ",
                                      dataValue: customerEmail),
                                  // Vehicle Registration Number ------------------------>
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),

                  // ===========> Other Details <====================
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: AppColor().shadowColor,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.023,
                                child: Icon(
                                  FontAwesomeIcons.ellipsis,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                "Other Details",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.021),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  ReUsableRow(
                                      title: "Receive date: ",
                                      dataValue: receiveDate),
                                  ReUsableRow(
                                      title: "Delivery date: ",
                                      dataValue: deliverydate),
                                  ReUsableRow(
                                      title: "Assigned Mechanic: ",
                                      dataValue: assignedMechanic),
                                  ReUsableRow(
                                      title: "Service Status: ",
                                      dataValue: serviceStatus),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Visibility(
                            visible: Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .userRole ==
                                    "Mechanic"
                                ? true
                                : false,
                            child: Material(
                              elevation: serviceStatus == "Completed" ? 0 : 5,
                              shadowColor: serviceStatus == "Completed"
                                  ? null
                                  : Colors.black,
                              child: GestureDetector(
                                onTap: () async {
                                  await ServiceReservation().updateReservation(
                                    context,
                                    vehicleRegNumber,
                                  );

                                  Navigator.pop(context);
                                },
                                child: serviceStatus == "Completed"
                                    ? Text(
                                        "Completed",
                                        style: GoogleFonts.roboto(
                                          color: Color(0xff1fa924),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : CommonButton(title: "Mark as Completed"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  final String title;
  final String dataValue;
  ReUsableRow({
    Key? key,
    required this.title,
    required this.dataValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.height * 0.02),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            dataValue,
            textAlign: TextAlign.end,
            style: GoogleFonts.roboto(
                fontSize: MediaQuery.of(context).size.height * 0.018),
          ),
        ),
      ],
    );
  }
}
