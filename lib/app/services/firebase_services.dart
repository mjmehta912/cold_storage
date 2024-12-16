import 'dart:convert';

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/auth/login/login_controller.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FirebaseServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  /// initialize firebase notifications
  Future<void> initNotification() async {
    /// request permission
    await _firebaseMessaging.requestPermission();

    initPushNotification();
  }

  /// get fcm token
  Future<String> getFCMToken() async {
    String token = '';
    try {
      token = await FirebaseMessaging.instance.getToken() ?? '';
      return token;
    } catch (e) {
      LoggerUtils.logException('getFCMToken', e);
      return token;
    }
  }

  Future initPushNotification() async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // ID
        'High Importance Notifications', // Name
        description: 'This channel is used for important notifications.',
        // Description
        importance: Importance.high,
      );

      /// handle terminated app listener
      FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
          if (message != null) {
            flutterLocalNotificationsPlugin.show(
              message.hashCode,
              message.notification?.title ?? '',
              message.notification?.body ?? '',
              payload: message.data.toString(),
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'launch_background',
                ),
              ),
            );
            handleClick(message);
          }
        },
      );

      /// handle background listener
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title ?? '',
            message.notification?.body ?? '',
            payload: jsonEncode(message.data),
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ),
          );
          // handleClick(message);
        },
      );

      /// handle open app listener
      FirebaseMessaging.onMessageOpenedApp.listen(handleClick);
    } catch (e) {
      LoggerUtils.logException('initPushNotification', e);
    }
  }

  initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBTR75mhMgygxuEp7fpHiK3Ui7Gm7ISjBI',
          appId: '1:104309120851:android:a036fdcb281cd4e5780ba6',
          messagingSenderId: '104309120851',
          projectId: 'cold-storage-97239',
        ),
      );
    } catch (e) {
      LoggerUtils.logException('initializeFirebase', e);
    }
  }

  initializeFirebaseMessages() async {
    try {
      FirebaseMessaging fcm = FirebaseMessaging.instance;

      // ignore: unused_local_variable
      NotificationSettings settings = await fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // ID
        'High Importance Notifications', // Name
        description: 'This channel is used for important notifications.',
        // Description
        importance: Importance.high,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ),
          );
        }
      });

      fcm.getInitialMessage().then(
            (value) => () {
              try {
                if (value?.data != null) {
                  handleClick(value!);
                }
              } catch (e) {
                e.printError();
              }
            },
          );

      FirebaseMessaging.onBackgroundMessage(
        (message) async {
          await Firebase.initializeApp();
          return backgroundHandler(message);
        },
      );
    } catch (e) {
      LoggerUtils.logException('initializeFirebaseMessages', e);
    }
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    handleClick(message);
  }

  /// handle received message onClick
  Future<void> handleClick(RemoteMessage? message) async {
    try {
      var json = message?.data;

      if (json != null) {
        if (json.containsKey('screenName')) {
          if (json['screenName'] == 'loginScreen') {
            Get.toNamed(kRouteLoginView, arguments: true);
            Get.find<LoginController>().setIntentData();
            // Get.lazyPut(() => LoginController());
            // Get.offAllNamed(kRouteLoginView);
            // Get.find<LoginController>().resetVariables();
            // Get.find<LoginController>().update();
          } else if (json['screenName'] == 'notificationScreen') {
            bool? isLoggedIn = await Get.find<LocalStorage>()
                .getBoolFromStorage(kStorageIsLoggedIn);
            if (isLoggedIn == true) {
              AppConst.userName = await Get.find<LocalStorage>()
                  .getStringFromStorage(kStorageUserName);
              Get.toNamed(kRouteNotificationView, arguments: true);
            } else {
              Get.offAllNamed(kRouteLoginView);
            }
            // Get.toNamed(kRouteNotificationView, arguments: true);
          }
        } else {
          if (Get.isRegistered<LoginController>()) {
            Get.toNamed(kRouteLoginView, arguments: true);
            Get.find<LoginController>().setIntentData();
            // Get.lazyPut(() => LoginController());
            // Get.offAllNamed(kRouteLoginView);
            // Get.find<LoginController>().resetVariables();
            // Get.find<LoginController>().update();
          }
        }
      }
      // if (json.containsKey("type")) {
      //   splashController.openHome = false;
      //   if (json["type"] == "ACCEPT_CHALLENGE") {
      //     Get.off(() => ViewChallengeActivity(), arguments: {
      //       'postId': json["id"] ?? "",
      //       'fromNotification': true
      //     });
      //   } else {
      //     Get.off(MainScreen());
      //   }
      // }
    } catch (e) {
      e.printError();
    }
  }
}
