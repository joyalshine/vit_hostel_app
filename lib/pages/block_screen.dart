import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockSreen extends StatefulWidget {
  const BlockSreen({super.key, required this.nextScreen});

  final void Function() nextScreen;

  @override
  State<BlockSreen> createState() => _BlockSreenState();
}

class _BlockSreenState extends State<BlockSreen> {
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

  bool onChanged = false;
  var selectedIndex = -1;

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
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Do not put wrong room and floor",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(141, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
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
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = index;
                                    // onChanged = true;
                                  });
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: (selectedIndex != index)
                                        ? const LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  142, 185, 185, 185),
                                              Color.fromARGB(149, 209, 209, 209)
                                            ],
                                            stops: [0, 1],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )
                                        : const LinearGradient(
                                            colors: [
                                              Color(0xff784cc6),
                                              Color(0xff8f6ad0)
                                            ],
                                            stops: [0, 1],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
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
                    child: TextButton(
                      onPressed: widget.nextScreen,
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
