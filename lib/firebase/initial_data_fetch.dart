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
    DocumentSnapshot doc = await db.collection('userData').doc(email).get();
    if(doc.exists){
      return {
        'status' : true,
        'data':doc.data()
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