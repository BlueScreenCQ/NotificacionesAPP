//SHA1 39:99:89:88:3E:64:E6:FC:00:FE:B9:08:EE:CC:F5:F6:B4:8D:1D:72

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationService {


  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String,String>> _messageStream = new StreamController.broadcast();
  static Stream<Map<String,String>> get messageStream => _messageStream.stream;

  static Future _onBackgroundHandler( RemoteMessage message ) async {
    //print('onBackground Handler: ${message.messageId}');
    //Cuando recibe una notificación la añade al stream

    Map<String, String> map = {
      'producto': message.data['producto'],
      'cantidad': message.data['cantidad']
    };

    _messageStream.add(map);
  }

  static Future _onMessageHandler( RemoteMessage message ) async {
    //print('on Message Handler: ${message.messageId}');
   // _messageStream.add(message.data['producto'] ?? 'No data');

    Map<String, String> map = {
      'producto': message.data['producto'],
      'cantidad': message.data['cantidad']
    };

    _messageStream.add(map);
  }


  static Future _onMessageOpenApp( RemoteMessage message ) async {
    //print('Background Handler: ${message.messageId}');
    _messageStream.add(message.data['producto'] ?? 'No data');

    Map<String, String> map = {
      'producto': message.data['producto'],
      'cantidad': message.data['cantidad']
    };

    _messageStream.add(map);
  }


  static Future initicalizeApp() async {

    //Push notification
    await Firebase.initializeApp();
    await requestPermissions();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //Handler
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local notification
  }

  //Apple y Web
  static requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User push notification status: ${settings.authorizationStatus}');
  }

  static closeStreams(){
    _messageStream.close();
  }

}