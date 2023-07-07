import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  String dropdownValue = "Speical Mess";

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
              child: Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
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
          Expanded(
            flex: 3,
            child: Container(
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
                    "Just one more to go",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter the Room number ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 370,
                    child: TextField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Room number Here...',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 51, 47, 47),
                        ),
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
                    height: 20,
                  ),
                  Text(
                    "Select Mess Type ",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.grey.shade200.withOpacity(0.2),
                            width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(12),
                        value: dropdownValue,
                        items: const [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "Speical Mess",
                            child: Text("Speical Mess"),
                          ),
                          DropdownMenuItem(
                            value: "Veg Mess",
                            child: Text("Veg Mess"),
                          ),
                          DropdownMenuItem(
                            value: "Non-Veg Mess",
                            child: Text("Non-Veg Mess"),
                          )
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            top: 18,
                            bottom: 18,
                          ),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                        iconEnabledColor: Colors.white, //Icon color
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 51, 47, 47),
                        ),

                        dropdownColor: Colors.grey.shade200,
                        underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    child: TextButton(
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
