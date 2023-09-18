import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_hostel_repo/firebase/initial_data_fetch.dart';
import 'package:vit_hostel_repo/firebase/user_validation.dart';
import 'package:vit_hostel_repo/pages/fade_transition.dart';
import 'package:vit_hostel_repo/pages/login_page.dart';
import 'package:vit_hostel_repo/pages/main_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ImageProvider logo = const AssetImage("assets/images/VIT_Logo.png");
  Future<void> getLoggedInStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('loggedIn');
    if (loggedIn == null || loggedIn == false) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => LoginPage(
                    showError: false,
                  )));
    } else {
      List<String> months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      final date = DateTime.now();
      Box menuBox = Hive.box('messMenu');
      Box complaintBox = Hive.box('complaints');
      Box boxUserDetails = Hive.box('userDetails');
      final messType = boxUserDetails.get('messType');
      String key =
          months[date.month - 1] + date.year.toString() + '-' + messType;
      final bool maintenancePending =
          complaintBox.get('maintenancePending') ?? false;
      final bool messPending = complaintBox.get('messPending') ?? false;
      final bool disciplinePending =
          complaintBox.get('disciplinePending') ?? false;
      final bool cleaningPending = complaintBox.get('cleaningPending') ?? false;
      var currHiveMonth = menuBox.get('month');

      var newUserDetailsResponse =
          await fetchUserDetails(boxUserDetails.get('email'));
      if (newUserDetailsResponse['isValid']) {
        var details = newUserDetailsResponse['details'];
        boxUserDetails.put('name', details['name']);
        boxUserDetails.put('email', boxUserDetails.get('email'));
        boxUserDetails.put('regno', details['regno']);
        boxUserDetails.put('phone', details['phone']);
        boxUserDetails.put('block', details['block']);
        boxUserDetails.put('room', details['room']);
        boxUserDetails.put('mess', details['mess']);
        boxUserDetails.put('messType', details['messType']);
      } else {
        if(newUserDetailsResponse['type'] == 'invalidUser'){
          logout();
        }
        else{}
      }
      // if(currHiveMonth == null || currHiveMonth == '' || currHiveMonth != key){
      //   final Map<String,dynamic> menuFetchResponse = await fetchCurrentMenu(messType);
      //   if(menuFetchResponse['status']){
      //       final Map<String,dynamic> menuData = menuFetchResponse['data'];
      //       await menuBox.putAll(menuData);
      //       menuBox.put('month',menuFetchResponse['key']);
      //     }
      // }
      final Map<String, dynamic> menuFetchResponse =
          await fetchCurrentMenu(messType);
      if (menuFetchResponse['status']) {
        final Map<String, dynamic> menuData = menuFetchResponse['data'];
        await menuBox.putAll(menuData);
        menuBox.put('month', menuFetchResponse['key']);
      }

      if (maintenancePending) {
        print('Maintenance pending------------------');
        await updateMaintenancePending();
      }
      if (messPending) {
        print('Mess pending------------------');
        await updateMessPending();
      }
      if (disciplinePending) {
        print('Discipline pending------------------');
        await updateDisciplinePending();
      }
      if (cleaningPending) {
        print('Cleaning pending------------------');
        await updateCleaningPending();
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => FadeTransitionContainer(
                      screen: MainPage(
                    newIndex: 0,
                  ))));
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await Hive.box('userDetails').clear();
    await Hive.box('messMenu').clear();
    await Hive.box('complaints').clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (ctx) => FadeTransitionContainer(
                    screen: const LoginPage(
                  showError: false,
                ))));
  }

  @override
  void initState() {
    super.initState();
    getLoggedInStatus();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double deviceHeight = queryData.size.height;

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[200]),
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xffF7F8FA),
                  const Color(0xffDAE8F5).withOpacity(1),
                  const Color(0xffDAE8F5).withOpacity(1),
                  const Color(0xffDAE8F5).withOpacity(1),
                  const Color(0xffDBE9F6).withOpacity(1),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: logo,
                  width: 140,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Vellore Institute of Technology',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 99, 181),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.4,
                ),
                const SpinKitFadingCircle(
                  color: Color.fromARGB(255, 48, 192, 232),
                  size: 60.0,
                )
              ],
            ))),
      ),
    );
  }
}
