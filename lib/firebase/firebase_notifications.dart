import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

final db = FirebaseFirestore.instance;

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<bool> initNotifications(String email) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final Box boxUserDetails = Hive.box('userDetails');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fCMToken = await _firebaseMessaging.getToken();
      try{
        bool response = await updateFCMDatabase(token: fCMToken!,email: email);
        if(response){
        boxUserDetails.put('notificationStatus', true);
      }
      return true;
      }
      catch(err){
        return false;
      }
    } else {
      boxUserDetails.put('notificationStatus', false);
      return false;
    }
  }
}

Future<bool> updateFCMDatabase(
    {required String token, required String email}) async {
  try {
    var deviceToken = {
      "token": token,
      "timestamp": FieldValue.serverTimestamp(),
    };
    await db.collection("fcmTokens").doc(email).set(deviceToken);
    return true;
  } catch (err) {
    return false;
  }
}


Future<bool> turnOffFCMDatabase({required String email}) async {
  try {
    bool error = false;
    await db.collection("fcmTokens").doc(email).delete().then(
      (doc){
        final Box boxUserDetails = Hive.box('userDetails');
        boxUserDetails.put('notificationStatus', false);
      },
      onError: (e){
        error = true;
      },
    );
    return !error;
  } catch (err) {
    return false;
  }
}
