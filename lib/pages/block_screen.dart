import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockSreen extends StatelessWidget {
  BlockSreen({super.key, required this.nextScreen});

  final void Function() nextScreen;

  final List<String> blocks = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(top: 100),
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
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      "Select your Block and Room",
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Do not put wrong room and floor",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(141, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Block",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      children: List.generate(
                          16,
                          (index) => TextButton(
                                onPressed: () {},
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(142, 185, 185, 185),
                                        Color.fromARGB(149, 209, 209, 209)
                                      ],
                                      stops: [0, 1],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        minWidth: 30.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      blocks[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
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
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
