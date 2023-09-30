import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vit_hostel_repo/pages/data_fetching.dart';
import 'package:vit_hostel_repo/pages/email_page.dart';
import 'package:vit_hostel_repo/pages/otp_screen.dart';
import 'package:vit_hostel_repo/pages/start_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,required this.showError});

  final bool showError;
  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var activeScreen = 'start-screen';
  late int otpCode;
  late String userEmail;
  late String JWT;
  late Map<String,dynamic> userDetails;

  @override
  void initState() {
    super.initState();
    if(widget.showError){
      activeScreen = 'email-screen';
    }
  }

  void otpScreen(int otp, String email,Map<String,dynamic> details) {
    setState(() {
      otpCode = otp;
      userEmail = email;
      userDetails = details;
      activeScreen = 'otp-screen';
    });
  }

  void backScreen() {
    setState(() {
      activeScreen = 'email-screen';
    });
  }

  void dataFetchScreen() {
    setState(() {
      activeScreen = 'dataFetch-screen';
    });
  }

  void emailScreen() {
    setState(() {
      activeScreen = 'email-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(
      nextScreen: emailScreen,
    );

    if (activeScreen == "email-screen") {
      screenWidget = EmailScreen(
        nextScreen: otpScreen,
        showError: widget.showError,
      );
    }
    if (activeScreen == "otp-screen") {
      screenWidget = OtpScreen(
        nextScreen: dataFetchScreen,
        backScreen: backScreen,
        otp: otpCode,
        email: userEmail,
        userDetails: userDetails
      );
    }

    if (activeScreen == "dataFetch-screen") {
      screenWidget = DataFetchScreen(userDetails);
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
          extendBodyBehindAppBar: true,
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
