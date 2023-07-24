/*import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ref =>  https://medium.com/@viveky259259/flutter-firebase-notifications-7954a3ad8111
class FirebaseNotifications {
  static FirebaseMessaging? _firebaseMessaging;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  void init() {
    _firebaseMessaging ??= FirebaseMessaging.instance;
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    if (Platform.isIOS) {
      iOSPermission();
    }
    _firebaseMessaging!.onTokenRefresh.listen((token) {
      assert(token.isNotEmpty);
      postDeviceToken(token);
    });
    _firebaseMessaging!.getToken().then((token) {
      assert(token != null);
      debugPrint("token:$token");
      *//*String oldToken = _session.getString(Constant.DEVICE_TOKEN);
      if (oldToken == token) {
        return;
      }*//*
      postDeviceToken(token);
    });
    /// To send notification to all user
    FirebaseMessaging.instance.subscribeToTopic('JumpqVendor');
  }

  void postDeviceToken(var newToken) async {
    debugPrint("token$newToken");
   // //logMessage("FirebaseNotifications => $newToken");
    //Repository().postFCMToken(deviceFCMToken: newToken);
    // if(newToken != _session.getString(Constant.DEVICE_FCM_TOKEN))
    //   {
    //     _session.setValue(Constant.DEVICE_FCM_TOKEN, newToken);
    //     Repository().postFCMToken(deviceFCMToken: newToken);
    //   }
  }

  void messageListener(onNotification) async{
    // /// FIXME Remove check
    if(Platform.isIOS) {
      return;
    }
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android:
    initializationSettingsAndroid, iOS:initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: onSelectNotification);

    /// Handle notification click when app is in kill state with flutter_local_notifications
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if(notificationAppLaunchDetails!=null && notificationAppLaunchDetails.payload!=null) {
      //logMessage("notificationAppLaunchDetails.payload ${notificationAppLaunchDetails.payload}");
      openScreen(json.decode(notificationAppLaunchDetails.payload!));
    }

    /// Handle notification click when app is in kill state with firebase_messaging
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        ////logMessage('A new getInitialMessage event was published! ${message.data}');
        // showToast("A new getInitialMessage event was published!");
        var data=message.data;
        Map payloadMap = data["payload"] is Map ?data["payload"]:json.decode(data["payload"]) ?? {};
        openScreen(payloadMap);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //logMessage('Got a message whilst in the foreground!');
      //logMessage('Message data: ${message.data}');

      if (message.notification != null) {
        //logMessage('Message also contained a notification: ${message.notification}');
      }
      Map data=message.data;
      if(data.containsKey("is_silent"))
      {
      }
      else {
        //logMessage("$data");
        if(message.notification!=null) {
          print("checkOnNot");
          if((message.notification?.title??"")!="") {
            data.putIfAbsent("title", () => message.notification!.title);
          }
          if((message.notification?.body??"")!="") {
            data.putIfAbsent("body", () => message.notification!.body);
          }
        }
        onNotification(data);
        showNotification(data);
        // SentryReporter.sendSentryEvent("onMessage Notification",extra: message);
      }
    });

  }

  static Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    //logMessage("myBackgroundMessageHandle");
    final Map data = message.data;
    if(message.notification!=null) {
      if((message.notification!.title??"")!="") {
        data.putIfAbsent("title", () => message.notification!.title);
      }
      if((message.notification!.body??"")!="") {
        data.putIfAbsent("body", () => message.notification!.body);
      }
    }
    // showNotification(data);
    //logMessage("data : $data");
    // SentryReporter.sendSentryEvent("myBackgroundMessageHandler Notification",extra: message);
    // Or do other work.
  }

  static openScreen(var payloadMap) async
  {
    //logMessage("notification handler openScreen $payloadMap");
    if(payloadMap==null) {
      return;
    }

    if(payloadMap is String) {
      payloadMap = json.decode(payloadMap);
    }
    //logMessage("notification handler openScreen $payloadMap");
    try {
      switch(payloadMap["event"])
      {
        case "chat_message":

          return;

        default:
          //navigatorPush( const NotificationView(title: "Notification"));
          //logMessage("openScreen : $payloadMap");
      }
    }catch(error){
      //SentryReporter.sendSentryEvent("openScreen Notification error", extra: error);
    }
  }

  Future onSelectNotification(String? payload) async {
    //logMessage("onSelectNotification : $payload");
    if(payload!=null) {
      Map payloadMap = json.decode(payload);
      openScreen(payloadMap);
    }

  }
  static getSummaryText(Map payload)
  {
    return "TieBreaker";
  }

  static void showNotification(data)
  {
    //logMessage("showNotification => $data");
    try {
      var id = data["id"] ?? "${DateTime.now().millisecondsSinceEpoch}";
      var title = data["title"] ?? "title";
      var body = data["body"] ?? "body";
      var payload = data["payload"] ?? {};
      //logMessage("payload $payload");
      var channel = data["channel"] ?? "General";


//    int importance=int.parse(data["importance"]??"3");

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          id,
          channel,
          icon: "app_icon",
          playSound: true,
          // importance: Importance.high,
          // priority:Priority.high,
          channelDescription:  'Notification Channel for tie_breaker. All the tie_breaker notifications will arrive here.',
          styleInformation: BigTextStyleInformation(
              title,
              htmlFormatBigText: true,
              contentTitle: body,
              htmlFormatContentTitle: true,
              summaryText: getSummaryText(payload is Map?payload:json.decode(payload)),
              htmlFormatSummaryText: true));
      var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics,iOS: null);
      flutterLocalNotificationsPlugin.show(5, title,
          body, platformChannelSpecifics,payload: payload.toString()).catchError((error){
        //logMessage("notification shooing error $error");
      });
    }
    catch(error)
    {
      //logMessage("Show notification error $error");
    }
  }
  void iOSPermission()async{

    NotificationSettings settings = await _firebaseMessaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //logMessage('User granted permission: ${settings.authorizationStatus}');
  }
}*/
