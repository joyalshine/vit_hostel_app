import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vit_hostel_repo/firebase/complaint_add_functions.dart';
import 'package:vit_hostel_repo/firebase/data_assets.dart';
import 'package:vit_hostel_repo/pages/profile_screen.dart';

class FoodComplaint extends StatefulWidget {
  const FoodComplaint({super.key});

  @override
  State<FoodComplaint> createState() => _FoodComplaintState();
}

class _FoodComplaintState extends State<FoodComplaint> {
  TextEditingController messController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Box userBox = Hive.box('userDetails');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messController.text = userBox.get('mess') ?? '';
  }

  bool complaintError = false;
  bool _isLoading = false;
  int remainingCharacters = 100;

  Future<Map<String, dynamic>> validateAndSave() async {
    setState(() {
      _isLoading = true;
    });
    String message = messageController.text;
    if (message == '' || message == null) {
      setState(() {
        complaintError = true;
      });
      setState(() {
        _isLoading = false;
      });
      return {'status': false, 'type': 'incdata'};
    } else {
      Box complaintBox = Hive.box('complaints');
      final isPending = complaintBox.get('messPending') ?? false;
      if (isPending) {
        setState(() {
          _isLoading = false;
        });
        return {'status': false, 'type': 'pendingexist'};
      } else {
        String email = userBox.get('email');
        String name = userBox.get('name');
        String regno = userBox.get('regno');
        Map<String, dynamic> dataToUpload = {
          'mess': messController.text,
          'name': name,
          'regno': regno,
          'status': 'pending',
          'studentEmail': email,
          'complainDesc': message
        };
        Map<String, dynamic> response = await addMessComplaint(dataToUpload);
        setState(() {
          _isLoading = false;
        });
        if (response['status']) {
          setState(() {
            remainingCharacters = 100;
          });
          messageController.clear();
        }
        return response;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
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
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15, top: 10),
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
                    "Food Complaint",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Mess",
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
                        controller: messController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing
                  Text(
                    "Complaint",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 95, 168, 227),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              complaintError ? Colors.red : Colors.transparent,
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
                  const SizedBox(height: 10), // Add spacing
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
                  SizedBox(height: 30),
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
                              backgroundColor: Color.fromARGB(255, 223, 57, 19),
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
                          } else if (response['type'] == 'pendingexist') {
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
          ]),
        ),
      ),
    ));
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
