import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vit_hostel_repo/firebase/complaint_add_functions.dart';

class DisciplineComplaint extends StatefulWidget {
  const DisciplineComplaint({super.key});

  @override
  State<DisciplineComplaint> createState() => _DisciplineComplaintState();
}

class _DisciplineComplaintState extends State<DisciplineComplaint> {
  TextEditingController blockTextController = TextEditingController();
  TextEditingController roomTextController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Box userBox = Hive.box('userDetails');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blockTextController.text = userBox.get('block');
    roomTextController.text = userBox.get('room').toString();
  }

  List<bool> regarding = [false,false,false,false,false];

  bool complaintError = false;
  bool regardingError = false;
  bool _isLoading = false;
  int remainingCharacters = 100;

  int? regardingSelected;

  void clearRegardingCurrent(){
    if(regardingSelected != null){
      setState(() {
        regarding[regardingSelected!] = false;
      });
    }
  }

  Future<bool> validateAndSave() async{
    setState(() {
      _isLoading = true;
    });
    String message = messageController.text;
    String regardingData = '';
    bool errors = false;
    if(regarding[0]){regardingData='smoking';} 
    else if(regarding[1]){regardingData='substance';} 
    else if(regarding[2]){regardingData='disturbance';} 
    else if(regarding[3]){regardingData='alcohol';} 
    else if(regarding[4]){regardingData='others';} 
    else{
      errors = true;
      setState(() {
        regardingError = true;
      });
    }
    if(message == '' || message == null){
      errors = true;
      setState(() {
        complaintError = true;
      });
    }
    if(!errors){
      String email = userBox.get('email');
      Map<String,dynamic> dataToUpload = {
        'block' : blockTextController.text,
        'room' : roomTextController.text,
        'studentEmail' : email,
        'timestamp' : FieldValue.serverTimestamp(),
        'category' : regardingData,
        'complaint' : message
      };
      bool response  = await addDisciplineComplaint(dataToUpload);
      setState(() {
        _isLoading = false;
      }); 
      if(response){
        setState(() {
          regarding[regardingSelected!] = false;
          remainingCharacters = 100;
        });
        messageController.clear();
      }
      return response;
    }
    else{
      setState(() {
        _isLoading = false;
      });
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
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
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 20,
                right: 20,
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
                    Image.asset(
                      "assets/images/av.png",
                      width: 60,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                  top: 125,
                  left: 25,
                  right: 35,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discipline Complaint",
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
                      "Regarding",
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 119, 145, 216),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Smoking",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: regarding[0],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (newValue) {
                            clearRegardingCurrent();
                            regardingSelected = 0;
                            setState(() {
                              regarding[0] = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Use of Substance abuse",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: regarding[1],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (newValue) {
                            clearRegardingCurrent();
                            regardingSelected = 1;
                            setState(() {
                              regarding[1] = newValue!;
                            });
                            if(regardingError){
                              setState(() {
                                regardingError = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Disturbance",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: regarding[2],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (newValue) {
                            clearRegardingCurrent();
                            regardingSelected = 2;
                            setState(() {
                              regarding[2] = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Alcohol",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: regarding[3],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (newValue) {
                            clearRegardingCurrent();
                            regardingSelected = 3;
                            setState(() {
                              regarding[3] = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Others",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: regarding[4],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (newValue) {
                            clearRegardingCurrent();
                            regardingSelected = 4;
                            setState(() {
                              regarding[4] = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    regardingError ? Text(
                        'Please Select a type',
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ) : 
                      SizedBox(),
                    SizedBox(height: 10), // Adjusted the spacing
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
                          border: Border.all(color: complaintError ?  Colors.red : Colors.transparent,width: 1.3) ,
                          color: Color.fromARGB(255, 239, 239, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 117, 116, 116),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0,2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Form(
                            child: TextFormField(
                              controller: messageController,
                              maxLines: 5,
                              maxLength: 100,
                              onChanged: (value){
                                if(complaintError){
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
                        alignment: complaintError ? Alignment.bottomLeft : Alignment.bottomRight,
                        child: complaintError ? const Text(
                          "Please enter a message",
                          style: TextStyle(
                            fontSize: 12,
                            color:  Colors.red,
                          ),
                        ) :
                         Text(
                          "$remainingCharacters Characters left",
                          style: TextStyle(
                            fontSize: 12,
                            color: remainingCharacters < 20 ? Colors.red :  Colors.grey,
                          ),
                        ),
                      ),
                    SizedBox(height: 20), // Adjusted the spacing

                    Row(
                      children: [
                        Text(
                          "Disclaimer: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Your Identity will not be disclosed under any circumstances",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async{
                            if(await validateAndSave()){
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Request submitted Successfully!',
                                );
                                FocusManager.instance.primaryFocus?.unfocus();
                            } 
                            else{
                              const snackBar = SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin:  EdgeInsets.only(bottom: 15,left: 5,right: 5),
                                backgroundColor: Color.fromARGB(255, 223, 57, 19),
                                content: Text('Some error ocurred'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 2, 109, 197),
                            onPrimary: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15 ),
                            fixedSize: Size.fromWidth(deviceWidth * 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading ? Center(
                            child: CircularProgressIndicator(strokeWidth: 3,),
                          ) : 
                          Text(
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
    );
  }
}
