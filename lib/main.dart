import 'package:catcher/model/platform_type.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:flutterapp/pages/Fix.dart';
import 'package:flutterapp/pages/drawboard.dart';
import 'package:googleapis/adsense/v1_4.dart';
import 'pages/fisrtpage.dart';
import 'pages/secondpage.dart';
import 'pages/thirdpage.dart';
import 'pages/fourpage.dart';
import 'pages/fivepage.dart';
import 'package:catcher/catcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutterapp/messaging_widget.dart';
import 'package:firebase_core/firebase_core.dart';



class MyHandler extends ReportHandler{
  @override
  Future<bool> handle(Report error) async{
    Fluttertoast.showToast(
      msg: "系統維修中",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
        timeInSecForIosWeb:20,
    );
    var params = Map<String, String>();
    params["message"] =  error.error.toString()+"\nstackTrace:\n"+error.stackTrace.toString();
    var client = http.Client();
    var response = await client.post('https://baotai.com.tw/api/v1/app/logs', body: params);
    print(params);
    return true;
  }
  @override
  List<PlatformType> getSupportedPlatforms() =>
      [PlatformType.Android, PlatformType.iOS, PlatformType.Web];

}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /// STEP 1. Create catcher configuration.
  /// Debug configuration with dialog report mode and console handler. It will show dialog and once user accepts it, error will be shown   /// in console.
  CatcherOptions debugOptions =
  CatcherOptions(SilentReportMode(), [MyHandler(),]);

  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [MyHandler(),]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
  checkPermission();

    ByteData data = await rootBundle.load('assets/raw/bc6bba6943229ed5.pem');
    SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());



}

void checkPermission() async{
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    Permission.camera
  ].request();
}


class MyApp extends StatelessWidget {


  static String token='';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:MessagingWidget());
   /* return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
      home: DefaultTabController(
        length: 5, //選項卡頁數
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF445154),
            title:
            Container(
              child: Row
              (
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
              Expanded(child:Image.asset("assets/images/home/toplogo.png",)),
              ],),),
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            bottom:
            new PreferredSize(
                preferredSize: new Size(1000, 80),
                child: new Container(
                    child: new TabBar(
                      labelPadding: EdgeInsets.all(0),
                      tabs: [
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b1.png',fit:BoxFit.fill,),
                        ),
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b2.png',fit:BoxFit.fill,),
                        ),
                        new Container(
                          child: Image.asset('assets/images/buttuns/b4.png',fit:BoxFit.fill,),
                        ),
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b3.png',fit:BoxFit.fill,),
                        ),
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b5.png',fit:BoxFit.fill,),
                        ),
                      ],
                    ))),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              firstpage(),
              secondpage(),
              thirdpage(),
              fourpage(),
              fivepage()
            ],
          ),
        ),
      ),
    );*/
  }
}
