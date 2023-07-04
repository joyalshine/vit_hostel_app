import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.dataType});

  final String dataType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 84, 81, 214),
                borderRadius: BorderRadius.circular(13)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    'assets/images/logo-repair.png',
                    width: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'AC not cooling',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '09/02/2023',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          dataType == "completed"
              ? Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 84, 81, 214),
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/cleaning-home-logo.png',
                          width: 70,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Room Cleaning',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '09/02/2023',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
