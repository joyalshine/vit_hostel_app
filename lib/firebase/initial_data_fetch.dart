import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

final db = FirebaseFirestore.instance;

const Map<int, int> monthDaysCount = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

Future<Map<String, dynamic>> fetchUserComplaints(String email) async {
  try {
    List<dynamic> discipline = [];
    List<dynamic> mess = [];
    List<dynamic> maintenance = [];
    List<dynamic> cleaning = [];
    bool disciplinePending = false;
    bool messPending = false;
    bool maintenancePending = false;
    bool cleaningPending = false;
    var cleanPendingId = null;
    var mainPendingId = null;
    var messPendingId = null;
    var discPendingId = null;
    await db
        .collection('discipline')
        .where('studentEmail', isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var temp = docSnapshot.data();
          Timestamp time = docSnapshot.get('timestamp');
          temp['timestamp'] = time.toDate();
          temp['complaintType'] = 'Discipline';
          if (temp['status'] == 'pending' || temp['status'] == null) {
            disciplinePending = true;
            discPendingId = docSnapshot.id;
          } else if (temp['status'] == 'deny') {
            Timestamp resolveTime = docSnapshot.get('denyTime');
            temp['denyTime'] = resolveTime.toDate();
          } else {
            Timestamp resolveTime = docSnapshot.get('resolveTime');
            temp['resolveTime'] = resolveTime.toDate();
          }
          temp['id'] = docSnapshot.id;
          discipline.add(temp);
        }
      },
    );
    await db
        .collection('maintenance')
        .where('studentEmail', isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var temp = docSnapshot.data();
          Timestamp time = docSnapshot.get('timestamp');
          temp['timestamp'] = time.toDate();
          temp['complaintType'] = 'Maintenance';
          if (temp['status'] == 'pending' || temp['status'] == null) {
            maintenancePending = true;
            mainPendingId = docSnapshot.id;
          } else if (temp['status'] == 'deny') {
            Timestamp resolveTime = docSnapshot.get('denyTime');
            temp['denyTime'] = resolveTime.toDate();
          } else {
            Timestamp resolveTime = docSnapshot.get('resolveTime');
            temp['resolveTime'] = resolveTime.toDate();
          }
          temp['id'] = docSnapshot.id;
          maintenance.add(temp);
        }
      },
    );
    await db
        .collection('cleaning')
        .where('studentEmail', isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var temp = docSnapshot.data();
          Timestamp time = docSnapshot.get('timestamp');
          temp['timestamp'] = time.toDate();
          temp['complaintType'] = 'Cleaning';
          if (temp['status'] == 'pending' || temp['status'] == null) {
            cleaningPending = true;
            cleanPendingId = docSnapshot.id;
          } else if (temp['status'] == 'deny') {
            Timestamp resolveTime = docSnapshot.get('denyTime');
            temp['denyTime'] = resolveTime.toDate();
          } else {
            Timestamp resolveTime = docSnapshot.get('resolveTime');
            temp['resolveTime'] = resolveTime.toDate();
          }
          temp['id'] = docSnapshot.id;
          cleaning.add(temp);
        }
      },
    );
    await db
        .collection('mess')
        .where('studentEmail', isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var temp = docSnapshot.data();
          Timestamp time = docSnapshot.get('timestamp');
          temp['timestamp'] = time.toDate();
          temp['complaintType'] = 'Mess';
          if (temp['status'] == 'pending' || temp['status'] == null) {
            messPending = true;
            messPendingId = docSnapshot.id;
          } else if (temp['status'] == 'deny') {
            Timestamp resolveTime = docSnapshot.get('denyTime');
            temp['denyTime'] = resolveTime.toDate();
          } else {
            Timestamp resolveTime = docSnapshot.get('resolveTime');
            temp['resolveTime'] = resolveTime.toDate();
          }
          temp['id'] = docSnapshot.id;
          mess.add(temp);
        }
      },
    );
    return {
      'status': true,
      'discipline': discipline,
      'mess': mess,
      'maintenance': maintenance,
      'cleaning': cleaning,
      'disciplinePending': disciplinePending,
      'messPending': messPending,
      'maintenancePending': maintenancePending,
      'cleaningPending': cleaningPending,
      'messPendingId': messPendingId,
      'cleanPendingId': cleanPendingId,
      'mainPendingId': mainPendingId,
      'discPendingId': discPendingId
    };
  } catch (err) {
    print(err);
    return {'status': false, 'type': 'error'};
  }
}

