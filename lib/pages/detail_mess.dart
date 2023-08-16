import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vit_hostel_repo/firebase/initial_data_fetch.dart';
import 'package:vit_hostel_repo/pages/profile_screen.dart';

class DetailMessMenu extends StatefulWidget {
  const DetailMessMenu({super.key});

  @override
  State<DetailMessMenu> createState() => _DetailMessMenuState();
}

class _DetailMessMenuState extends State<DetailMessMenu>
    with TickerProviderStateMixin {

  final List<Map<String, dynamic>> details = [];
  late int noOfDays;

  void loadMessData(){
    final Box menuBox= Hive.box('messMenu');
    List<String> months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    List<String> days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    final date = DateTime.now();
    int year = date.year;
    int month = date.month;
    String key = months[month - 1] + year.toString();
    if(menuBox.get('month') == key){
      int endDate = monthDaysCount[month]!;
      if(month == 2){
        if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
          endDate= 29;
        }
      }
      noOfDays = endDate;
      for(int i=1;i<=endDate;i++){
        var menu = menuBox.get(i.toString());
        Map<String, dynamic> temp;
        if(menu == null){
          temp = {
          "date": i.toString(),
          "day": days[DateTime(year, month, i).weekday - 1],
          "exists" : false
        };
        }
        else{
          temp = {
          "date": i.toString(),
          "day": days[DateTime(year, month, i).weekday - 1],
          "exists" : true,
          "breakfast": menu['breakfast'] ?? '',
          "lunch":  menu['lunch'] ?? '',
          "snacks": menu['snacks'] ?? '',
          "dinner": menu['dinner'] ?? ''
        };
        }
        details.add(temp);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadMessData();
  }

  @override
  Widget build(BuildContext context) {
    TabController controller =
        TabController(length: noOfDays, vsync: this, initialIndex: DateTime.now().day - 1);

    return Scaffold(
      body: ListView(
        children: [
          Container(
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
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, top: 5),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 201, 201, 201))),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Profile()));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0),
                        backgroundImage:
                            const AssetImage('assets/images/profile_avatar.png'),
                        radius: 25,
                      ),
                    ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: const Text(
                      'April',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff1C305E),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTabController(
                    length: noOfDays,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      height: 70,
                      width: double.infinity,
                      child: TabBar(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        isScrollable: true,
                        labelColor: Colors.amber,
                        labelPadding: const EdgeInsets.only(
                            top: 4, bottom: 3, left: 3, right: 3),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: const Color(0xFF412DA8)),
                        tabs: [
                          ...details.map(
                            (item) {
                              return Tab(
                                height: double.infinity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F5F9),
                                    borderRadius: BorderRadius.circular(28),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          spreadRadius: 0.3, //New
                                          offset: Offset(1, 3))
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  width: 45,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        item["date"] ?? "",
                                        style: const TextStyle(
                                            color: Color(0xFF5650D8),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        item["day"] ?? "",
                                        style: const TextStyle(
                                          color: Color(0xFF5650D8),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 680,
                      child: TabBarView(
                        controller: controller,
                        children: [
                          ...details.map((item) {
                            return item['exists'] ?  Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, right: 4, left: 4),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Breakfast',
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            item['breakfast'] ?? "",
                                            style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                            )),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.timelapse_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                '7:00 AM to 9:00 AM',
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, right: 4, left: 4),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Lunch',
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            item['lunch']  ?? "",
                                            style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                            )),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:  [
                                              Icon(
                                                Icons.timelapse_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                '12:30 PM to 2:00 PM',
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, right: 4, left: 4),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Snacks',
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            item['snacks'] ?? "",
                                            style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                            )),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:  [
                                              Icon(
                                                Icons.timelapse_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                '4:00 PM to 6:00 PM',
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, right: 4, left: 4),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Dinner',
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            item['dinner'] ?? "",
                                            style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                            )),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:  [
                                              Icon(
                                                Icons.timelapse_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                '7:00 PM to 9:00 PM',
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ) :
                            const Column(
                              children: [
                                SizedBox(height: 50,),
                                Icon(
                                  Icons.error_outline,
                                  size: 35,
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 10,),
                                Text('No data available',style: TextStyle(color: Colors.blue, fontSize: 19),)
                              ],
                            ); 
                          })
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
