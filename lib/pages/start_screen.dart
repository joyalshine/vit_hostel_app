import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.nextScreen});

  final void Function() nextScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, bottom: 8.0, top: 40.0),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "Effortless Complaints, Maintenance, and Menus for a Better Stay!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image.asset(
            'assets/images/login-icon.png',
            height: 250,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 35),
            decoration: BoxDecoration(
                color: const Color.fromARGB(18, 245, 245, 245),
                borderRadius: BorderRadius.circular(30.0)),
            child: Column(children: [
              // const SizedBox(
              //   height: 20,
              // ),
              Text(
                "Welcome back",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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
              const SizedBox(
                height: 30,
              ),
              Text(
                "Email",
                style: GoogleFonts.poppins(
                  fontSize: 14.33,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(182, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email Here...',
                    prefixIcon: const Icon(
                      Icons.account_circle_sharp,
                      color: Colors.grey,
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade200.withOpacity(0.2),
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
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
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
                      constraints:
                          const BoxConstraints(minWidth: 30.0, minHeight: 50.0),
                      alignment: Alignment.center,
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
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
