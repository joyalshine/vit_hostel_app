import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key, required this.changeScreen});

  final void Function(int index) changeScreen;

  @override
  Widget build(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Welcome Sabby",
                    style: TextStyle(
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
              child: const Text(
                'Monday Aug 3, 2003',
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
            Material(
              child: InkWell(
                onTap: () {
                  changeScreen(4);
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
                        Container(
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
                        Container(
                          height: 140,
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
                        Container(
                          height: 154,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
