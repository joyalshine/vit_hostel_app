import 'package:flutter/material.dart';

class screen1 extends StatelessWidget {
  const screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 330,
            child: Text(
                "Effortless Complaints, Maintenance, and Menus for a Better Stay!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24,
                )),
          ),
          Image.asset(
            'assets/images/login-icon.png',
          ),
          Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(44, 245, 245, 245),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(children: [
                    const Text("Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 40.33,
                        )),
                    const Text("Use VIT mail ID only",
                        style: TextStyle(
                          color: Color.fromARGB(78, 255, 255, 255),
                          fontSize: 14.33,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Color.fromARGB(78, 255, 255, 255),
                        fontSize: 14.33,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(
                                      90, 255, 255, 255)), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(78, 255, 255, 255),
                              fontSize: 14.33,
                            ),
                            hintText: "Enter the name"),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    OutlinedButton(
                      onPressed: () {},
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
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
