import 'package:car_workshop/models/service_booking_model.dart';
import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:car_workshop/providers/user_authentication_provider.dart';
import 'package:car_workshop/utils/app_colors.dart';
import 'package:car_workshop/view/home_screen/admin_view_screen/admin_home_screen.dart';
import 'package:car_workshop/view_model/service_reservation.dart';
import 'package:car_workshop/widgets/common_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddServiceBookingScreen extends StatefulWidget {
  const AddServiceBookingScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceBookingScreen> createState() =>
      _AddServiceBookingScreenState();
}

class _AddServiceBookingScreenState extends State<AddServiceBookingScreen> {
  TextEditingController registrationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cEmailController = TextEditingController();
  TextEditingController bookingTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeScreenProvider>(context, listen: false).getMechanicName();
    Provider.of<HomeScreenProvider>(context, listen: false).fetchVehicleBrand();
  }

  @override
  void dispose() {
    registrationController.dispose();
    nameController.dispose();
    phoneController.dispose();
    cEmailController.dispose();
    bookingTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.03,
          ),
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
                    "New Service Entry",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // -------------- Car Details ----------------- //
                        Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Vehicle Details",
                                  style: GoogleFonts.roboto(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.021,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              // ====== Vehicle Make option ========= //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Vehicle Manufacturer: ",
                                    style: GoogleFonts.roboto(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    elevation: 4,
                                    shadowColor: AppColor().shadowColor,
                                    child: DropdownMenu(
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          left: 14,
                                        ),
                                      ),
                                      menuHeight:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      hintText: "Select Manufacturer",
                                      textStyle: GoogleFonts.roboto(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                      ),
                                      onSelected: (value) async {
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .chooseManufacturer(value);

                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .selectedManufacturer);

                                        //Fetch Model Name after selecting a Brand --------------------->
                                        await Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .fetchVehicleModel();
                                        //Fetch Image after selecting a Brand --------------------->
                                        await Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .fetchBrandImage();
                                      },
                                      dropdownMenuEntries: [
                                        for (var i = 0;
                                            i <
                                                Provider.of<HomeScreenProvider>(
                                                        context)
                                                    .vehicleBrand
                                                    .length;
                                            i++)
                                          DropdownMenuEntry(
                                            value:
                                                Provider.of<HomeScreenProvider>(
                                                        context)
                                                    .vehicleBrand[i],
                                            label:
                                                Provider.of<HomeScreenProvider>(
                                                        context)
                                                    .vehicleBrand[i],
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ====== Vehicle Model option ========= //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Vehicle Model: ",
                                    style: GoogleFonts.roboto(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    elevation: 4,
                                    shadowColor: AppColor().shadowColor,
                                    child: DropdownMenu(
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          left: 14,
                                        ),
                                      ),
                                      menuHeight:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      hintText: "Select Model",
                                      textStyle: GoogleFonts.roboto(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                      ),
                                      onSelected: (value) {
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .chooseModel(value);

                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .selectedModel);
                                      },
                                      dropdownMenuEntries:
                                          Provider.of<HomeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedManufacturer ==
                                                  ""
                                              ? [
                                                  DropdownMenuEntry(
                                                    value: "Select a Brand",
                                                    label: "Select a Brand",
                                                  ),
                                                ]
                                              : [
                                                  for (var i = 0;
                                                      i <
                                                          Provider.of<HomeScreenProvider>(
                                                                  context)
                                                              .vehicleModel
                                                              .length;
                                                      i++)
                                                    DropdownMenuEntry(
                                                      value: Provider.of<
                                                                  HomeScreenProvider>(
                                                              context)
                                                          .vehicleModel[i],
                                                      label: Provider.of<
                                                                  HomeScreenProvider>(
                                                              context)
                                                          .vehicleModel[i],
                                                    )
                                                ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ====== Vehicle Model Year ========= //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Model year: ",
                                    style: GoogleFonts.roboto(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    elevation: 4,
                                    shadowColor: AppColor().shadowColor,
                                    child: DropdownMenu(
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          left: 14,
                                        ),
                                      ),
                                      menuHeight:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      hintText: "Select year",
                                      textStyle: GoogleFonts.roboto(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                      ),
                                      onSelected: (value) {
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .chooseYear(value);

                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .selectedYear);
                                      },
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                            value: "2020", label: "2020"),
                                        DropdownMenuEntry(
                                            value: "2021", label: "2021"),
                                        DropdownMenuEntry(
                                            value: "2022", label: "2022"),
                                        DropdownMenuEntry(
                                            value: "2023", label: "2023"),
                                        DropdownMenuEntry(
                                            value: "2024", label: "2024"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ====== Vehicle Registration Number ========= //
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  ),
                                  controller: registrationController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Registration Number",
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),

                        // -------------- Customer Details ----------------- //
                        Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Details",
                                  style: GoogleFonts.roboto(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.021,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              // ====== Customer Name ========= //
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  ),
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Custome Name",
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ====== Customer Phone ========= //
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  ),
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Custome Phone",
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ====== Customer Email ========= //
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  ),
                                  controller: cEmailController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Custome Email",
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),

                        // -------------- Other Details ----------------- //
                        Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Other Details",
                                  style: GoogleFonts.roboto(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.021,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ======== Booking title ======== //

                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  ),
                                  controller: bookingTitleController,
                                  decoration: InputDecoration(
                                    hintText: "Booking Title",
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ======== Vehicle Receive Date ======== //
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 14),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                  ),
                                  title: Text(
                                    Provider.of<HomeScreenProvider>(context)
                                        .selectReceiveDate,
                                    style: GoogleFonts.roboto(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.0175,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      DateTime? selectedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2010),
                                              lastDate: DateTime(2050));

                                      if (selectedDate != null) {
                                        // This timestamp format for filtering purpose
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .receiveTimestamp(selectedDate);
                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .timestapReceiveDate);

                                        // This dd-mm-yyyy format for showing in UI
                                        DateTime dateTime =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                Provider.of<HomeScreenProvider>(
                                                        context,
                                                        listen: false)
                                                    .timestapReceiveDate!);

                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .receiveDate(dateTime);
                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .selectReceiveDate);
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.calendar,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ======== Start Delivery Date ======== //
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: AppColor().shadowColor,
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 14),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                  ),
                                  title: Text(
                                    Provider.of<HomeScreenProvider>(context)
                                        .selectDeliveryDate,
                                    style: GoogleFonts.roboto(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.0175,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      DateTime? selectedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2010),
                                              lastDate: DateTime(2050));

                                      if (selectedDate != null) {
                                        // This timestamp format for filtering purpose
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .deliveryTimestamp(selectedDate);
                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .timestapDeliveryDate);

                                        // This dd-mm-yyyy format for showing in UI
                                        DateTime dateTime =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                Provider.of<HomeScreenProvider>(
                                                        context,
                                                        listen: false)
                                                    .timestapDeliveryDate!);

                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .deliveryDate(dateTime);
                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .selectDeliveryDate);
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.calendar,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),

                              // ======== Assign Mechanic ======== //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mechanic Selection: ",
                                    style: GoogleFonts.roboto(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    elevation: 4,
                                    shadowColor: AppColor().shadowColor,
                                    child: DropdownMenu(
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(left: 14),
                                      ),
                                      menuHeight:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      hintText: "Select Mechanic Name",
                                      textStyle: GoogleFonts.roboto(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                      ),
                                      onSelected: (value) {
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .chooseMechanic(value);

                                        print(Provider.of<HomeScreenProvider>(
                                                context,
                                                listen: false)
                                            .selectedMechanic!
                                            .userId);
                                      },
                                      dropdownMenuEntries: [
                                        for (var i = 0;
                                            i <
                                                Provider.of<HomeScreenProvider>(
                                                        context)
                                                    .mechanicName
                                                    .length;
                                            i++)
                                          DropdownMenuEntry(
                                            value:
                                                Provider.of<HomeScreenProvider>(
                                                        context,
                                                        listen: false)
                                                    .mechanicName[i],
                                            label:
                                                Provider.of<HomeScreenProvider>(
                                                        context,
                                                        listen: false)
                                                    .mechanicName[i]
                                                    .userName,
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        // -------------- Save Button ----------------- //
                        Material(
                          elevation: 5,
                          shadowColor: AppColor().shadowColor,
                          child: GestureDetector(
                            onTap: () async {
                              await ServiceReservation().saveReservationData(
                                context,
                                registrationController.text.trim(),
                                nameController.text.trim(),
                                phoneController.text.trim(),
                                cEmailController.text.trim(),
                                bookingTitleController.text.trim(),
                              );
                            },
                            child: CommonButton(
                                title: Provider.of<UserAuthenticationProvider>(
                                                context)
                                            .isLoading ==
                                        true
                                    ? "Saving..."
                                    : "Save"),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
