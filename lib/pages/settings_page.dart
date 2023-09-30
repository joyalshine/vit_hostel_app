import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_hostel_repo/firebase/firebase_notifications.dart';
import 'package:vit_hostel_repo/pages/fade_transition.dart';
import 'package:vit_hostel_repo/pages/login_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationAccess = true;
  bool _isLoading = false;
  bool _notificationLoading = false;
  final Box boxUserDetails = Hive.box('userDetails');

  void notificationPermission() {
    bool status = boxUserDetails.get('notificationStatus') ?? false;
    setState(() {
      notificationAccess = status;
    });
  }

  void turnOffNotification() async {
    String email = boxUserDetails.get('email');
    bool response = await turnOffFCMDatabase(email: email);
    if (response) {
      setState(() {
        notificationAccess = false;
      });
    } else {
      const snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
        backgroundColor: Color.fromARGB(255, 223, 57, 19),
        duration: Duration(seconds: 10),
        content: Text('Some error occured'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      _notificationLoading = false;
    });
  }

  void turnOnNotification() async {
    String email = boxUserDetails.get('email');
    bool response = await FirebaseNotifications().initNotifications(email);
    if (response) {
      setState(() {
        notificationAccess = true;
      });
    } else {
      const snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
        backgroundColor: Color.fromARGB(255, 223, 57, 19),
        duration: Duration(seconds: 10),
        content: Text('Some error occured'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      _notificationLoading = false;
    });
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.setString('JWT', 'null');
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
    notificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Container(
                //   margin: const EdgeInsets.only(left: 10, top: 5),
                //   padding: const EdgeInsets.all(6),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(11),
                //       border: Border.all(
                //           color: const Color.fromARGB(255, 201, 201, 201))),
                //   child: const Icon(Icons.arrow_back),
                // ),
                Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: ElevatedButton(
                        onPressed: _isLoading ? null : logout,
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text('Logout'))),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 27,
                  color: Color(0xff1C305E),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Notifications",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff1C305E),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 119, 145, 216),
              thickness: 1.2,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Allow Notifications',
                  style: TextStyle(fontSize: 16),
                ),
                _notificationLoading
                    ? const SizedBox(
                        width: 47,
                        height: 47,
                        child: Padding(
                          padding: EdgeInsets.all(9.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      )
                    : Switch(
                        value: notificationAccess,
                        onChanged: (value) {
                          setState(() {
                            _notificationLoading = true;
                          });
                          if (value) {
                            turnOnNotification();
                          } else {
                            turnOffNotification();
                          }
                        },
                      )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Info",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff1C305E),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 119, 145, 216),
              thickness: 1.2,
            ),
            const SizedBox(
              height: 6,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: Colors.blue.withOpacity(0),
            //           backgroundImage: const AssetImage(
            //               'assets/images/developers_avatar.png'),
            //           radius: 24,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         const Text(
            //           'Sabyajeet Sing Greewal',
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Image.asset(
            //           'assets/images/github_logo.png',
            //           width: 38,
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Image.asset(
            //           'assets/images/LinkedIn_logo.png',
            //           width: 38,
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: Colors.blue.withOpacity(0),
            //           backgroundImage: const AssetImage(
            //               'assets/images/developers_avatar.png'),
            //           radius: 24,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         const Text(
            //           'Arnab Ghosh',
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Image.asset(
            //           'assets/images/github_logo.png',
            //           width: 38,
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Image.asset(
            //           'assets/images/LinkedIn_logo.png',
            //           width: 38,
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: Colors.blue.withOpacity(0),
            //           backgroundImage: const AssetImage(
            //               'assets/images/developers_avatar.png'),
            //           radius: 24,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         const Text(
            //           'Joyal Shine',
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Image.asset(
            //           'assets/images/github_logo.png',
            //           width: 38,
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Image.asset(
            //           'assets/images/LinkedIn_logo.png',
            //           width: 38,
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: Colors.blue.withOpacity(0),
            //           backgroundImage: const AssetImage(
            //               'assets/images/developers_avatar.png'),
            //           radius: 24,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         const Text(
            //           'Madavan Annamalai',
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Image.asset(
            //           'assets/images/github_logo.png',
            //           width: 38,
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Image.asset(
            //           'assets/images/LinkedIn_logo.png',
            //           width: 38,
            //         ),
            //       ],
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
