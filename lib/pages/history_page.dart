import 'package:flutter/material.dart';
import 'package:vit_hostel_repo/widgets/history_list.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late double lastSwipe;
  int _currrentPage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < 0 && _currrentPage == 0) {
          setState(() {
            _currrentPage = 1;
          });
        } else if (details.delta.dx > 0 && _currrentPage == 1) {
          setState(() {
            _currrentPage = 0;
          });
        }
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
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (_currrentPage != 0) {
                        setState(() {
                          _currrentPage = 0;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: Colors.white),
                        color: _currrentPage == 0
                            ? const Color.fromARGB(255, 84, 81, 214)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          color:
                              _currrentPage == 0 ? Colors.white : Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_currrentPage != 1) {
                        setState(() {
                          _currrentPage = 1;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: Colors.white),
                        color: _currrentPage == 1
                            ? const Color.fromARGB(255, 84, 81, 214)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Resolved',
                        style: TextStyle(
                          color:
                              _currrentPage == 1 ? Colors.white : Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              HistoryList(
                dataType: _currrentPage == 0 ? "pending" : "completed",
              )
            ],
          ),
        ),
      ),
    );
  }
}
