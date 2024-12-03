import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotijournal/app/models/user_model.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:get/get.dart';

class UsersDatabase {
  UsersDatabase._();

  static Future<void> createUser({required UserModel newUserData}) async {
    await FirebaseFirestore.instance.collection('users').doc(newUserData.userID).set(newUserData.toMap());
    Get.find<SessionService>().sessionUser.value = newUserData;
  }

  static Future<bool> checkIfUserExists(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }

  static Future<void> updateUser({required UserModel updatedUserData}) async {
    await FirebaseFirestore.instance.collection('users').doc(updatedUserData.userID).update(updatedUserData.toMap());
    Get.find<SessionService>().sessionUser.value = updatedUserData;
  }

  static Future<UserModel> getUserFromID(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists == false) {
      return UserModel.empty();
    }
    return UserModel.fromMap(document: doc);
  }
}
