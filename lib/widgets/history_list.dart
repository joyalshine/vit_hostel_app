import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  HistoryList({super.key, required this.dataType, required this.data});

  final String dataType;
  final List<dynamic> data;
  late List<dynamic> dataToShow;
  void changeData(){
    List<dynamic> newData;
    if(dataType == 'completed'){
      newData = data.where((element) {
        if(element['status'] == 'resolved'){
          return true;
        }
        return false;
      }).toList();
      newData.sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
    }
    else{
      newData = data.where((element) {
        if(element['status'] == '' ||element['status'] == null){
          return true;
        }
        return false;
      }).toList();
      newData.sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
    }
    dataToShow = newData;
  }

  @override
  Widget build(BuildContext context) {
    changeData();
    return SizedBox(
      child: Column(
        children: [
          ...dataToShow.map((item) {
            DateTime temp = item['timestamp'];
            int day = temp.day;
            int month = temp.month;
            int year = temp.year;
            String dateDisplay = '$day-$month-$year';
            return Container(
              margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 84, 81, 214),
                borderRadius: BorderRadius.circular(13)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    'assets/images/logo-repair.png',
                    width: 60,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['complaintType'] ?? 'Not found',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              dateDisplay,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
          }).toList(),
          
          const SizedBox(
            height: 15,
          ),
          
        ],
      ),
    );
  }
}
