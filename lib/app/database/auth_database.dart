import 'dart:async';
import 'package:emotijournal/app/services/auth_providers/google_auth_provider_services.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class AuthDatabase {
  AuthDatabase._();

  static Future<UserCredential?> loginExistingAccountSimple(
      {required String email, required String password}) async {
    try {
      final data = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print(data.user.toString());
      }
      GetStorage().write('userToken', data.user!.uid);
      return data;
    } on FirebaseException catch (e) {
      if (e.code.toLowerCase() == 'user-not-found' ||
          e.code.toLowerCase() == 'invalid-credential') {
        Fluttertoast.showToast(
          msg: "User not found. Please register this account.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.sp,
          fontAsset: Assets.fontsPoppinsRegular,
          textColor: AppColors.white,
          backgroundColor: AppColors.black,
        );
        return null;
      } else if (e.code.toLowerCase() == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Password is invalid",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.sp,
          fontAsset: Assets.fontsPoppinsRegular,
          textColor: AppColors.white,
          backgroundColor: AppColors.black,
        );
        return null;
      } else {
        if (kDebugMode) {
          print(e.toString());
        }
        return null;
      }
    }
  }

  static FutureOr<UserCredential?> loginExistingAccountProvider(
      {required String providerName}) async {
    try {
      final UserCredential? data;
      if (providerName.toLowerCase() == "google") {
        data = await GoogleAuthProviderService().signInWithGoogle();
        if (data != null) {
          if (kDebugMode) {
            print(data.user.toString());
          }
          GetStorage().write('userToken', data.user!.uid);
          return data;
        } else {
          return null;
        }
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<UserCredential?> createNewAccountSimple(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final data = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await data.user?.updateProfile(displayName: userName, photoURL: "");
      if (kDebugMode) {
        print(data.user.toString());
      }
      GetStorage().write('userToken', data.user!.uid);

      return data;
    } on FirebaseException catch (e) {
      if (e.code.toLowerCase() == 'user-already-exist') {
        Fluttertoast.showToast(
          msg: "User already exists. Please sign in.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.sp,
          fontAsset: Assets.fontsPoppinsRegular,
          textColor: AppColors.white,
          backgroundColor: AppColors.black,
        );
      } else if (e.code.toLowerCase() == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Password is invalid",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.sp,
          fontAsset: Assets.fontsPoppinsRegular,
          textColor: AppColors.white,
          backgroundColor: AppColors.black,
        );
      } else {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      return null;
    }
  }

  static FutureOr<UserCredential?> createNewAccountProvider(
      {required String providerName}) async {
    try {
      final UserCredential? data;
      if (providerName.toLowerCase() == "google") {
        data = await GoogleAuthProviderService().signInWithGoogle();
        if (data != null) {
          if (kDebugMode) {
            print(data.user.toString());
          }
          GetStorage().write('userToken', data.user!.uid);
          return data;
        } else {
          return null;
        }
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
