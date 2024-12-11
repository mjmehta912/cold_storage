import 'dart:convert';

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/screens/auth/login/login_controller.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

const String darwinNotificationCategoryPlain = 'none';

class LocalNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final _notification = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  late InitializationSettings initializationSettings;

  Future init() async {
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);
    _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotification(notificationResponse);
            //     selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            //   if (notificationResponse.actionId == navigationActionId) {
            // //    selectNotificationStream.add(notificationResponse.payload);
            //   }
            break;
        }
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  DarwinNotificationDetails iosNotificationDetails =
      const DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  Future<void> selectNotification(NotificationResponse pay) async {
    print('pay.payload :: ${pay.payload}');
    var json = jsonDecode(pay.payload ?? '');

    notificationHandlerTap(json);
  }

  notificationHandlerTap(Map json) async {
    print("Click on notification $json");
    try {
      if (json.containsKey('screenName')) {
        if (json['screenName'] == 'loginScreen') {
          Get.toNamed(kRouteLoginView, arguments: true);
          Get.find<LoginController>().setIntentData();
          // Get.put(() => LoginController());
          // LoginController().onInit();
          // LoginController().resetVariables();
          // LoginController().update();
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
          // Get.put(() => LoginController());
          // LoginController().onInit();
          // LoginController().resetVariables();
          // LoginController().update();
        }
      }

      /* if (json.containsKey("type")) {
        if (json["type"] == "LIKE" || json["type"] == "EXPIRED") {
          if (json.containsKey("id") && json["id"].toString().isNotEmpty) {
            Get.to(() => ViewPostActivity(), arguments: {'postId': json["id"] ?? ""});
          } else {
            Get.offAll(() => MainScreen());
          }
        } else if (json["type"] == "FOLLOW" || json["type"] == "REJECT_CHALLENGE" || json["type"] == "ACCEPT_CHALLENGE") {
          Get.offAll(() => MainScreen(currentIndex: 2));
        } else if (json["type"] == "COMMENT" || json["type"] == "REPLY") {
          Get.to(() => CommentActivity(), arguments: {'postId': json["id"], 'profileImage': json["url"] ?? "", 'currentSec': 100});
        } else if (json["type"] == "CHALLENGE_EXPIRED") {
          Get.to(() => WinnerActivity(), arguments: {'challengePostId': json["id"]});
        } else if (json["type"] == "CHAT") {
          Get.offAll(() => MainScreen(currentIndex: 1));
        }
      }*/

      handleClick(json);
    } catch (e) {
      e.printError();
    }
  }

  void handleClick(Map json) {
    try {
      // var json = message.data;
      if (json.containsKey("type")) {
        if (json["type"] == "LIKE" ||
            json["type"] == "EXPIRED" ||
            json["type"] == "REPLY") {
          if (json["type"] == "ACCEPT_CHALLENGE") {
            // Get.off(() => ViewChallengeActivity(), arguments: {
            //   'postId': json["id"] ?? "",
            //   'fromNotification': true
            // });
          } else {
            // Get.off(MainScreen());
          }
        } else {
          // Get.off(MainScreen());
        }
      }
    } catch (e) {
      e.printError();
    }
  }

/*if (json != null) {
      Get.to(ChatActivity());
    }*/

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'General Notification',
          'General Notification',
          importance: Importance.max,
          channelShowBadge: true,
          color: kColorPrimary,
          enableVibration: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails());
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
// ignore: avoid_print
/*   print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');*/
    if (notificationResponse.input?.isNotEmpty ?? false) {
// ignore: avoid_print

//       Get.to(ChatActivity());
    }
  }
}
