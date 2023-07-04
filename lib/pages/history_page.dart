import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late double lastSwipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        print("detected");
        print(details.delta);
      },
      child: Container(
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
              SizedBox(
                height: 25,
              ),
              DefaultTabController(
                length: 2,
                child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(5), // Creates border
                        color: Color.fromARGB(255, 84, 81, 214)),
                    tabs: [
                      Tab(
                        text: 'sas',
                      ),
                      Tab(text: 'SXAS')
                    ]),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
