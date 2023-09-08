import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

final db = FirebaseFirestore.instance;

Future<bool> hasInternetAccess() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    try {
      final response = await http
          .get(Uri.parse("https://www.google.com"))
          .timeout(Duration(seconds: 10));
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
      final newData = await db.collection('cleaning').add(data);
      String email = data['studentEmail'];
      Box complaintBox = Hive.box('complaints');
      final bool isPending = complaintBox.get('cleaningPending') ?? false;
      if (!isPending) {
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData = complaintBox.get('cleaningHistory') ?? [];
        await db
            .collection('cleaning')
            .where('studentEmail', isEqualTo: email)
            .get()
            .then(
          (querySnapshot) {
            if (hiveOldData.length == querySnapshot.size - 1) {
              newComplaintList.addAll(hiveOldData);
              for (var docSnapshot in querySnapshot.docs) {
                if (docSnapshot.id == newData.id) {
                  var temp = docSnapshot.data();
                  Timestamp time = docSnapshot.get('timestamp');
                  temp['timestamp'] = time.toDate();
                  temp['complaintType'] = 'Cleaning';
                  temp['id'] = docSnapshot.id;
                  newComplaintList.add(temp);
                }
              }
            } else {
              for (var docSnapshot in querySnapshot.docs) {
                var temp = docSnapshot.data();
                Timestamp time = docSnapshot.get('timestamp');
                temp['timestamp'] = time.toDate();
                temp['complaintType'] = 'Cleaning';
                temp['id'] = docSnapshot.id;
                newComplaintList.add(temp);
              }
            }
          },
          onError: (e) => {'status': false, 'type': 'someerr'},
        );
        complaintBox.put('cleaningHistory', newComplaintList);
        complaintBox.put('cleaningPending', true);
        complaintBox.put('cleanPendingId', newData.id);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'pendingexist'};
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
      final newData = await db.collection('maintenance').add(data);
      String email = data['studentEmail'];
      Box complaintBox = Hive.box('complaints');
      final isPending = complaintBox.get('maintenancePending');
      if (!isPending) {
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData =
            complaintBox.get('maintenanceHistory') ?? [];
        await db
            .collection('maintenance')
            .where('studentEmail', isEqualTo: email)
            .get()
            .then(
          (querySnapshot) {
            if (hiveOldData.length == querySnapshot.size - 1) {
              newComplaintList.addAll(hiveOldData);
              for (var docSnapshot in querySnapshot.docs) {
                if (docSnapshot.id == newData.id) {
                  var temp = docSnapshot.data();
                  Timestamp time = docSnapshot.get('timestamp');
                  temp['timestamp'] = time.toDate();
                  temp['complaintType'] = 'Maintenance';
                  temp['id'] = docSnapshot.id;
                  newComplaintList.add(temp);
                }
              }
            } else {
              for (var docSnapshot in querySnapshot.docs) {
                var temp = docSnapshot.data();
                Timestamp time = docSnapshot.get('timestamp');
                temp['timestamp'] = time.toDate();
                temp['complaintType'] = 'Maintenance';
                temp['id'] = docSnapshot.id;
                newComplaintList.add(temp);
              }
            }
          },
          onError: (e) => {'status': false, 'type': 'someerr'},
        );
        complaintBox.put('maintenanceHistory', newComplaintList);
        complaintBox.put('maintenancePending', true);
        complaintBox.put('mainPendingId', newData.id);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'pendingexist'};
      }
    } catch (error) {
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
      final newData = await db.collection('mess').add(data);
      String email = data['studentEmail'];
      Box complaintBox = Hive.box('complaints');
      final isPending = complaintBox.get('messPending') ?? false;
      if (!isPending) {
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData = complaintBox.get('messHistory') ?? [];
        await db
            .collection('mess')
            .where('studentEmail', isEqualTo: email)
            .get()
            .then(
          (querySnapshot) {
            if (hiveOldData.length == querySnapshot.size - 1) {
              newComplaintList.addAll(hiveOldData);
              for (var docSnapshot in querySnapshot.docs) {
                if (docSnapshot.id == newData.id) {
                  var temp = docSnapshot.data();
                  Timestamp time = docSnapshot.get('timestamp');
                  temp['timestamp'] = time.toDate();
                  temp['complaintType'] = 'Mess';
                  temp['id'] = docSnapshot.id;
                  newComplaintList.add(temp);
                }
              }
            } else {
              for (var docSnapshot in querySnapshot.docs) {
                var temp = docSnapshot.data();
                Timestamp time = docSnapshot.get('timestamp');
                temp['timestamp'] = time.toDate();
                temp['complaintType'] = 'Mess';
                temp['id'] = docSnapshot.id;
                newComplaintList.add(temp);
              }
            }
          },
          onError: (e) => false,
        );
        complaintBox.put('messHistory', newComplaintList);
        complaintBox.put('messPending', true);
        complaintBox.put('messPendingId', newData.id);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'pendingexist'};
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
      final newData = await db.collection('discipline').add(data);
      String email = data['studentEmail'];
      Box complaintBox = Hive.box('complaints');
      final isPending = complaintBox.get('disciplinePending') ?? false;
      if (!isPending) {
        List<dynamic> newComplaintList = [];
        List<dynamic> hiveOldData = complaintBox.get('disciplineHistory') ?? [];
        await db
            .collection('discipline')
            .where('studentEmail', isEqualTo: email)
            .get()
            .then(
          (querySnapshot) {
            if (hiveOldData.length == querySnapshot.size - 1) {
              newComplaintList.addAll(hiveOldData);
              for (var docSnapshot in querySnapshot.docs) {
                if (docSnapshot.id == newData.id) {
                  var temp = docSnapshot.data();
                  Timestamp time = docSnapshot.get('timestamp');
                  temp['timestamp'] = time.toDate();
                  temp['complaintType'] = 'Discipline';
                  temp['id'] = docSnapshot.id;
                  newComplaintList.add(temp);
                }
              }
            } else {
              for (var docSnapshot in querySnapshot.docs) {
                var temp = docSnapshot.data();
                Timestamp time = docSnapshot.get('timestamp');
                temp['timestamp'] = time.toDate();
                temp['complaintType'] = 'Discipline';
                temp['id'] = docSnapshot.id;
                newComplaintList.add(temp);
              }
            }
          },
          onError: (e) => false,
        );
        complaintBox.put('disciplineHistory', newComplaintList);
        complaintBox.put('disciplinePending', true);
        complaintBox.put('discPendingId', newData.id);
        return {'status': true};
      } else {
        return {'status': false, 'type': 'pendingexist'};
      }
    } catch (error) {
      return {'status': false, 'type': 'someerr'};
    }
  } else {
    return {'status': false, 'type': 'noconn'};
  }
}
