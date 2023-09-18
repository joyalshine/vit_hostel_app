import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vit_hostel_repo/firebase/data_assets.dart';

class HistoryList extends StatefulWidget {
  HistoryList({super.key, required this.dataType, required this.data});

  final String dataType;
  final List<dynamic> data;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late List<dynamic> dataToShow;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  void changeData() {
    List<dynamic> newData;
    if (widget.dataType == 'completed') {
      newData = widget.data.where((element) {
        if (element['status'] == 'resolve' || element['status'] == 'deny') {
          return true;
        }
        return false;
      }).toList();
      newData.sort((a, b) => (b["resolveTime"] ?? b["denyTime"])
          .compareTo(a["resolveTime"] ?? a["denyTime"]));
    } else {
      newData = widget.data.where((element) {
        if (element['status'] == '' || element['status'] == 'pending') {
          return true;
        }
        return false;
      }).toList();
      newData.sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
    }
    setState(() {
      dataToShow = newData;
    });
  }

  String categoryDisplay(List<dynamic> list, String? type) {
    String result = '';
    result = type == 'Cleaning' ? cleaning[list[0]]! : maintenance[list[0]]!;
    if (type == 'Cleaning') {
      for (int i = 1; i < list.length; i++) {
        result = '$result, ${cleaning[list[i]]!}';
      }
    } else {
      for (int i = 1; i < list.length; i++) {
        result = '$result, ${maintenance[list[i]]!}';
      }
    }
    return result;
  }

  @override
  void initState() {
    changeData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HistoryList oldWidget) {
    changeData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: dataToShow.isNotEmpty
          ? Column(
              children: [
                ...dataToShow.map((item) {
                  DateTime created = item['timestamp'];
                  int day = created.day;
                  String month = months[created.month - 1];
                  int year = created.year;
                  int hour = created.hour;
                  int minutes = created.minute;
                  int? resolvedDay, resolvedYear, resolvedHour, resolvedMinutes;
                  String? resolvedMonth;
                  if (widget.dataType == 'completed') {
                    DateTime completed =
                        item['resolveTime'] ?? item['denyTime'];
                    resolvedDay = completed.day;
                    resolvedMonth = months[completed.month - 1];
                    resolvedYear = completed.year;
                    resolvedHour = completed.hour;
                    resolvedMinutes = completed.minute;
                  }
                  var category = item['category'];
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: item['status'] == 'resolve' ||
                              item['status'] == 'pending'
                          ? Color.fromARGB(255, 94, 92, 227)
                          : Color.fromARGB(255, 232, 75, 48),
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 117, 116, 116),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  item['complaintType'] == 'Cleaning'
                                      ? 'assets/images/cleaning-home-logo.png'
                                      : item['complaintType'] == 'Maintenance'
                                          ? 'assets/images/logo-repair.png'
                                          : item['complaintType'] == 'Mess'
                                              ? 'assets/images/food-home-logo.png'
                                              : 'assets/images/discipline-home-logo.png',
                                  width: item['complaintType'] == 'Mess'
                                      ? 80
                                      : item['complaintType'] == 'Discipline'
                                          ? 70
                                          : 60,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['complaintType'] ?? 'Not found',
                                      style: const TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          item['complaintType'] != 'Mess'
                              ? Row(
                                  children: [
                                    Text(
                                      'Block : ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      item['block'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          item['complaintType'] != 'Mess'
                              ? Row(
                                  children: [
                                    Text(
                                      'Room : ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      item['room'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      'Mess : ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      item['mess'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.white54))),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Created on',
                                        style: TextStyle(color: Colors.white54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$day $month, $year',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        minutes < 10
                                            ? '$hour:0$minutes'
                                            : '$hour:$minutes',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Resolved on',
                                          style:
                                              TextStyle(color: Colors.white54),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        widget.dataType == 'pending'
                                            ? Text(
                                                'NA',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(
                                                '$resolvedDay $resolvedMonth, $resolvedYear',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                        widget.dataType == 'pending'
                                            ? Text(
                                                'NA',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                resolvedMinutes! < 10
                                                    ? '$resolvedHour:0$resolvedMinutes'
                                                    : '$resolvedHour:$resolvedMinutes',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          if (item['complaintType'] != 'Mess')
                            Row(
                              children: [
                                Text(
                                  item['complaintType'] != 'Maintenance' ||
                                          item['complaintType'] == 'Cleaning'
                                      ? 'For : '
                                      : 'Regarding : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  item['complaintType'] == 'Discipline'
                                      ? discipline[category]!
                                      : categoryDisplay(
                                          category, item['complaintType']),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white70,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            item['complaint'],
                            style: TextStyle(color: Colors.white),
                          ),
                          if (item['status'] == 'deny')
                            const SizedBox(
                              height: 15,
                            ),
                          if (item['status'] == 'deny')
                            const Text(
                              'Feedback',
                              style: TextStyle(
                                color: Colors.white70,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                          if (item['status'] == 'deny')
                            const SizedBox(
                              height: 8,
                            ),
                          if (item['status'] == 'deny')
                            Text(
                              item['feedback'],
                              style: TextStyle(color: Colors.white),
                            )
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(
                  height: 15,
                ),
              ],
            )
          : Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.error_outline,
                  size: 35,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.dataType == 'completed' ? 'No Complaints Resolved' : 'No Complaints Pending' ,
                  style: TextStyle(color: Colors.blue, fontSize: 19),
                )
              ],
            ),
    );
  }
}
