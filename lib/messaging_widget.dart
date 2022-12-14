import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/message.dart';
import 'package:flutterapp/pages/adminLogin.dart';
import 'package:flutterapp/pages/setDomain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/fisrtpage.dart';
import 'pages/secondpage.dart';
import 'pages/thirdpage.dart';
import 'pages/fourpage.dart';
import 'pages/fivepage.dart';
import 'package:catcher/catcher.dart';


class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message1> messages = [];
  final url = "https://liff.line.me/1656005426-ZdRn10xN?page=check";
  String notify_token="";
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token){
      notify_token=token;
      print("token"+token);});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      RemoteNotification  notification = message.notification;
      Alert(context: context, title: notification.title, desc: notification.body,type:AlertType.warning,buttons: []).show();
      setState(() {
        messages.add(Message1(
            title: notification.title, body: notification.body));
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      print("onMessageOpenedApp: $message");
      RemoteNotification  notification = message.notification;
      setState(() {
        messages.add(Message1(
          title: '${notification.title}',
          body: '${notification.body}',
        ));
      });
    });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    /*if(APIs().getDomainIP()==""){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => setDoamin()));
    }*/

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
      home: DefaultTabController(
        length: 1, //???????????????
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF445154),
            title:
            Container(
              child: Row
                (
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Image.asset("assets/images/home/reddotLogo.png",),
                    onTap:()async{

                    },
                      onLongPress:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => adminLogin()));
                      }
                  )
                ],),),
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,

          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              firstpage(),

            ],
          ),
        ),
      ),
    );
  }

}
