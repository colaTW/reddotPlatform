import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/pages/Member.dart';
import 'package:flutterapp/pages/Member_Fix.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';




class fourpage extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
       body: WebView(
        initialUrl: 'https://baotai.edwardforce.tw/signup',
        javascriptMode: JavascriptMode.unrestricted,

      ),


     /* SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:login,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),

                  labelText: "會員帳號",
                  hintText: "Your account username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:password,
                obscureText:  true,

                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.lock),

                  labelText: "會員密碼",
                  hintText: "Your account password",

                ),
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: RaisedButton(
                child: Text("Login"),
                onPressed: () async{
                  print(login.text);
                  print(password.text);
                  String login_info;
                  login_info = await APIs().login_member(login.text,password.text);    //getData()延遲執行後賦值給data
                  var info=json.decode(login_info);

                  if(info['status']=='success'){
                    print(info['data']['original']['access_token']);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Member_Fix(
                        data:{'tk':info['data']['original']['access_token'],'info':info['data']['original']}
                        )));
                  }
                  else{loginfailDialog(context);}

                },
              ),
            ),
          ],
        ),
      ),*/
    );
  }
  void loginfailDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('登入失敗'),
            title: Center(
                child: Text(
                  '登入訊息',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('确定')),

            ],
          );
        });
  }

}

