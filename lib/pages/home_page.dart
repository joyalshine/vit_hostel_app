import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vit_hostel_repo/pages/Maintenance_complaint.dart';
import 'package:vit_hostel_repo/pages/cleaning_complaint.dart';
import 'package:vit_hostel_repo/pages/detail_mess.dart';
import 'package:vit_hostel_repo/pages/discipline_complaint.dart';
import 'package:vit_hostel_repo/pages/food_complaint.dart';


String getFormattedDate() {
  final date = DateTime.now();
  const List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday'];
  const List<String> months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  
  return days[date.weekday-1] + " " + months[date.month - 1] + " " + date.day.toString() + ", " + date.year.toString();
}


class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late String welcomeText;
   Map<String,String> menu = {
    'type' : '',
    'menu' : '',
    'time': ''  
  };
  bool menuAvailable = true;
  void fetchPageData(){
    final Box userBox= Hive.box('userDetails');
    final Box menuBox= Hive.box('messMenu');
    var name = userBox.get('name');
    welcomeText = "Welcome " + name.split(' ')[0]  + ',';

    final date = DateTime.now();
    dynamic todaysMenu;
    if(menuBox.get(date.day.toString()) == null){
      todaysMenu = {};
    }
    else{
      todaysMenu = menuBox.get(date.day.toString());
    }
    if(todaysMenu.isNotEmpty){
      String menuOf = '';
      int currMinutes = date.hour * 60 + date.minute;
      if(currMinutes < 571){
        menuOf = 'breakfast';
      } 
      else if(currMinutes < 871){
        menuOf = 'lunch';
      }
      else if(currMinutes < 1081){
        menuOf = 'snacks';
      }
      else if(currMinutes < 1261){
        menuOf = 'dinner';
      }
      else{
        menuOf = 'closed';
      }

      menuOf == 'breakfast' ? menu = {
        'type' : 'Breakfast',
        'menu' : todaysMenu['breakfast']!,
        'time' : '7:00 AM to 9:00 AM'
      } :
      menuOf == 'lunch' ? menu = {
        'type' : 'Lunch',
        'menu' : todaysMenu['lunch']!,
        'time' : '12:30 PM to 2:30 PM'
      } :
      menuOf == 'snacks'? menu = {
        'type' : 'Snacks',
        'menu' : todaysMenu['snacks']!,
        'time' : '4:00 PM to 6:00 PM'
      } :
      menuOf == 'dinner'? menu = {
        'type' : 'Dinner',
        'menu' : todaysMenu['dinner']!,
        'time' : '7:00 PM to 9:00 PM'
      } : menu = {
        'type' : '',
        'menu' : 'Its too late. Dont worry night canteen is there',
        'time' : '10:30 PM to 12:30 AM'
      };
    } 
    else{
      menuAvailable = false;
      menu = {
        'type' : '',
        'menu' : 'Sorry data is not available',
        'time' : ''
      };
    }   
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPageData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
        
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      welcomeText,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff3156AC),
                          fontWeight: FontWeight.w700),
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
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Text(
                  getFormattedDate(),
                  style: TextStyle(),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: const Text(
                  'Mess Menu',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff1C305E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const DetailMessMenu()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 4, left: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: const Color(0xff5451D6),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 1, //New
                      )
                    ],
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: menuAvailable? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        menuAvailable ? Text(
                          menu['type']!,
                          style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ) : const SizedBox(),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                            menu['menu']!,
                            style: const TextStyle(
                              color: Color(0xffFFFFFF),
                            )),
                        const SizedBox(
                          height: 4,
                        ),
                        menuAvailable ? Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.timelapse_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                menu['time']!,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: const Text(
                  'Services and Complains',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff1C305E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async{
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const MaintenanceComplaint()));
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: const Color(0xff5451D6),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/maintenance-home-logo.png',
                                    width: 170,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Maintenance',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: const Color(0xff5451D6),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/images/attendence-home-logo.png',
                                    width: 90,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Attendence',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const CleaningComplaint()));
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 140
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: const Color(0xff5451D6),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/cleaning-home-logo.png',
                                    width: 110,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Cleaning',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FoodComplaint()));
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 155,
                              ),
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: const Color(0xff5451D6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/food-home-logo.png',
                                      width: 150,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Food',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const DisciplineComplaint()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3, left: 4, right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: const Color(0xff5451D6),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 1, //New
                      )
                    ],
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/discipline-home-logo.png',
                            width: 130,
                          ),
                        ),
                        const Text(
                          'Discipline',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      ]
    );
  }
}
