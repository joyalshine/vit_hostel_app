import 'dart:convert';

import 'package:http/http.dart' as http;

// Future<Map<String,dynamic>> sendOTP(String email,String name) async{
//   try{
//     final url = Uri.parse('https://vit-hostel-app-backend.onrender.com/verify/$email/$name');
//     http.Response response = await http.post(url,headers: {
//       'Content-Type' : 'application/json'
//     },);
//     var data = jsonDecode(response.body);
//     return {
//       'status': true,
//       'otp':data['otp']
//     };
//   }
//   catch(err){
//     return {
//       'status':false,
//       'msg' : err
//     };
//   }
// }

Future<dynamic> apiFetch(String route, Map<String,dynamic> body) async{
  try{
    final url = Uri.parse('http://10.0.2.2:3000/app/$route');
    http.Response response = await http.post(url,headers: {
      'Content-Type' : 'application/json'
    },body: jsonEncode({"data" : body}));
    var data = jsonDecode(response.body);
    return data;
  }
  catch(err){
    return {
      'status':false,
      'msg' : err
    };
  }
  
}