import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:get/get.dart';

class JournalDatabase {
  JournalDatabase._();

  static Future<List<JournalModel>> getAllJournalEntries() async {
    final journalRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<SessionService>().userToken.value)
        .collection('journal')
        .limit(1).get();
    if (journalRef.size == 0) {
      return <JournalModel>[];
    }
    final entriesRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<SessionService>().userToken.value)
        .collection('journal').where('createdAt',
        isLessThanOrEqualTo: Timestamp.fromDate(DateTime(Get.find<HomeController>().selectedDate.value.year,
            Get.find<HomeController>().selectedDate.value.month, Get.find<HomeController>().selectedDate.value.day + 1, 0, 0, 0, 0)))
        .where('createdAt',
        isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(Get.find<HomeController>().selectedDate.value.year,
            Get.find<HomeController>().selectedDate.value.month, Get.find<HomeController>().selectedDate.value.day, 0, 0, 0, 0))).get();

    return entriesRef.docs.map((element) => JournalModel.fromMap(element.data())).toList();
  }

  static Future<JournalModel> createNewJournalEntry(JournalModel response) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<SessionService>().sessionUser.value.userID)
        .collection('journal')
        .add(response.toMap())
        .then(
      (value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(Get.find<SessionService>().sessionUser.value.userID)
            .collection('journal')
            .doc(value.id)
            .update({'id': value.id});
        response = response.copyWith(id: value.id);
      },
    );
    return response;
  }

  static Future<JournalModel> updateJournalEntry(JournalModel response) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<SessionService>().sessionUser.value.userID)
        .collection('journal')
        .doc(response.id)
        .update(response.toMap());

    return response;
  }
}
