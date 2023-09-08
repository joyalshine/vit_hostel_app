import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:vit_hostel_repo/firebase/firebase_notifications.dart';
import 'package:vit_hostel_repo/firebase/initial_data_fetch.dart';
import 'package:vit_hostel_repo/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fade_transition.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'main_page.dart';

class DataFetchScreen extends StatefulWidget {
  const DataFetchScreen(this.userDetails, {super.key});

  final Map<String, dynamic> userDetails;
  @override
  State<DataFetchScreen> createState() => _DataFetchScreenState();
}

class _DataFetchScreenState extends State<DataFetchScreen> {
  bool _isError = false;
  Future checkUserConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => NetworkErrorDialog(
          fetchData: fetchData,
        ),
      );
    } else {
      fetchData();
    }
  }

  void fetchData() async {
    try {
      var details = widget.userDetails['details'];
      final Box boxUserDetails = Hive.box('userDetails');
      boxUserDetails.put('name', details['name']);
      boxUserDetails.put('email', widget.userDetails['email']);
      boxUserDetails.put('regno', details['regno']);
      boxUserDetails.put('phone', details['phone']);
      boxUserDetails.put('block', details['block']);
      boxUserDetails.put('room', details['room']);
      boxUserDetails.put('mess', details['mess']);
      bool errors = false;

      final Box boxComplaints = Hive.box('complaints');
      final Map<String, dynamic> complaintsResponse =
          await fetchUserComplaints(widget.userDetails['email']);
      if (complaintsResponse['status']) {
        boxComplaints.put('cleaningHistory', complaintsResponse['cleaning']);
        boxComplaints.put('messHistory', complaintsResponse['mess']);
        boxComplaints.put(
            'disciplineHistory', complaintsResponse['discipline']);
        boxComplaints.put(
            'maintenanceHistory', complaintsResponse['maintenance']);
        boxComplaints.put(
            'disciplinePending', complaintsResponse['disciplinePending']);
        boxComplaints.put('messPending', complaintsResponse['messPending']);
        boxComplaints.put(
            'maintenancePending', complaintsResponse['maintenancePending']);
        boxComplaints.put(
            'cleaningPending', complaintsResponse['cleaningPending']);
        boxComplaints.put('messPendingId', complaintsResponse['messPendingId']);
        boxComplaints.put(
            'cleanPendingId', complaintsResponse['cleanPendingId']);
        boxComplaints.put('mainPendingId', complaintsResponse['mainPendingId']);
        boxComplaints.put('discPendingId', complaintsResponse['discPendingId']);
      } else {
        print('iniside ---------------------');
        errors = true;
      }

      final Box boxMenu = Hive.box('messMenu');
      final Map<String, dynamic> menuFetchResponse = await fetchCurrentMenu();
      if (menuFetchResponse['status']) {
        if (menuFetchResponse['data'] != null) {
          final Map<String, dynamic> menuData = menuFetchResponse['data'];
          boxMenu.putAll(menuData);
          boxMenu.put('month', menuFetchResponse['key']);
        }
      } else {
        print('inisde else menu');
        errors = true;
      }
      if (!errors) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        await FirebaseNotifications().initNotifications(widget.userDetails['email']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) => FadeTransitionContainer(
                        screen: MainPage(
                      newIndex: 0,
                    ))));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) => LoginPage(
                      showError: true,
                    )));
      }
    } catch (err) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => LoginPage(
                    showError: true,
                  )));
    }
  }

  @override
  void initState() {
    checkUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double deviceWidth = queryData.size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Color(0xff3a377a),
              Color.fromARGB(179, 84, 62, 210),
              Color(0xff000000),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/dataFetching.png',
                    width: deviceWidth * 0.7,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.8,
                    child: Text(
                      'Please wait while we configure the app',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _isError
                ? Text('Error')
                : const SpinKitThreeBounce(
                    color: Color.fromARGB(108, 255, 255, 255),
                    size: 50.0,
                  )
          ],
        ),
      ),
    );
  }
}

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key, required this.fetchData})
      : super(key: key);

  final Function() fetchData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 200, child: Image.asset('assets/images/no_internet.webp')),
          const SizedBox(height: 32),
          const Text(
            "Whoops!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "No internet connection found.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            "Check your connection and try again.",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Ok"),
            onPressed: () async {
              final connectivityResult =
                  await Connectivity().checkConnectivity();
              if (connectivityResult == ConnectivityResult.none) {
              } else {
                Navigator.pop(context);
                fetchData();
              }
              ;
            },
          )
        ],
      ),
    );
  }
}
