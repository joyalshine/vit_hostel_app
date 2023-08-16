import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

const Map<int,int> monthDaysCount = {
  1 : 31,
  2 : 28,
  3 : 31,
  4 : 30,
  5 : 31,
  6 : 30,
  7 : 31,
  8 : 31,
  9 : 30,
  10 : 31,
  11 : 30,
  12 : 31,
};

Future<Map<String,dynamic>> fetchUserComplaints(String email) async{
  try{
    List<dynamic> discipline = [];
    List<dynamic> mess = [];
    List<dynamic> maintenance = [];
    List<dynamic> cleaning = [];
    await db.collection('discipline').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              temp['complaintType'] = 'Discipline';
              temp['id'] = docSnapshot.id;
              discipline.add(temp);
          }
      },
    );
    await db.collection('maintenance').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              temp['complaintType'] = 'Maintenance';
              temp['id'] = docSnapshot.id;
              maintenance.add(temp);
          }
      },
    );
    await db.collection('cleaning').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              temp['complaintType'] = 'Cleaning';
              temp['id'] = docSnapshot.id;
              cleaning.add(temp);
          }
      },
    );
    await db.collection('mess').where('studentEmail',isEqualTo: email).get().then(
      (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
              var temp = docSnapshot.data();
              Timestamp time = docSnapshot.get('timestamp');
              temp['timestamp'] = time.toDate();
              temp['complaintType'] = 'Mess';
              temp['id'] = docSnapshot.id;
              mess.add(temp);
          }
      },
    );
    return {
        'status' : true,
        'discipline': discipline,
        'mess' :mess,
        'maintenance' : maintenance,
        'cleaning' : cleaning
      };
  }
  catch(err){
    return {'status' : false,'type' : 'error'};
  }
}

Future<Map<String,dynamic>> fetchCurrentMenu() async{
  List<String> months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  final date = DateTime.now();
  String key = months[date.month - 1] + date.year.toString();
  try{
    DocumentSnapshot doc = await db.collection('messMenu').doc(key).get();
    if(doc.exists){
      return {
        'status' : true,
        'data':doc.data(),
        'key' : key
      };
    }
    else{
      return {'status' : false,'type' : null};
    }
  }
  catch(err){
    return {'status' : false,'type' : 'error'};
  }
}