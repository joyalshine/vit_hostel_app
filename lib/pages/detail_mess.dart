import 'package:flutter/material.dart';

class DetailMessMenu extends StatefulWidget {
  const DetailMessMenu({super.key});

  @override
  State<DetailMessMenu> createState() => _DetailMessMenuState();
}

class _DetailMessMenuState extends State<DetailMessMenu>
    with TickerProviderStateMixin {
  final List<Map<String, String>> details = [
    {
      "date": "1",
      "day": "Mon",
      "index": "0",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    },
    {
      "date": "2",
      "day": "Tue",
      "index": "1",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    },
    {
      "date": "3",
      "day": "Wed",
      "index": "2",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    },
    {
      "date": "4",
      "day": "Thu",
      "index": "3",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    },
    {
      "date": "5",
      "day": "Fri",
      "index": "4",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    },
    {
      "date": "6",
      "day": "Sat",
      "index": "5",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    },
    {
      "date": "7",
      "day": "Sun",
      "index": "6",
      "breakfast": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "Lunch": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "snacks": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg""",
      "dinner": """Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, 
Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg"""
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController controller =
        TabController(length: 7, vsync: this, initialIndex: 3);

    return Container(
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
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                          color: const Color.fromARGB(255, 201, 201, 201))),
                  child: const Icon(Icons.arrow_back),
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
              length: 7,
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
                height: 600,
                child: TabBarView(
                  controller: controller,
                  children: [
                    ...details.map((e) {
                      return Column(
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
                                  const Text(
                                      'Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
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
                                  const Text(
                                      'Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
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
                                  const Text(
                                      'Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
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
                                  const Text(
                                      'Paav Bhaji, Corn Flakes, Idly, Sambar , Chutney, Bread, Butter, Jam, Tea, Coffee,  Milk, Salad, Boiled Egg',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
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
                      );
                    })
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