Future<Map<String, dynamic>> fetchCurrentMenu() async {
  List<String> months = [
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
  final date = DateTime.now();
  String key = months[date.month - 1] + date.year.toString();
  try {
    DocumentSnapshot doc = await db.collection('messMenu').doc(key).get();
    if (doc.exists) {
      return {'status': true, 'data': doc.data(), 'key': key};
    } else {
      return {'status': true, 'type': null};
    }
  } catch (err) {
    return {'status': false, 'type': 'error'};
  }
}

Future<void> updateMaintenancePending() async {
  Box complaintBox = Hive.box('complaints');
  final mainPendingId = complaintBox.get('mainPendingId');
  try {
    DocumentSnapshot doc =
        await db.collection('maintenance').doc(mainPendingId).get();
    if (doc.get('status') == 'deny' || doc.get('status') == 'resolve') {
      List<dynamic> hiveOldData = complaintBox.get('maintenanceHistory') ?? [];
      List<dynamic> hiveNewData = [];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      var temp = {};
      if (doc.get('status') == 'deny') {
        Timestamp solvedTime = doc.get('denyTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'denyTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Maintenance',
          'id': doc.id
        };
      } else {
        Timestamp solvedTime = doc.get('resolveTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'resolveTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Maintenance',
          'id': doc.id
        };
      }
      for (int i = 0; i < hiveOldData.length; i++) {
        if (hiveOldData[i]['id'] == mainPendingId) {
          hiveNewData.add(temp);
        } else {
          hiveNewData.add(hiveOldData[i]);
        }
      }
      complaintBox.put('maintenanceHistory', hiveNewData);
      complaintBox.put('maintenancePending', false);
      complaintBox.put('mainPendingId', null);
    }

    // return true;
  } catch (err) {
    // return false;
  }
}

Future<void> updateMessPending() async {
  Box complaintBox = Hive.box('complaints');
  final mainPendingId = complaintBox.get('messPendingId');
  try {
    DocumentSnapshot doc = await db.collection('mess').doc(mainPendingId).get();
    if (doc.get('status') == 'deny' || doc.get('status') == 'resolve') {
      List<dynamic> hiveOldData = complaintBox.get('messHistory') ?? [];
      List<dynamic> hiveNewData = [];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      var temp = {};
      if (doc.get('status') == 'deny') {
        Timestamp solvedTime = doc.get('denyTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'denyTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Mess',
          'id': doc.id
        };
      } else {
        Timestamp solvedTime = doc.get('resolveTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'resolveTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Mess',
          'id': doc.id
        };
      }
      for (int i = 0; i < hiveOldData.length; i++) {
        if (hiveOldData[i]['id'] == mainPendingId) {
          hiveNewData.add(temp);
        } else {
          hiveNewData.add(hiveOldData[i]);
        }
      }
      complaintBox.put('messHistory', hiveNewData);
      complaintBox.put('messPending', false);
      complaintBox.put('messPendingId', null);
    }
    // return true;
  } catch (err) {
    // return false;
  }
}

Future<void> updateDisciplinePending() async {
  Box complaintBox = Hive.box('complaints');
  final mainPendingId = complaintBox.get('discPendingId');
  try {
    DocumentSnapshot doc =
        await db.collection('discipline').doc(mainPendingId).get();
    if (doc.get('status') == 'deny' || doc.get('status') == 'resolve') {
      List<dynamic> hiveOldData = complaintBox.get('disciplineHistory') ?? [];
      List<dynamic> hiveNewData = [];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      var temp = {};
      if (doc.get('status') == 'deny') {
        Timestamp solvedTime = doc.get('denyTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'denyTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Discipline',
          'id': doc.id
        };
      } else {
        Timestamp solvedTime = doc.get('resolveTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'resolveTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Discipline',
          'id': doc.id
        };
      }
      for (int i = 0; i < hiveOldData.length; i++) {
        if (hiveOldData[i]['id'] == mainPendingId) {
          hiveNewData.add(temp);
        } else {
          hiveNewData.add(hiveOldData[i]);
        }
      }
      complaintBox.put('disciplineHistory', hiveNewData);
      complaintBox.put('disciplinePending', false);
      complaintBox.put('discPendingId', null);
    }
    // return true;
  } catch (err) {
    // return false;
  }
}

Future<void> updateCleaningPending() async {
  Box complaintBox = Hive.box('complaints');
  final mainPendingId = complaintBox.get('cleanPendingId');
  try {
    DocumentSnapshot doc =
        await db.collection('cleaning').doc(mainPendingId).get();
    if (doc.get('status') == 'deny' || doc.get('status') == 'resolve') {
      List<dynamic> hiveOldData = complaintBox.get('cleaningHistory') ?? [];
      List<dynamic> hiveNewData = [];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      var temp = {};
      if (doc.get('status') == 'deny') {
        Timestamp solvedTime = doc.get('denyTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'denyTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Cleaning',
          'id': doc.id
        };
      } else {
        Timestamp solvedTime = doc.get('resolveTime');
        Timestamp time = doc.get('timestamp');
        temp = {
          ...data,
          'resolveTime': solvedTime.toDate(),
          'timestamp' : time.toDate(),
          'complaintType': 'Cleaning',
          'id': doc.id
        };
      }
      for (int i = 0; i < hiveOldData.length; i++) {
        if (hiveOldData[i]['id'] == mainPendingId) {
          hiveNewData.add(temp);
        } else {
          hiveNewData.add(hiveOldData[i]);
        }
      }
      complaintBox.put('cleaningHistory', hiveNewData);
      complaintBox.put('cleaningPending', false);
      complaintBox.put('cleanPendingId', null);
    }
    // return true;
  } catch (err) {
    // return false;
  }
}
