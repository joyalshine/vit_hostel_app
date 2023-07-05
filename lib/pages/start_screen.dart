import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.nextScreen});

  final void Function() nextScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 90,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text(
                  "Effortless Complaints, Maintenance, and Menus for a Better Stay!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/login-icon.png',
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(18, 245, 245, 245),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Column(children: [
                Text(
                  "Welcome back",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
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
                  width: 370,
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
                  width: 390,
                  child: OutlinedButton(
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
      ),
    );
  }
}
