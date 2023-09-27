import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vit_hostel_repo/backend/backend.dart';

final db = FirebaseFirestore.instance;

Future<Map<String, dynamic>> loginUser(String email) async {
  try {
    final user = await apiFetch('login', {"email": email});
    if (user['status']) {
      return {
        'isValid': true,
        'email': user['data']['email'],
        'details': user['data'],
        'OTP': user['OTP']
      };
    } else {
      return {'isValid': false, 'type': 'invalidUser'};
    }
  } catch (err) {
    return {'isValid': false, 'type': 'someError'};
  }
}

Future<Map<String, dynamic>> reSendOTP(String email, String name) async {
  try {
    final otpResponse =
        await apiFetch('resend-otp', {"email": email, 'name': name});
    if (otpResponse['status']) {
      return {'status': true, 'otp': otpResponse['OTP']};
    } else {
      return {'status': false, 'msg': 'err'};
    }
  } catch (err) {
    return {'status': false, 'msg': err};
  }
}

Future<Map<String, dynamic>> fetchUserDetails(String email) async {
  try {
    final user = await apiFetch('fetch-user', {"email": email});
    if (user['status']) {
      return {
        'isValid': true,
        'email': user['data']['email'],
        'details': user['data']
      };
    } else {
      return {'isValid': false, 'type': 'invalidUser'};
    }
  } catch (err) {
    print(err);
    return {'isValid': false, 'type': 'someError'};
  }
}
