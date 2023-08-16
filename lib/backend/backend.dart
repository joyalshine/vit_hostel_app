import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> sendOTP(String email,String name) async{
  try{
    final url = Uri.parse('https://vit-hostel-app-backend.onrender.com/verify/$email/$name');
    http.Response response = await http.post(url,headers: {
      'Content-Type' : 'application/json'
    },);
    var data = jsonDecode(response.body);
    return {
      'status': true,
      'otp':data['otp']
    };
  }
  catch(err){
    return {
      'status':false,
      'msg' : err
    };
  }
  
}