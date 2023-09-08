import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vit_hostel_repo/pages/profile_screen.dart';

import '../firebase/complaint_add_functions.dart';

class MaintenanceComplaint extends StatefulWidget {
  const MaintenanceComplaint({super.key});

  @override
  State<MaintenanceComplaint> createState() => _MaintenanceComplaintState();
}

class _MaintenanceComplaintState extends State<MaintenanceComplaint> {
  TextEditingController blockTextController =
      TextEditingController(text: 'Q Block');
  TextEditingController roomTextController =
      TextEditingController(text: '1249');
  TextEditingController messageController = TextEditingController();

  Box userBox = Hive.box('userDetails');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blockTextController.text = userBox.get('block');
    roomTextController.text = userBox.get('room').toString();
  }

  List<bool> mainteneanceOf = [false, false, false, false, false, false];

  final List<String> dropdownValues = [
    'Morning before 12',
    'Lunch Break',
    'After Lunch',
    'Other'
  ];
  String? availableTime;

  bool complaintError = false;
  bool mainteneanceOfError = false;
  bool availableTimeError = false;
  bool _isLoading = false;
  int remainingCharacters = 100;

  int mainteneanceOfCount = 0;
  List<int> mainteneanceOfSelected = [];

  void checkMaintenanceOfCurrent() {
    if (mainteneanceOfCount >= 2) {
      mainteneanceOfCount--;
      setState(() {
        mainteneanceOf[mainteneanceOfSelected[0]] = false;
      });
      mainteneanceOfSelected.removeAt(0);
    }
  }

  Future<Map<String, dynamic>> validateAndSave() async {
    setState(() {
      _isLoading = true;
    });
    String message = messageController.text;
    List<String> mainteneanceOfList = [];
    bool errors = false;
    if (mainteneanceOf[0]) mainteneanceOfList.add('ls');
    if (mainteneanceOf[1]) mainteneanceOfList.add('fn');
    if (mainteneanceOf[2]) mainteneanceOfList.add('sw');
    if (mainteneanceOf[3]) mainteneanceOfList.add('ac');
    if (mainteneanceOf[4]) mainteneanceOfList.add('cp');
    if (mainteneanceOf[5]) mainteneanceOfList.add('pg');
    if (mainteneanceOfList.isEmpty) {
      errors = true;
      setState(() {
        mainteneanceOfError = true;
      });
    }
    if (message == '' || message == null) {
      errors = true;
      setState(() {
        complaintError = true;
      });
    }
    if (availableTime == '' || availableTime == null) {
      errors = true;
      setState(() {
        availableTimeError = true;
      });
    }
    if (!errors) {
      String email = userBox.get('email');
      String name = userBox.get('name');
      String regno = userBox.get('regno');
      Map<String, dynamic> dataToUpload = {
        'block': blockTextController.text,
        'room': roomTextController.text,
        'name': name,
        'regno': regno,
        'status': 'pending',
        'studentEmail': email,
        'timestamp': FieldValue.serverTimestamp(),
        'category': mainteneanceOfList,
        'availableTime': availableTime,
        'complaint': message
      };
      Map<String, dynamic> response =
          await addMaintenanceComplaint(dataToUpload);
      setState(() {
        _isLoading = false;
      });
      if (response['status']) {
        for (int i = 0; i <= 5; i++) {
          setState(() => mainteneanceOf[i] = false);
        }
        setState(() {
          remainingCharacters = 100;
        });
        messageController.clear();
      }
      return response;
    } else {
      setState(() {
        _isLoading = false;
      });
      return {'status': false, 'type': 'incdata'};
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                const Color(0xffF7F8FA),
                const Color(0xffDAE8F5).withOpacity(1),
                const Color(0xffDAE8F5).withOpacity(1),
                const Color(0xffDAE8F5).withOpacity(1),
                const Color(0xffDBE9F6).withOpacity(1),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFDDE0F6),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black, // Arrow color
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => Profile()));
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.withOpacity(0),
                            backgroundImage: const AssetImage(
                                'assets/images/profile_avatar.png'),
                            radius: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    top: 35,
                    left: 25,
                    right: 35,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Maintenance Complaint",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Block",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 95, 168, 227),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDDE0F6),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 117, 116, 116),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            readOnly: true,
                            controller: blockTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Room No",
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 95, 168, 227),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDDE0F6),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 117, 116, 116),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            readOnly: true,
                            controller: roomTextController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Maintenance of",
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 95, 168, 227),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Lights",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Checkbox(
                                        value: mainteneanceOf[0],
                                        activeColor: Colors.blue,
                                        checkColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        onChanged: (newValue) {
                                          checkMaintenanceOfCurrent();
                                          mainteneanceOfCount++;
                                          mainteneanceOfSelected.add(0);
                                          setState(() {
                                            mainteneanceOf[0] = newValue!;
                                          });
                                          if (mainteneanceOfError)
                                            mainteneanceOfError = false;
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Fan",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Checkbox(
                                        value: mainteneanceOf[1],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        onChanged: (newValue) {
                                          checkMaintenanceOfCurrent();
                                          mainteneanceOfCount++;
                                          mainteneanceOfSelected.add(1);
                                          setState(() {
                                            mainteneanceOf[1] = newValue!;
                                          });
                                          if (mainteneanceOfError)
                                            mainteneanceOfError = false;
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Switch",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ), // Add this line to create space
                                      Checkbox(
                                        value: mainteneanceOf[2],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        onChanged: (newValue) {
                                          checkMaintenanceOfCurrent();
                                          mainteneanceOfCount++;
                                          mainteneanceOfSelected.add(2);
                                          setState(() {
                                            mainteneanceOf[2] = newValue!;
                                          });
                                          if (mainteneanceOfError)
                                            mainteneanceOfError = false;
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "AC",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: mainteneanceOf[3],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      onChanged: (newValue) {
                                        checkMaintenanceOfCurrent();
                                        mainteneanceOfCount++;
                                        mainteneanceOfSelected.add(3);
                                        setState(() {
                                          mainteneanceOf[3] = newValue!;
                                        });
                                        if (mainteneanceOfError)
                                          mainteneanceOfError = false;
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Carpentry",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: mainteneanceOf[4],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      onChanged: (newValue) {
                                        checkMaintenanceOfCurrent();
                                        mainteneanceOfCount++;
                                        mainteneanceOfSelected.add(4);
                                        setState(() {
                                          mainteneanceOf[4] = newValue!;
                                        });
                                        if (mainteneanceOfError)
                                          mainteneanceOfError = false;
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Painting",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: mainteneanceOf[5],
                                      activeColor: Colors.lightBlue,
                                      checkColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      onChanged: (newValue) {
                                        checkMaintenanceOfCurrent();
                                        mainteneanceOfCount++;
                                        mainteneanceOfSelected.add(5);
                                        setState(() {
                                          mainteneanceOf[5] = newValue!;
                                        });
                                        if (mainteneanceOfError)
                                          mainteneanceOfError = false;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      mainteneanceOfError
                          ? const Text(
                              'Please Select a type',
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      const Text(
                        "Available Time",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 95, 168, 227),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: availableTimeError
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 1.3),
                          color: Color.fromARGB(255, 239, 239, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 117, 116, 116),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          hint: const Text('Select the available time'),
                          padding: EdgeInsets.all(0),
                          value: availableTime,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 15,
                          isExpanded: true,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 239, 239, 255),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)))),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            if(availableTimeError){
                              setState(() {
                                availableTimeError = false;
                              });
                            }
                            setState(() {
                              availableTime = value ?? '';
                            });
                          },
                          items: dropdownValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      availableTimeError
                          ? const Text(
                              'Please Select a type',
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20), // Adjusted the spacing
                      const Text(
                        "Complaint",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 95, 168, 227),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: complaintError
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 1.3),
                          color: Color.fromARGB(255, 239, 239, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 117, 116, 116),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Form(
                            child: TextFormField(
                              controller: messageController,
                              maxLines: 5,
                              maxLength: 100,
                              onChanged: (value) {
                                if (complaintError) {
                                  complaintError = false;
                                }
                                setState(() {
                                  remainingCharacters = 100 - value.length;
                                });
                              },
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: "Enter your complaint",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing
                      Align(
                        alignment: complaintError
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                        child: complaintError
                            ? const Text(
                                "Please enter a message",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              )
                            : Text(
                                "$remainingCharacters Characters left",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: remainingCharacters < 20
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                      ),

                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            var response = await validateAndSave();
                            if (response['status']) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Request submitted Successfully!',
                              );
                              FocusManager.instance.primaryFocus?.unfocus();
                            } else {
                              if (response['type'] == 'someerr') {
                                const snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                      bottom: 15, left: 5, right: 5),
                                  backgroundColor:
                                      Color.fromARGB(255, 223, 57, 19),
                                  content: Text('Some error ocurred'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (response['type'] == 'noconn') {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => NetworkErrorDialog(),
                                );
                              }else if (response['type'] == 'pendingexist') {
                                QuickAlert.show(
                                context: context,
                                type: QuickAlertType.info,
                                text: 'A Request already exists!',
                              );
                              } else {}
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 2, 109, 197),
                            onPrimary: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            fixedSize: Size.fromWidth(deviceWidth * 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 200, child: Image.asset('assets/images/no_internet.webp')),
          const SizedBox(height: 32),
          const Text(
            "Whoops!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "No internet connection found.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            "Check your connection and try again.",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
