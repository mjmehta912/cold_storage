import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/helper/controller/controller_binding.dart';
import 'package:cold_storage/app/screens/splash/splash_screen.dart';
import 'package:cold_storage/app/services/firebase_options.dart';
import 'package:cold_storage/app/services/firebase_services.dart';
import 'package:cold_storage/app/services/local_notification_services.dart';
import 'package:cold_storage/get_route_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseServices().initNotification();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotifications().init();
  // await FirebaseServices().initializeFirebaseMessages();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        initialBinding: ControllerBindings(),
        home: const SplashScreen(),
        getPages: GetRoutePages.routePage,
      ),
    );
  }
}
