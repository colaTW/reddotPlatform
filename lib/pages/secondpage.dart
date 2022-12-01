import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/main_employee.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main_employee.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class secondpage extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  var isDisable=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF445154),
        title: Text("Login"),
      ),
      body:
          Container(
              child:
      GestureDetector(

        onTap: (){FocusScope.of(context).requestFocus(FocusNode());
        },
          child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                  controller:login,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),

                  labelText: "員工帳號",
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

                  labelText: "員工密碼",
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
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: isDisable?null:()
                async{

                if(await APIs().isNetWorkAvailable()==0){
                  Fluttertoast.showToast(
                      msg: "請連接WIFI或使用行動網路",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,

                  );
                }
                else {
                  String login_info;
                  login_info = await APIs().login(
                      'admin', 'admin123'); //getData()延遲執行後賦值給data
                  var info = json.decode(login_info);

                  // print(info['data']['token']);
                  if (info['status'] == 'success') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => main_employee(
                            data: {
                              'tk': info['data']['token'],
                              'ID': info['data']['user_id']
                            })));
                  }
                  else {
                    loginfailDialog(context);
                  }
                }
                  }
                ,
              ),
            ),
          ],
        ),
      ))),
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

