import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:vit_hostel_repo/firebase/initial_data_fetch.dart';

import 'fade_transition.dart';
import 'main_page.dart';

class DataFetchScreen extends StatefulWidget {
  const DataFetchScreen(this.userDetails,{super.key});

  final Map<String,dynamic> userDetails;
  @override
  State<DataFetchScreen> createState() => _DataFetchScreenState();
}

class _DataFetchScreenState extends State<DataFetchScreen> {

  void fetchData() async{
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
    final Map<String,dynamic> complaintsResponse = await fetchUserComplaints(widget.userDetails['email']);
    if(complaintsResponse['status']){
      boxComplaints.put('cleaningHistory',complaintsResponse['cleaning']);
      boxComplaints.put('messHistory',complaintsResponse['mess']);
      boxComplaints.put('disciplineHistory',complaintsResponse['discipline']);
      boxComplaints.put('maintenanceHistory',complaintsResponse['maintenance']);
    }
    else{
      errors = true;
      const snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin:  EdgeInsets.only(bottom: 15,left: 5,right: 5),
            backgroundColor: Color.fromARGB(255, 223, 57, 19),
            content: Text('Some error occured!'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    final Box boxMenu = Hive.box('messMenu');
    final Map<String,dynamic> menuFetchResponse = await fetchCurrentMenu();
    if(menuFetchResponse['status']){
      final Map<String,dynamic> menuData = menuFetchResponse['data'];
      boxMenu.putAll(menuData); 
      boxMenu.put('month',menuFetchResponse['key']);
    }
    else{
      errors = true;
      const snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin:  EdgeInsets.only(bottom: 15,left: 5,right: 5),
            backgroundColor: Color.fromARGB(255, 223, 57, 19),
            content: Text('Some error occured!'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if(!errors){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx) => FadeTransitionContainer(screen: MainPage(newIndex: 0,))));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
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
                  Image.asset('assets/images/dataFetching.png',width: deviceWidth * 0.7,),
            SizedBox(height: 30,),
            SizedBox(
              width: deviceWidth * 0.8,
              child: Text('Please wait while we configure the app',
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
            
            const SpinKitThreeBounce(
              color: Color.fromARGB(108, 255, 255, 255),
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}