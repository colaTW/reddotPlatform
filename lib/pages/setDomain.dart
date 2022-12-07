import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
class setDoamin extends StatefulWidget {
  @override
  _setDoamin createState() => _setDoamin();

}

class _setDoamin extends State<setDoamin> {

  var textStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("二维码"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,  //充满屏幕宽度,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,  //居中
          children: [
            SizedBox(height: 50,),
            ElevatedButton(
              child: Text("二维码扫描"),
              onPressed: () async{
               // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
              },
            ),
            SizedBox(height: 20,),
            Text("扫描内容为${this.textStr}"),
          ],
        ),
      ),
    );
  }

  //扫描二维码

}


