import 'dart:ffi';

import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationValue = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                          color: const Color.fromARGB(255, 201, 201, 201))),
                  child: const Icon(Icons.arrow_back),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0),
                    backgroundImage:
                        const AssetImage('assets/images/profile_avatar.png'),
                    radius: 25,
                  ),
                ),
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
                Switch(
                  value: notificationValue,
                  onChanged: (value) {
                    setState(() {
                      notificationValue = value;
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Edit Profile",
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
            const Text(
              'arnab.ghsoh2021@vitstudent.ac.in',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Q-1249 Vajpayee Block',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 84, 81, 214),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Speical Mess - Bubby & Bit',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 84, 81, 214),
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Developers",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0),
                      backgroundImage: const AssetImage(
                          'assets/images/developers_avatar.png'),
                      radius: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Sabyajeet Sing Greewal',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/github_logo.png',
                      width: 38,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/LinkedIn_logo.png',
                      width: 38,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0),
                      backgroundImage: const AssetImage(
                          'assets/images/developers_avatar.png'),
                      radius: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Arnab Ghosh',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/github_logo.png',
                      width: 38,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/LinkedIn_logo.png',
                      width: 38,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0),
                      backgroundImage: const AssetImage(
                          'assets/images/developers_avatar.png'),
                      radius: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Joyal Shine',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/github_logo.png',
                      width: 38,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/LinkedIn_logo.png',
                      width: 38,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0),
                      backgroundImage: const AssetImage(
                          'assets/images/developers_avatar.png'),
                      radius: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Madavan Annamalai',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/github_logo.png',
                      width: 38,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/LinkedIn_logo.png',
                      width: 38,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
