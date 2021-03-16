import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:study/tabControl.dart';
import 'home.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    void firebaseCloudMessaging_Listeners() {
      print("firebaseCloudMessaging_Listeners()");
      _firebaseMessaging.getToken().then((token){
        print('token:'+token);
      });

      _firebaseMessaging.configure(
        /** 앱이 실행중인 경우 **/
        onMessage: (Map<String, dynamic> message) async {
          print("FCM onMessage: $message");
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(message["notification"]["title"]),
                  subtitle: Text(message["notification"]["body"]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
          );
          Navigator.push(context,
            MaterialPageRoute<void>(builder: (BuildContext context){
              return MySecondHome();
            }),
          );
          return ;
        },

        /** 앱이 완전히 종료된 경우 **/
        onLaunch: (Map<String, dynamic> message) async {
          print("FCM onLaunch: $message");
          Navigator.push(context,
            MaterialPageRoute<void>(builder: (BuildContext context){
              return MySecondHome();
            }),
          );
          return ;
        },

        /** 앱이 닫혀있지만 백그라운드로 동작중인 경우 **/
        onResume: (Map<String, dynamic> message) async {
          print("FCM onResume: $message");
          Navigator.push(context,
            MaterialPageRoute<void>(builder: (BuildContext context){
              return MySecondHome();
            }),
          );
          return ;
        },
      );

      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true)
      );

    }
    firebaseCloudMessaging_Listeners();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "sowon Title" , age: "20",),
    );
  }
}
