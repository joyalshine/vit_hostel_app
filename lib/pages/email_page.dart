import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key, required this.nextScreen});

  final void Function() nextScreen;

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      children: [
        SizedBox(
          height: _deviceHeight * 0.30,
          child: Padding(
            padding: EdgeInsets.only(
                left: _deviceWidth * 0.07,
                right: _deviceWidth * 0.07,
                bottom: _deviceHeight * 0.00,
                top: _deviceHeight * 0.07),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  "Effortless Complaints, Maintenance, and Menus for a Better Stay!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _deviceHeight * 0.70,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 35),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: GoogleFonts.poppins(
                    fontSize: 24.33,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(182, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email Here...',
                    prefixIcon: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey,
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade200.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.2), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: nextScreen,
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
                  child: const Text(
                    'Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.92,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Text(
                "Use VIT mail ID only",
                style: GoogleFonts.poppins(
                  fontSize: 14.33,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(118, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
