import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/messaging_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/main_employee.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:flutterapp/pages/fisrtpage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main_employee.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class register extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController checkpassword = TextEditingController();
  TextEditingController buildname = TextEditingController();

  var isDisable=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF445154),
        title: Text("Register"),
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

                  labelText: "帳號",
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:checkpassword,
                obscureText:  true,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "確認密碼",
                  hintText: "Confirm your password",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:buildname,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.assignment),
                  labelText: "建案名稱",
                  hintText: "Your building ID",
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
                child: Text("註冊"),
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
                  Navigator.of(context).pop();
                  loginfailDialog(context);
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
            content: Text('註冊成功'),
            title: Center(
                child: Text(
                  '註冊狀態',
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

