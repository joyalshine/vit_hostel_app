import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:vit_hostel_repo/backend/backend.dart';

final db = FirebaseFirestore.instance;

Future<bool> hasInternetAccess() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    try {
      final response = await http
          .get(Uri.parse("https://www.google.com"))
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  } else {
    return false;
  }
}

Future<Map<String, dynamic>> addCleaningRequest(
    Map<String, dynamic> data) async {
  final hasAccess = await hasInternetAccess();
  if (hasAccess) {
    try {
      final apiResponse = await apiFetch('add-cleaning-complaint', data);
      if (apiResponse['status']) {
        final newData = apiResponse['data'];
        Box complaintBox = Hive.box('complaints');
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData = complaintBox.get('cleaningHistory') ?? [];

        newComplaintList.addAll(hiveOldData);
        var time = DateTime.parse(newData['createdAt']).toLocal();
        newData['timestamp'] = time;
        newData['complaintType'] = 'Cleaning';
        newData['id'] = newData['_id'];
        print(newData);
        newComplaintList.add(newData);

        complaintBox.put('cleaningHistory', newComplaintList);
        complaintBox.put('cleaningPending', true);
        complaintBox.put('cleanPendingId', newData['_id']);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'someerr'};
      }
    } catch (error) {
      return {'status': false, 'type': 'someerr'};
    }
  } else {
    return {'status': false, 'type': 'noconn'};
  }
}

Future<Map<String, dynamic>> addMaintenanceComplaint(
    Map<String, dynamic> data) async {
  final hasAccess = await hasInternetAccess();
  if (hasAccess) {
    try {
      final apiResponse = await apiFetch('add-maintenance-complaint', data);
      print(apiResponse);
      if (apiResponse['status']) {
        print('iside===============');
        final newData = apiResponse['data'];
        Box complaintBox = Hive.box('complaints');
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData =
            complaintBox.get('maintenanceHistory') ?? [];

        newComplaintList.addAll(hiveOldData);
        var time = DateTime.parse(newData['createdAt']).toLocal();
        newData['timestamp'] = time;
        newData['complaintType'] = 'Maintenance';
        newData['id'] = newData['_id'];
        newComplaintList.add(newData);

        complaintBox.put('maintenanceHistory', newComplaintList);
        complaintBox.put('maintenancePending', true);
        complaintBox.put('mainPendingId', newData['_id']);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'someerr'};
      }
    } catch (error) {
      print(error);
      return {'status': false, 'type': 'someerr'};
    }
  } else {
    return {'status': false, 'type': 'noconn'};
  }
}

Future<Map<String, dynamic>> addMessComplaint(Map<String, dynamic> data) async {
  final hasAccess = await hasInternetAccess();
  if (hasAccess) {
    try {
      final apiResponse = await apiFetch('add-mess-complaint', data);
      if (apiResponse['status']) {
        final newData = apiResponse['data'];
        Box complaintBox = Hive.box('complaints');
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData = complaintBox.get('messHistory') ?? [];
        newComplaintList.addAll(hiveOldData);
        var time = DateTime.parse(newData['createdAt']).toLocal();
        newData['timestamp'] = time;
        newData['complaintType'] = 'Mess';
        newData['id'] = newData['_id'];
        newComplaintList.add(newData);

        complaintBox.put('messHistory', newComplaintList);
        complaintBox.put('messPending', true);
        complaintBox.put('messPendingId', newData['_id']);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'someerr'};
      }
    } catch (error) {
      return {'status': false, 'type': 'someerr'};
    }
  } else {
    return {'status': false, 'type': 'noconn'};
  }
}

Future<Map<String, dynamic>> addDisciplineComplaint(
    Map<String, dynamic> data) async {
  final hasAccess = await hasInternetAccess();
  if (hasAccess) {
    try {
      final apiResponse = await apiFetch('add-discipline-complaint', data);
      if (apiResponse['status']) {
        final newData = apiResponse['data'];
        Box complaintBox = Hive.box('complaints');
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData = complaintBox.get('disciplineHistory') ?? [];

        newComplaintList.addAll(hiveOldData);
        var time = DateTime.parse(newData['createdAt']).toLocal();
        newData['timestamp'] = time;
        newData['complaintType'] = 'Discipline';
        newData['id'] = newData['_id'];
        newComplaintList.add(newData);

        complaintBox.put('disciplineHistory', newComplaintList);
        complaintBox.put('disciplinePending', true);
        complaintBox.put('discPendingId', newData['_id']);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'someerr'};
      }
    } catch (error) {
      return {'status': false, 'type': 'someerr'};
    }
  } else {
    return {'status': false, 'type': 'noconn'};
  }
}






























