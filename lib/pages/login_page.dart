import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vit_hostel_repo/pages/block_screen.dart';
import 'package:vit_hostel_repo/pages/final_screen.dart';
import 'package:vit_hostel_repo/pages/main_page.dart';
import 'package:vit_hostel_repo/pages/otp_screen.dart';
import 'package:vit_hostel_repo/pages/start_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'next-screen';
    });
  }

  void blockScreen() {
    setState(() {
      activeScreen = 'block-screen';
    });
  }

  void messScreen() {
    setState(() {
      activeScreen = 'final-screen';
    });
  }

  void homeScreen() {
    setState(() {
      activeScreen = 'home-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(
      nextScreen: switchScreen,
    );
    if (activeScreen == "next-screen") {
      screenWidget = OtpScreen(
        nextScreen: blockScreen,
      );
    }

    if (activeScreen == "block-screen") {
      screenWidget = BlockSreen(
        nextScreen: messScreen,
      );
    }

    if (activeScreen == "final-screen") {
      screenWidget = FinalScreen(
        nextScreen: homeScreen,
      );
    }

    if (activeScreen == "home-screen") {
      screenWidget = const MainPage();
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double _deviceWidth = queryData.size.width;
    double _deviceHeight = queryData.size.height;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
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
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(children: [
                Positioned(
                  left: _deviceWidth * 0.67,
                  bottom: -_deviceHeight * 0.1,
                  child: Image.asset(
                    "assets/images/background-image-2.png",
                    height: 200,
                  ),
                ),
                Positioned(
                  left: _deviceWidth * 0.73,
                  bottom: _deviceHeight * 0.2,
                  child: Image.asset(
                    "assets/images/background-image-1.png",
                    height: 200,
                  ),
                ),
                Positioned(
                  left: _deviceWidth * 0.5,
                  bottom: 0,
                  child: Image.asset(
                    "assets/images/Ellipse-1.png",
                    height: 400,
                  ),
                ),
                Container(
                  child: screenWidget,
                )
              ]),
            ),
          )),
    );
  }
}
