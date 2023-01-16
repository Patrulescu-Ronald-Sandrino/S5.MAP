import 'dart:io';

import 'package:books_app/ui/books_screen.dart';
import 'package:flutter/material.dart';

// TODO #1 check requirements
// TODO #2 run other app


/*
- network conectivity listener - when online, sync w/ database
- when offline:
- update/delete - message will be displayed, that the application is offline and the operation is not available.
- read - the content from the local database will be displayed, with a note that the server connection is down
- create - the input will be persisted in the local database and when the application will detect that the device is able to connect
         again to the server will push only the created entries, while the device was offline
*/

// https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // await _getDatabase(); // TODO: is this required?
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      theme: ThemeData(
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const BooksScreen(),
    );
  }
}