// Future<Map<String, dynamic>> addCleaningRequest(
//     Map<String, dynamic> data) async {
//   final hasAccess = await hasInternetAccess();
//   if (hasAccess) {
//     try {
//       final newData = await db.collection('cleaning').add(data);
//       String email = data['studentEmail'];
//       Box complaintBox = Hive.box('complaints');
//       // final bool isPending = complaintBox.get('cleaningPending') ?? false;
//       // if (!isPending) {
//       List<dynamic> newComplaintList = [];
//       List<dynamic> hiveOldData = complaintBox.get('cleaningHistory') ?? [];
//       await db
//           .collection('cleaning')
//           .where('studentEmail', isEqualTo: email)
//           .get()
//           .then(
//         (querySnapshot) {
//           if (hiveOldData.length == querySnapshot.size - 1) {
//             newComplaintList.addAll(hiveOldData);
//             for (var docSnapshot in querySnapshot.docs) {
//               if (docSnapshot.id == newData.id) {
//                 var temp = docSnapshot.data();
//                 Timestamp time = docSnapshot.get('timestamp');
//                 temp['timestamp'] = time.toDate();
//                 temp['complaintType'] = 'Cleaning';
//                 temp['id'] = docSnapshot.id;
//                 newComplaintList.add(temp);
//               }
//             }
//           } else {
//             for (var docSnapshot in querySnapshot.docs) {
//               var temp = docSnapshot.data();
//               Timestamp time = docSnapshot.get('timestamp');
//               temp['timestamp'] = time.toDate();
//               temp['complaintType'] = 'Cleaning';
//               temp['id'] = docSnapshot.id;
//               newComplaintList.add(temp);
//             }
//           }
//         },
//         onError: (e) => {'status': false, 'type': 'someerr'},
//       );
//       complaintBox.put('cleaningHistory', newComplaintList);
//       complaintBox.put('cleaningPending', true);
//       complaintBox.put('cleanPendingId', newData.id);
//       return {'status': true};
//       // } else {
//       //   return {'status': false, 'type': 'pendingexist'};
//       // }
//     } catch (error) {
//       return {'status': false, 'type': 'someerr'};
//     }
//   } else {
//     return {'status': false, 'type': 'noconn'};
//   }
// }

// Future<Map<String, dynamic>> addMaintenanceComplaint(
//     Map<String, dynamic> data) async {
//   final hasAccess = await hasInternetAccess();
//   if (hasAccess) {
//     try {
//       final newData = await db.collection('maintenance').add(data);
//       String email = data['studentEmail'];
//       Box complaintBox = Hive.box('complaints');
//       // final isPending = complaintBox.get('maintenancePending');
//       // if (!isPending) {
//       List<dynamic> newComplaintList = [];
//       List<dynamic> hiveOldData = complaintBox.get('maintenanceHistory') ?? [];
//       await db
//           .collection('maintenance')
//           .where('studentEmail', isEqualTo: email)
//           .get()
//           .then(
//         (querySnapshot) {
//           if (hiveOldData.length == querySnapshot.size - 1) {
//             newComplaintList.addAll(hiveOldData);
//             for (var docSnapshot in querySnapshot.docs) {
//               if (docSnapshot.id == newData.id) {
//                 var temp = docSnapshot.data();
//                 Timestamp time = docSnapshot.get('timestamp');
//                 temp['timestamp'] = time.toDate();
//                 temp['complaintType'] = 'Maintenance';
//                 temp['id'] = docSnapshot.id;
//                 newComplaintList.add(temp);
//               }
//             }
//           } else {
//             for (var docSnapshot in querySnapshot.docs) {
//               var temp = docSnapshot.data();
//               Timestamp time = docSnapshot.get('timestamp');
//               temp['timestamp'] = time.toDate();
//               temp['complaintType'] = 'Maintenance';
//               temp['id'] = docSnapshot.id;
//               newComplaintList.add(temp);
//             }
//           }
//         },
//         onError: (e) => {'status': false, 'type': 'someerr'},
//       );
//       complaintBox.put('maintenanceHistory', newComplaintList);
//       complaintBox.put('maintenancePending', true);
//       complaintBox.put('mainPendingId', newData.id);
//       return {'status': true};
//       // } else {
//       //   return {'status': false, 'type': 'pendingexist'};
//       // }
//     } catch (error) {
//       return {'status': false, 'type': 'someerr'};
//     }
//   } else {
//     return {'status': false, 'type': 'noconn'};
//   }
// }

