import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quickalert/quickalert.dart';

import '../firebase/complaint_add_functions.dart';

class CleaningComplaint extends StatefulWidget {
  const CleaningComplaint({super.key});

  @override
  State<CleaningComplaint> createState() => _CleaningComplaintState();
}

class _CleaningComplaintState extends State<CleaningComplaint> {
  Box userBox = Hive.box('userDetails');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blockTextController.text = userBox.get('block');
    roomTextController.text = userBox.get('room').toString();
  }
  TextEditingController blockTextController = TextEditingController();

  TextEditingController roomTextController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  

  bool roomIsChecked = false;
  bool generalsChecked = false;
  bool indianToiletIsChecked = false;
  bool westernToiletIsChecked = false;
  bool purifierAreaIsChecked = false;
  bool bathroomsIsChecked = false;

  bool complaintError = false;
  bool cleaningOfError = false;
  bool _isLoading = false;
  int remainingCharacters = 100;

  int cleaningOfCount = 0;
  List<int> cleaningOfSelected = [];

  void checkCleaningOfCurrent(){
    if(cleaningOfCount >= 2){
      cleaningOfCount--;
      if(cleaningOfSelected[0] == 0) setState(() => roomIsChecked = false);
      if(cleaningOfSelected[0] == 1) setState(() => generalsChecked = false);
      if(cleaningOfSelected[0] == 2) setState(() => indianToiletIsChecked = false);
      if(cleaningOfSelected[0] == 3) setState(() => westernToiletIsChecked = false);
      if(cleaningOfSelected[0] == 4) setState(() => purifierAreaIsChecked = false);
      if(cleaningOfSelected[0] == 5) setState(() => bathroomsIsChecked = false);
      cleaningOfSelected.removeAt(0);
    }
  }

 Future<bool> validateAndSave() async{
    setState(() {
      _isLoading = true;
    });
    String message = messageController.text;
    List<String> cleaningOf = [];
    bool errors = false;
    if(roomIsChecked) cleaningOf.add('room');
    if(generalsChecked) cleaningOf.add('general');
    if(purifierAreaIsChecked) cleaningOf.add('purifier');
    if(westernToiletIsChecked) cleaningOf.add('western');
    if(indianToiletIsChecked) cleaningOf.add('indian');
    if(bathroomsIsChecked) cleaningOf.add('bathroom');
    if(cleaningOf.isEmpty){
      errors = true;
      setState(() {
        cleaningOfError = true;
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
        'category' : cleaningOf,
        'complaint' : message
      };
      bool response  = await addCleaningRequest(dataToUpload);
      setState(() {
        _isLoading = false;
      }); 
      if(response){
        if(roomIsChecked) setState(() => roomIsChecked = false);
        if(generalsChecked) setState(() => generalsChecked = false);
        if(purifierAreaIsChecked) setState(() => purifierAreaIsChecked = false);
        if(westernToiletIsChecked) setState(() => westernToiletIsChecked = false);
        if(indianToiletIsChecked) setState(() => indianToiletIsChecked = false);
        if(bathroomsIsChecked) setState(() => bathroomsIsChecked = false);
        setState(() {
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
          child: SizedBox(
            
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
                            icon: const Icon(
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
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0),
                        backgroundImage:
                            const AssetImage('assets/images/profile_avatar.png'),
                        radius: 25,
                      ),
                    ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 125,
                    left: 25,
                    right: 35,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cleaning Request",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
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
                          color: Color.fromARGB(255, 239, 239, 255),
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: blockTextController,
                            readOnly: true,
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
                          color: Color.fromARGB(255, 239, 239, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: roomTextController,
                            readOnly: true,
                            decoration:const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Cleaning of",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 95, 168, 227),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Room",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: roomIsChecked,
                                      activeColor: Colors.blue,
                                      checkColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      onChanged: (newValue) {
                                        checkCleaningOfCurrent();
                                        cleaningOfCount++;
                                        cleaningOfSelected.add(0);
                                        setState(() {
                                          roomIsChecked = newValue!;
                                        });
                                        if(cleaningOfError) cleaningOfError = false;
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "General",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Checkbox(
                                    value: generalsChecked,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    onChanged: (newValue) {
                                        checkCleaningOfCurrent();
                                        cleaningOfCount++;
                                        cleaningOfSelected.add(1);
                                        setState(() {
                                          generalsChecked = newValue!;
                                        });
                                      },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Indian Toilets",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),// Add this line to create space
                                  Checkbox(
                                    value: indianToiletIsChecked,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    onChanged: (newValue) {
                                        checkCleaningOfCurrent();
                                        cleaningOfCount++;
                                        cleaningOfSelected.add(2);
                                        setState(() {
                                          indianToiletIsChecked = newValue!;
                                        });
                                      },
                                  ),
                                ],
                              ),
                                ],
                              ),
                            ),
                            Expanded(child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Western Toilets",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Checkbox(
                                    value: westernToiletIsChecked,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    onChanged: (newValue) {
                                        checkCleaningOfCurrent();
                                        cleaningOfCount++;
                                        cleaningOfSelected.add(3);
                                        setState(() {
                                          westernToiletIsChecked = newValue!;
                                        });
                                      },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Purifier Area",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Checkbox(
                                    value: purifierAreaIsChecked,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    onChanged: (newValue) {
                                        checkCleaningOfCurrent();
                                        cleaningOfCount++;
                                        cleaningOfSelected.add(4);
                                        setState(() {
                                          purifierAreaIsChecked = newValue!;
                                        });
                                      },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Bathrooms",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Checkbox(
                                    value: bathroomsIsChecked,
                                    activeColor: Colors.lightBlue,
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    onChanged: (newValue) {
                                        checkCleaningOfCurrent();
                                        cleaningOfCount++;
                                        cleaningOfSelected.add(5);
                                        setState(() {
                                          bathroomsIsChecked = newValue!;
                                        });
                                      },
                                  ),
                                ],
                              ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      cleaningOfError ? Text(
                        'Please Select a type',
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ) : 
                      SizedBox(),
                      const SizedBox(height: 15), // Adjusted the spacing
                      const Text(
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
      ),
    );
  }
}
