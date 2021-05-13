import 'package:flutter/material.dart';


class MessageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Map<String, String> args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    int c = int.parse(args['cantidad']!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(args['producto']!, style: TextStyle(fontSize: 30),),
            Text('$c unidades', style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}