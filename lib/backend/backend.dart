import 'dart:convert';
import 'package:restart_app/restart_app.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> apiFetch(String route, Map<String, dynamic> body) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? JWT = prefs.getString('JWT') ?? 'null';
    Map<String,String> headers;
    if(route == 'login' || route == 'resend-otp'){
      headers = {
          'Content-Type': 'application/json'
        };
    }
    else{
      headers = {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $JWT'
        };
    }
    final url = Uri.parse('http://10.0.2.2:3000/app/$route');
    http.Response response = await http.post(url,
        headers: headers,
        body: jsonEncode({"data": body}));
    var data = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 403) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', false);
      await Hive.box('userDetails').clear();
      await Hive.box('messMenu').clear();
      await Hive.box('complaints').clear();
      Restart.restartApp();
    } else {
      return data;
    }
  } catch (err) {
    return {'status': false, 'msg': err};
  }
}
