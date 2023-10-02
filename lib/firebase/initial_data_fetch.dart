import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:vit_hostel_repo/backend/backend.dart';

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

    var apiResponse = await apiFetch('fetch-complaints', {'email': email});
    var fetchedData = apiResponse['data'];
    for (var complaint in fetchedData['discipline']) {
      var temp = complaint;
      var time = complaint['createdAt'];
      temp['timestamp'] = DateTime.parse(time).toLocal();
      temp['complaintType'] = 'Discipline';
      if (temp['status'] == 'pending' || temp['status'] == null) {
        disciplinePending = true;
        discPendingId = complaint['_id'];
      } else if (temp['status'] == 'deny') {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['denyTime'] = resolveTime;
      } else {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['resolveTime'] = resolveTime;
      }
      temp['id'] = complaint['_id'];
      discipline.add(temp);
    }
    for (var complaint in fetchedData['maintenance']) {
      var temp = complaint;
      var time = complaint['createdAt'];
      temp['timestamp'] = DateTime.parse(time).toLocal();
      temp['complaintType'] = 'Maintenance';
      if (temp['status'] == 'pending' || temp['status'] == null) {
        maintenancePending = true;
        mainPendingId = complaint['_id'];
      } else if (temp['status'] == 'deny') {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['denyTime'] = resolveTime;
      } else {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['resolveTime'] = resolveTime;
      }
      temp['id'] = complaint['_id'];
      discipline.add(temp);
    }

    for (var complaint in fetchedData['cleaning']) {
      var temp = complaint;
      var time = complaint['createdAt'];
      temp['timestamp'] = DateTime.parse(time).toLocal();
      temp['complaintType'] = 'Cleaning';
      if (temp['status'] == 'pending' || temp['status'] == null) {
        cleaningPending = true;
        cleanPendingId = complaint['_id'];
      } else if (temp['status'] == 'deny') {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['denyTime'] = resolveTime;
      } else {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['resolveTime'] = resolveTime;
      }
      temp['id'] = complaint['_id'];
      discipline.add(temp);
    }

    for (var complaint in fetchedData['mess']) {
      var temp = complaint;
      var time = complaint['createdAt'];
      temp['timestamp'] = DateTime.parse(time).toLocal();
      temp['complaintType'] = 'Mess';
      if (temp['status'] == 'pending' || temp['status'] == null) {
        messPending = true;
        messPendingId = complaint['_id'];
      } else if (temp['status'] == 'deny') {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['denyTime'] = resolveTime;
      } else {
        var resolveTime = DateTime.parse(complaint['updatedAt']).toLocal();
        temp['resolveTime'] = resolveTime;
      }
      temp['id'] = complaint['_id'];
      discipline.add(temp);
    }
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

Future<Map<String, dynamic>> fetchCurrentMenu(messType) async {
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
  String key = months[date.month - 1] + date.year.toString() + '-' + messType;
  try {
    var apiResponse = await apiFetch('fetch-menu', {'key': key});
    return apiResponse;
  } catch (err) {
    print(err);
    return {'status': false, 'type': 'error'};
  }
}

Future<void> updateMaintenancePending() async {
  Box complaintBox = Hive.box('complaints');
  final mainPendingId = complaintBox.get('mainPendingId');
  try {
    var apiResponse = await apiFetch('fetch-complaint-update',
        {'id': mainPendingId, 'collection': 'maintenance'});
    if (apiResponse['status']) {
      var doc = apiResponse['data'];
      if (doc['status'] == 'deny' || doc['status'] == 'resolve') {
        List<dynamic> hiveOldData =
            complaintBox.get('maintenanceHistory') ?? [];
        List<dynamic> hiveNewData = [];
        Map<String, dynamic> data = doc as Map<String, dynamic>;
        var temp = {};
        if (doc['status'] == 'deny') {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'denyTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Maintenance',
            'id': doc['_id']
          };
        } else {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'resolveTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Maintenance',
            'id': doc['_id']
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
    var apiResponse = await apiFetch(
        'fetch-complaint-update', {'id': mainPendingId, 'collection': 'mess'});
    if (apiResponse['status']) {
      var doc = apiResponse['data'];
      if (doc['status'] == 'deny' || doc['status'] == 'resolve') {
        List<dynamic> hiveOldData = complaintBox.get('messHistory') ?? [];
        List<dynamic> hiveNewData = [];
        Map<String, dynamic> data = doc as Map<String, dynamic>;
        var temp = {};
        if (doc['status'] == 'deny') {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'denyTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Maintenance',
            'id': doc['_id']
          };
        } else {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'resolveTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Mess',
            'id': doc['_id']
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
    var apiResponse = await apiFetch('fetch-complaint-update',
        {'id': mainPendingId, 'collection': 'discipline'});
    if (apiResponse['status']) {
      var doc = apiResponse['data'];
      if (doc['status'] == 'deny' || doc['status'] == 'resolve') {
        List<dynamic> hiveOldData = complaintBox.get('disciplineHistory') ?? [];
        List<dynamic> hiveNewData = [];
        Map<String, dynamic> data = doc as Map<String, dynamic>;
        var temp = {};
        if (doc['status'] == 'deny') {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'denyTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Discipline',
            'id': doc['_id']
          };
        } else {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'resolveTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Maintenance',
            'id': doc['_id']
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
    var apiResponse = await apiFetch('fetch-complaint-update',
        {'id': mainPendingId, 'collection': 'cleaning'});
    if (apiResponse['status']) {
      var doc = apiResponse['data'];
      if (doc['status'] == 'deny' || doc['status'] == 'resolve') {
        List<dynamic> hiveOldData = complaintBox.get('cleaningHistory') ?? [];
        List<dynamic> hiveNewData = [];
        Map<String, dynamic> data = doc as Map<String, dynamic>;
        var temp = {};
        if (doc['status'] == 'deny') {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'denyTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Cleaning',
            'id': doc['_id']
          };
        } else {
          var solvedTime = DateTime.parse(doc['updatedAt']).toLocal();
          var time = DateTime.parse(doc['createdAt']).toLocal();
          temp = {
            ...data,
            'resolveTime': solvedTime,
            'timestamp': time,
            'complaintType': 'Maintenance',
            'id': doc['_id']
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
    }
    // return true;
  } catch (err) {
    // return false;
  }
}
