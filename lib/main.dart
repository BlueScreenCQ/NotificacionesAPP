import 'package:flutter/material.dart';
import 'package:notificaciones/screens/MessageScreen.dart';
import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/services/push_notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PushNotificationService.initicalizeApp();

  runApp(NotificacionesApp());
}

class NotificacionesApp extends StatefulWidget {
  @override
  _NotificacionesAppState createState() => _NotificacionesAppState();
}

class _NotificacionesAppState extends State<NotificacionesApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    //Tenemos context!
    PushNotificationService.messageStream.listen((message) {

      //print('Main: $message');

      //No se puede, aun no existen las páginas
      //Navigator.pushNamed(context, 'message');
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackbar = new SnackBar(
        content: Text(message['producto']!),
      );

      messengerKey.currentState?.showSnackBar(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notificaciones',
      initialRoute: 'home',
      navigatorKey: navigatorKey, //Para navegar
      scaffoldMessengerKey: messengerKey, //Para mostrar snacks
      routes: {
        'home'    : (_) => HomeScreen(),
        'message' : (_) => MessageScreen(),
      },
    );
  }
}