// Future<Map<String, dynamic>> addMessComplaint(Map<String, dynamic> data) async {
//   final hasAccess = await hasInternetAccess();
//   if (hasAccess) {
//     try {
//       final newData = await db.collection('mess').add(data);
//       String email = data['studentEmail'];
//       Box complaintBox = Hive.box('complaints');
//       // final isPending = complaintBox.get('messPending') ?? false;
//       // if (!isPending) {
//       List<dynamic> newComplaintList = [];
//       List<dynamic> hiveOldData = complaintBox.get('messHistory') ?? [];
//       await db
//           .collection('mess')
//           .where('studentEmail', isEqualTo: email)
//           .get()
//           .then(
//         (querySnapshot) {
//           if (hiveOldData.length == querySnapshot.size - 1) {
//             newComplaintList.addAll(hiveOldData);
//             for (var docSnapshot in querySnapshot.docs) {
//               if (docSnapshot.id == newData.id) {
//                 var temp = docSnapshot.data();
//                 Timestamp time = docSnapshot.get('timestamp');
//                 temp['timestamp'] = time.toDate();
//                 temp['complaintType'] = 'Mess';
//                 temp['id'] = docSnapshot.id;
//                 newComplaintList.add(temp);
//               }
//             }
//           } else {
//             for (var docSnapshot in querySnapshot.docs) {
//               var temp = docSnapshot.data();
//               Timestamp time = docSnapshot.get('timestamp');
//               temp['timestamp'] = time.toDate();
//               temp['complaintType'] = 'Mess';
//               temp['id'] = docSnapshot.id;
//               newComplaintList.add(temp);
//             }
//           }
//         },
//         onError: (e) => false,
//       );
//       complaintBox.put('messHistory', newComplaintList);
//       complaintBox.put('messPending', true);
//       complaintBox.put('messPendingId', newData.id);
//       return {'status': true};
//       // } else {
//       //   return {'status': false, 'type': 'pendingexist'};
//       // }
//     } catch (error) {
//       return {'status': false, 'type': 'someerr'};
//     }
//   } else {
//     return {'status': false, 'type': 'noconn'};
//   }
// }

// Future<Map<String, dynamic>> addDisciplineComplaint(
//     Map<String, dynamic> data) async {
//   final hasAccess = await hasInternetAccess();
//   if (hasAccess) {
//     try {
//       final newData = await db.collection('discipline').add(data);
//       String email = data['studentEmail'];
//       Box complaintBox = Hive.box('complaints');
//       // final isPending = complaintBox.get('disciplinePending') ?? false;
//       // print('------------------------------');
//       // print(isPending);
//       // print('------------------------------');
//       // if (!isPending) {
//       print('inside if');
//       List<dynamic> newComplaintList = [];
//       List<dynamic> hiveOldData = complaintBox.get('disciplineHistory') ?? [];
//       await db
//           .collection('discipline')
//           .where('studentEmail', isEqualTo: email)
//           .get()
//           .then(
//         (querySnapshot) {
//           if (hiveOldData.length == querySnapshot.size - 1) {
//             newComplaintList.addAll(hiveOldData);
//             for (var docSnapshot in querySnapshot.docs) {
//               if (docSnapshot.id == newData.id) {
//                 var temp = docSnapshot.data();
//                 Timestamp time = docSnapshot.get('timestamp');
//                 temp['timestamp'] = time.toDate();
//                 temp['complaintType'] = 'Discipline';
//                 temp['id'] = docSnapshot.id;
//                 newComplaintList.add(temp);
//               }
//             }
//           } else {
//             for (var docSnapshot in querySnapshot.docs) {
//               var temp = docSnapshot.data();
//               Timestamp time = docSnapshot.get('timestamp');
//               temp['timestamp'] = time.toDate();
//               temp['complaintType'] = 'Discipline';
//               temp['id'] = docSnapshot.id;
//               newComplaintList.add(temp);
//             }
//           }
//         },
//         onError: (e) => false,
//       );
//       complaintBox.put('disciplineHistory', newComplaintList);
//       complaintBox.put('disciplinePending', true);
//       complaintBox.put('discPendingId', newData.id);
//       return {'status': true};
//       // } else {
//       //   return {'status': false, 'type': 'pendingexist'};
//       // }
//     } catch (error) {
//       return {'status': false, 'type': 'someerr'};
//     }
//   } else {
//     return {'status': false, 'type': 'noconn'};
//   }
// }
