import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:car_workshop/services/firebase_auth.dart';
import 'package:car_workshop/services/firebase_cloudstore.dart';
import 'package:car_workshop/utils/app_colors.dart';
import 'package:car_workshop/view/home_screen/admin_view_screen/add_service_booking_screen.dart';
import 'package:car_workshop/view/home_screen/admin_view_screen/service_booking_details.dart';
import 'package:car_workshop/view/user_authentication/login_screen.dart';
import 'package:car_workshop/view_model/date_selection.dart';
import 'package:car_workshop/widgets/menu_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          drawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.7,
            backgroundColor: AppColor().backgroundColor,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.05,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        "Hello, " +
                            Provider.of<HomeScreenProvider>(context).userName,
                        style: GoogleFonts.rhodiumLibre(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      Text(
                        Provider.of<HomeScreenProvider>(context).userRole,
                        style: GoogleFonts.rhodiumLibre(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: MenuButton(
                    title: "Reservations",
                    icon: FontAwesomeIcons.gears,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddServiceBookingScreen(),
                      ),
                    );
                  },
                  child: MenuButton(
                    title: "Add Reservations",
                    icon: FontAwesomeIcons.plus,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: MenuButton(
                    title: "Profile",
                    icon: FontAwesomeIcons.user,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: MenuButton(
                    title: "Settings",
                    icon: FontAwesomeIcons.gear,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuthentication().logOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: MenuButton(
                    title: "Logout",
                    icon: FontAwesomeIcons.signOut,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColor().backgroundColor,
          floatingActionButton: Visibility(
            visible:
                Provider.of<HomeScreenProvider>(context).userRole == "Admin"
                    ? true
                    : false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                backgroundColor: AppColor().commonColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddServiceBookingScreen(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: (Builder(builder: (context) {
            return SafeArea(
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
                            Scaffold.of(context).openDrawer();
                          },
                          child: Icon(Icons.menu),
                        ),
                        Text(
                          "Service Reservation",
                          style: GoogleFonts.roboto(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .changeToDaily();
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Provider.of<HomeScreenProvider>(context)
                                            .initialFormat ==
                                        "Daily"
                                    ? Colors.white
                                    : Color(0xffE0E0E0),
                                elevation:
                                    Provider.of<HomeScreenProvider>(context)
                                                .initialFormat ==
                                            "Daily"
                                        ? 5
                                        : 0,
                                shadowColor:
                                    Provider.of<HomeScreenProvider>(context)
                                                .initialFormat ==
                                            "Daily"
                                        ? Colors.black.withOpacity(0.4)
                                        : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Daily",
                                      style: GoogleFonts.roboto(
                                          color:
                                              Provider.of<HomeScreenProvider>(
                                                              context)
                                                          .initialFormat ==
                                                      "Daily"
                                                  ? Colors.black
                                                  : Color(0xff757575)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .changeToWeekly();

                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .getWeek(DateTime.now());
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Provider.of<HomeScreenProvider>(context)
                                            .initialFormat ==
                                        "Weekly"
                                    ? Colors.white
                                    : Color(0xffE0E0E0),
                                elevation:
                                    Provider.of<HomeScreenProvider>(context)
                                                .initialFormat ==
                                            "Weekly"
                                        ? 5
                                        : 0,
                                shadowColor:
                                    Provider.of<HomeScreenProvider>(context)
                                                .initialFormat ==
                                            "Weekly"
                                        ? Colors.black.withOpacity(0.4)
                                        : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Weekly",
                                      style: GoogleFonts.roboto(
                                          color:
                                              Provider.of<HomeScreenProvider>(
                                                              context)
                                                          .initialFormat ==
                                                      "Weekly"
                                                  ? Colors.black
                                                  : Color(0xff757575)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .changeToMonthly();
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .getMonth(DateTime.now());
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Provider.of<HomeScreenProvider>(context)
                                            .initialFormat ==
                                        "Monthly"
                                    ? Colors.white
                                    : Color(0xffE0E0E0),
                                elevation:
                                    Provider.of<HomeScreenProvider>(context)
                                                .initialFormat ==
                                            "Monthly"
                                        ? 5
                                        : 0,
                                shadowColor:
                                    Provider.of<HomeScreenProvider>(context)
                                                .initialFormat ==
                                            "Monthly"
                                        ? Colors.black.withOpacity(0.4)
                                        : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Monthly",
                                      style: GoogleFonts.roboto(
                                          color:
                                              Provider.of<HomeScreenProvider>(
                                                              context)
                                                          .initialFormat ==
                                                      "Monthly"
                                                  ? Colors.black
                                                  : Color(0xff757575)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: AppColor().shadowColor,
                      child: ListTile(
                        title: Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .initialFormat ==
                                "Daily"
                            ? Text(Provider.of<HomeScreenProvider>(context)
                                .pickedDate)
                            : Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .initialFormat ==
                                    "Weekly"
                                ? Text(
                                    "${Provider.of<HomeScreenProvider>(context).startWeek} to ${Provider.of<HomeScreenProvider>(context).endWeek}")
                                : Text(
                                    "${Provider.of<HomeScreenProvider>(context).startMonth} to ${Provider.of<HomeScreenProvider>(context).endMonth}"),
                        trailing: GestureDetector(
                          onTap: () async {
                            await DateSelection().selectDate(context);
                          },
                          child: Icon(
                            FontAwesomeIcons.calendar,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Expanded(
                      child: StreamBuilder(
                        // If user is Admin, then Different Result show in UI----------------->
                        stream: Provider.of<HomeScreenProvider>(context, listen: false).userRole ==
                                "Admin"
                            ? Provider.of<HomeScreenProvider>(context, listen: false).initialFormat ==
                                    "Daily"
                                ? FirebaseFirestore.instance
                                    .collection("ReservationData")
                                    .where("receiveFormattedDate",
                                        isEqualTo: Provider.of<HomeScreenProvider>(context, listen: false)
                                            .pickedDate)
                                    .snapshots()
                                : Provider.of<HomeScreenProvider>(context, listen: false).initialFormat ==
                                        "Weekly"
                                    ? FirebaseFirestore.instance
                                        .collection("ReservationData")
                                        .where("receiveFormattedDate",
                                            isGreaterThanOrEqualTo:
                                                Provider.of<HomeScreenProvider>(context, listen: false)
                                                    .startWeek)
                                        .where("receiveFormattedDate",
                                            isLessThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false)
                                                .endWeek)
                                        .snapshots()
                                    : FirebaseFirestore.instance
                                        .collection("ReservationData")
                                        .where("receiveFormattedDate", isGreaterThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).startMonth)
                                        .where("receiveFormattedDate", isLessThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).endMonth)
                                        .snapshots()
                            :

                            // If user is Mechanic, then Different Result show in UI----------------->
                            Provider.of<HomeScreenProvider>(context, listen: false).initialFormat == "Daily"
                                ? FirebaseFirestore.instance.collection("ReservationData").where("mechanicUID", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("receiveFormattedDate", isEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).pickedDate).snapshots()
                                : Provider.of<HomeScreenProvider>(context, listen: false).initialFormat == "Weekly"
                                    ? FirebaseFirestore.instance.collection("ReservationData").where("mechanicUID", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("receiveFormattedDate", isGreaterThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).startWeek).where("receiveFormattedDate", isLessThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).endWeek).snapshots()
                                    : FirebaseFirestore.instance.collection("ReservationData").where("mechanicUID", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("receiveFormattedDate", isGreaterThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).startMonth).where("receiveFormattedDate", isLessThanOrEqualTo: Provider.of<HomeScreenProvider>(context, listen: false).endMonth).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text("No data found"),
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                ServiceBookingDetails(
                                              imageUrl: snapshot.data!
                                                  .docs[index]["vehicleImage"],
                                              bookingTitle: snapshot.data!
                                                  .docs[index]["bookingTitle"],
                                              vehicleMake: snapshot.data!
                                                  .docs[index]["vehicleMake"],
                                              vehicleModel: snapshot.data!
                                                  .docs[index]["vehicleModel"],
                                              vehicleModelYear: snapshot.data!
                                                  .docs[index]["vehicleYear"],
                                              vehicleRegNumber: snapshot
                                                      .data!.docs[index]
                                                  ["vehicleregistrationNumber"],
                                              customerName: snapshot.data!
                                                  .docs[index]["customerName"],
                                              customerEmail: snapshot.data!
                                                  .docs[index]["customerEmail"],
                                              customerPhone: snapshot.data!
                                                  .docs[index]["customerPhone"],
                                              receiveDate:
                                                  snapshot.data!.docs[index]
                                                      ["receiveFormattedDate"],
                                              deliverydate:
                                                  snapshot.data!.docs[index]
                                                      ["deliveryFormattedDate"],
                                              assignedMechanic:
                                                  snapshot.data!.docs[index]
                                                      ["assignedMechanic"],
                                              serviceStatus: snapshot
                                                  .data!.docs[index]["status"],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          elevation: 8,
                                          shadowColor: AppColor().shadowColor,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Service Identity No: ",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index][
                                                            "vehicleregistrationNumber"],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Vehicle Issue: ",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["bookingTitle"],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Receive Date: ",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index][
                                                            "receiveFormattedDate"],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Delivery Date: ",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index][
                                                            "deliveryFormattedDate"],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Customer Name: ",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["customerName"],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Service Status: ",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["status"],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: GoogleFonts.roboto(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        "status"] ==
                                                                    "Completed"
                                                                ? Color(
                                                                    0xff1fa924)
                                                                : null),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                Visibility(
                                                  visible:
                                                      Provider.of<HomeScreenProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .userRole ==
                                                              "Admin"
                                                          ? true
                                                          : false,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await FirebaseCloudStore()
                                                          .deleteReservation(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  "vehicleregistrationNumber"]);
                                                    },
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }))),
    );
  }
}
