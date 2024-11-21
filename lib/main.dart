import 'package:emotijournal/app/apis/openai_apis.dart';
import 'package:emotijournal/app/bindings/controller_bindings.dart';
import 'package:emotijournal/app/modules/splash/page/splash_page.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:emotijournal/app/services/theme_service.dart';
import 'package:emotijournal/firebase_options.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await JournalAI.initialize();
  await JournalAI.getFirstResponse('I feel a bit troubled about my job. it feels like everyone is ignoring me and not even taking my opinion to any conversation.I feel alienated from my company and colleagues');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.put(ThemeService(),permanent: true);
    Get.put(SessionService(),permanent: true);
    createSystemUISettings(context);
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      builder: (context, _) => GetMaterialApp(
        title: 'EmotiJournal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: AppColors.white,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: AppColors.white,
          ),
        ),
        themeMode: themeService.currentThemeMode.value,
        initialBinding: ControllerBindings(),
        home:  const SplashPage(),
      ),
    );
  }

  void createSystemUISettings(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black.withOpacity(0.005),
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light, //Android Icons
              statusBarBrightness: Brightness.dark, //iOS Icons
              statusBarColor: Colors.black.withOpacity(0.005),
            )
          : SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white.withOpacity(0.005),
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark, //Android Icons
              statusBarBrightness: Brightness.light, //iOS Icons
              statusBarColor: Colors.black.withOpacity(0.005),
            ),
    );
  }
}
