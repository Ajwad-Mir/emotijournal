import 'dart:developer';
import 'dart:io';

import 'package:emotijournal/firebase_options.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthProviderService {
  GoogleSignInAccount? googleUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: Platform.isIOS ? DefaultFirebaseOptions.ios.iosClientId : DefaultFirebaseOptions.android.androidClientId);

  Future<UserCredential?> signInWithGoogle() async {
    try {
      googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        Fluttertoast.showToast(
          msg: 'User cancelled the operation',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.sp,
          fontAsset: Assets.fontsPoppinsRegular,
          textColor: AppColors.white,
          backgroundColor: AppColors.black,
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (error) {

      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.sp,
        fontAsset: Assets.fontsPoppinsRegular,
        textColor: AppColors.white,
        backgroundColor: AppColors.black,
      );
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();

      googleUser = null;

      await FirebaseAuth.instance.signOut();
    } catch (error) {
      log("Error during logout: $error");
    }
  }
}
