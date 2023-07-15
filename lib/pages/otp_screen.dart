import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.nextScreen});

  final void Function() nextScreen;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double _deviceWidth = queryData.size.width;
    double _deviceHeight = queryData.size.height;

    return Column(
      children: [
        Container(
          height: _deviceHeight * 0.05,
          padding: EdgeInsets.only(
              left: _deviceWidth * 0.07,
              right: _deviceWidth * 0.9,
              bottom: _deviceHeight * 0.00,
              top: _deviceHeight * 0.07),
          child: const Icon(Icons.arrow_back),
        ),
        Container(
          height: _deviceHeight * 0.35,
          padding: EdgeInsets.only(
              left: _deviceWidth * 0.07,
              right: _deviceWidth * 0.07,
              bottom: _deviceHeight * 0.00,
              top: _deviceHeight * 0.07),
          child: Image.asset(
            'assets/images/otp-icon.png',
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromARGB(18, 245, 245, 245),
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              margin: const EdgeInsets.only(top: 0, left: 40, right: 40),
              child: Column(children: [
                const SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                Text(
                  "An 4 digit code has been sent to arnab.ghsoh2021@gmail.com",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        4,
                        (index) => SizedBox(
                              width: 56,
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                cursorColor:
                                    const Color.fromARGB(137, 27, 27, 26),
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
                                style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Colors.grey.shade200.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    focusColor:
                                        Colors.grey.shade200.withOpacity(0.2),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.2),
                                      ),
                                    )),
                              ),
                            )),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: nextScreen,
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xfff44336), Color(0xff3d4eaf)],
                          stops: [0, 1],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 30.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: const Text(
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
                  ),
                ),
                const SizedBox(
                  height: 10,
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
