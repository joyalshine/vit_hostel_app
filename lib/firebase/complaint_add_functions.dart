import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

final db = FirebaseFirestore.instance;

Future<bool> addCleaningRequest(Map<String, dynamic> data) async {
  try {
    final newData = await db.collection('cleaning').add(data);
    String email = data['studentEmail'];
    Box complaintBox = Hive.box('complaints');
    List<dynamic> newComplaintList = [];
    List<dynamic> hiveOldData = complaintBox.get('cleaningHistory') ?? [];
    await db.collection('cleaning').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
        if(hiveOldData.length == querySnapshot.size - 1){
          newComplaintList.addAll(hiveOldData);
          for (var docSnapshot in querySnapshot.docs) {
            if(docSnapshot.id == newData.id){
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
          }
        }
        else{
            for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
        }
      },
      onError: (e) => false,
    );
    complaintBox.put('cleaningHistory',newComplaintList);
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}



Future<bool> addMaintenanceComplaint(Map<String, dynamic> data) async {
  try {
    final newData = await db.collection('maintenance').add(data);
    String email = data['studentEmail'];
    Box complaintBox = Hive.box('complaints');
    List<dynamic> newComplaintList = [];
    List<dynamic> hiveOldData = complaintBox.get('maintenanceHistory') ?? [];
    await db.collection('maintenance').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
        if(hiveOldData.length == querySnapshot.size - 1){
          newComplaintList.addAll(hiveOldData);
          for (var docSnapshot in querySnapshot.docs) {
            if(docSnapshot.id == newData.id){
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
          }
        }
        else{
            for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
        }
      },
      onError: (e) => false,
    );
    complaintBox.put('maintenanceHistory',newComplaintList);
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}


Future<bool> addMessComplaint(Map<String, dynamic> data) async {
  try {
    final newData = await db.collection('mess').add(data);
    String email = data['studentEmail'];
    Box complaintBox = Hive.box('complaints');
    List<dynamic> newComplaintList = [];
    List<dynamic> hiveOldData = complaintBox.get('messHistory') ?? [];
    await db.collection('mess').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
        if(hiveOldData.length == querySnapshot.size - 1){
          newComplaintList.addAll(hiveOldData);
          for (var docSnapshot in querySnapshot.docs) {
            if(docSnapshot.id == newData.id){
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
          }
        }
        else{
            for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
        }
      },
      onError: (e) => false,
    );
    complaintBox.put('messHistory',newComplaintList);
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}

Future<bool> addDisciplineComplaint(Map<String, dynamic> data) async {
  try {
    final newData = await db.collection('discipline').add(data);
    String email = data['studentEmail'];
    Box complaintBox = Hive.box('complaints');
    List<dynamic> newComplaintList = [];
    List<dynamic> hiveOldData = complaintBox.get('disciplineHistory') ?? [];
    await db.collection('discipline').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
        if(hiveOldData.length == querySnapshot.size - 1){
          newComplaintList.addAll(hiveOldData);
          for (var docSnapshot in querySnapshot.docs) {
            if(docSnapshot.id == newData.id){
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
          }
        }
        else{
            for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              newComplaintList.add(temp);
            }
        }
      },
      onError: (e) => false,
    );
    complaintBox.put('disciplineHistory',newComplaintList);
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}

