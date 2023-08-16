import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vit_hostel_repo/pages/profile_screen.dart';
import 'package:vit_hostel_repo/widgets/history_list.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late double lastSwipe;
  int _currrentPage = 0;
  bool isLoading = true;
  List<dynamic> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData(){
    Box complaints = Hive.box('complaints');
    List<dynamic> messHistory = complaints.get('messHistory') ?? [];
    List<dynamic> disciplineHistory = complaints.get('disciplineHistory') ?? [];
    List<dynamic> maintenanceHistory = complaints.get('maintenanceHistory') ?? [];
    List<dynamic> cleaningHistory = complaints.get('cleaningHistory') ?? [];
    data.addAll(messHistory);
    data.addAll(disciplineHistory);
    data.addAll(maintenanceHistory);
    data.addAll(cleaningHistory);
    setState(() {
      isLoading = false;
    });
  }

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
              isLoading ? const Center(
                child: CircularProgressIndicator(strokeWidth: 4,),
              ) : HistoryList(
                dataType: _currrentPage == 0 ? "pending" : "completed", data:data
              )
            ],
          ),
        ),
      ),
    );
  }
}
