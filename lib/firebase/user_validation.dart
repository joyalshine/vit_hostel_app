import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Future<Map<String,dynamic>> validateUser(String email) async{
  try{
    DocumentSnapshot doc = await db.collection('users').doc(email).get();
    if(doc.exists){
      
      return {
        'isValid':true,
        'email' : doc.id,
        'details':doc.data()
      };
    }
    else{
      return {'isValid':false,'type':'invalidUser'};
    }
  }
  catch(err){
    return {'isValid':false,'type':'someError'};
  }
}
