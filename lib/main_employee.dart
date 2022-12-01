import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:flutterapp/pages/fisrtpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:flutterapp/pages/fisrtpage.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:flutterapp/pages/logoutpage.dart';




class main_employee extends StatefulWidget {
  dynamic data;
  main_employee({this.data});

  @override
  State<StatefulWidget> createState() {
    return _main_employee();
  }
}
class _main_employee extends State<main_employee> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, //選項卡頁數
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF445154),
            title:  Container(
              child: Row
                (
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child:Image.asset("assets/images/home/reddotLogo.png",)),
                ],),),
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,


          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Employee(data:widget.data),
              firstpage(),
              Text(''),
             // Text('123'),

            ],
          ),
        ),
      ),
    );
  }

}