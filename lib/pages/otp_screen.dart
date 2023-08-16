import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {super.key, required this.nextScreen, required this.backScreen,required this.otp, required this.email, required this.userDetails});

  final void Function() nextScreen;
  final void Function() backScreen;
  final int otp;
  final String email;
  final Map<String,dynamic> userDetails;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;
  final List<TextEditingController> inputControllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];


  void validateOTP() async{
    setState(() {
      _isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    String enteredOTP = inputControllers[0].text + inputControllers[1].text + inputControllers[2].text + inputControllers[3].text;
    if(enteredOTP.isEmpty || enteredOTP == ''){
      const snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin:  EdgeInsets.only(bottom: 15,left: 5,right: 5),
            backgroundColor: Color.fromARGB(255, 223, 57, 19),
            content: Text('Enter the OTP!'),
          );

          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if(enteredOTP !=  widget.otp.toString()){
      const snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin:  EdgeInsets.only(bottom: 15,left: 5,right: 5),
            backgroundColor: Color.fromARGB(255, 69, 69, 83),
            content: Text('Invalid OTP!'),
          );

          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn',true);
      widget.nextScreen();
    }
  }



  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double deviceWidth = queryData.size.width;
    double deviceHeight = queryData.size.height;

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ElevatedButton(
            onPressed: widget.backScreen,
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(10, 20)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
            // padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.arrow_back,
              color: (Color.fromARGB(255, 247, 247, 247)),
            ),
          ),
        ),
        Container(
          height: deviceHeight * 0.25,
          padding: EdgeInsets.only(
            left: deviceWidth * 0.07,
            right: deviceWidth * 0.07,
          ),
          child: Image.asset(
            'assets/images/otp-icon.png',
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromARGB(18, 245, 245, 245),
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              margin: const EdgeInsets.only(top: 0, left: 40, right: 40),
              child: Column(children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Enter OTP",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "An 4 digit code has been sent to",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.email,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 56,
                        height: 56,
                        child: TextField(
                          controller: inputControllers[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          cursorColor: const Color.fromARGB(134, 105, 110, 110),
                          onChanged: (value) => {
                            if (value.length == 1 && index <= 5)
                              {
                                FocusScope.of(context).nextFocus(),
                              }
                            else if (value.isEmpty && index > 0)
                              {
                                FocusScope.of(context).previousFocus(),
                              }
                          },
                          cursorHeight: 17,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200.withOpacity(0.2),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200.withOpacity(0.2), width: 1.0),
                            ),
                            
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color.fromARGB(255, 40, 105, 180), width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: _isLoading? null : validateOTP,
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      const Color.fromARGB(0, 255, 193, 7),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 30.0, minHeight: 50.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0x6e8f6ad0), Color(0x996539b3)],
                        stops: [0, 1],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: _isLoading? const Center(child: CircularProgressIndicator(strokeWidth: 3,),) : const Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.92,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't received the otp ?",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(183, 255, 255, 255),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        " Resend OTP",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
