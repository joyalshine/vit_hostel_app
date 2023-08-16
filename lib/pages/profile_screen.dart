import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  Box userDetails = Hive.box('userDetails');
  String name(){
    return userDetails.get('name') ?? '';
  }
  String regno(){
    return userDetails.get('regno') ?? '';
  }
  String email(){
    return userDetails.get('email') ?? '';
  }
  String hostel(){
    String block = userDetails.get('block') ?? '';
    int room = userDetails.get('room') ?? '';
    return '$room $block';
  }
  String mess(){
    return userDetails.get('mess') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF5451D6),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(1000),
                    bottomLeft: Radius.circular(1000),
                    topLeft: Radius.circular(1000),
                    topRight: Radius.circular(1000)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 50.0,
                    minRadius: 50.0,
                    backgroundColor: const Color.fromARGB(255, 251, 254, 255),
                    backgroundImage: AssetImage("assets/images/profile_avatar.png"),
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(height: 3,),
                      Text(
                        'Reg no: ' + regno(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 15.0, color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile_at_icon.png",
                          width: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'EMail Id',
                              style: TextStyle(
                                color: Color.fromARGB(152, 28, 48, 94),
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              email(),
                              style: TextStyle(
                                color: Color(0xFF1C305E),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile_hostel_icon.png",
                          width: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hostel',
                              style: TextStyle(
                                color: Color.fromARGB(152, 28, 48, 94),
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              hostel(),
                              style: TextStyle(
                                color: Color(0xFF1C305E),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/mess_icon.png",
                          width: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mess',
                              style: TextStyle(
                                color: Color.fromARGB(152, 28, 48, 94),
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              mess(),
                              style: TextStyle(
                                color: Color(0xFF1C305E),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
