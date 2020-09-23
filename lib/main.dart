import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_mail/Dispatcher.dart';
import 'package:notification_mail/EmailNotifier.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {

  Workmanager.executeTask((task,inputData) async{
    await Dispatcher.callbackDispatcher();
    return Future.value(true);
  });
}

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  Workmanager.registerPeriodicTask(
    "1",
    "Transaction status",
      frequency: Duration(days: 1));
     runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Status Checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmailNotifier(),
    );
  }
}


