import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:flutterapp/pages/deal.dart';
import 'package:file_picker/file_picker.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:flutterapp/pages/CalenderClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/pages/deal.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';




class deal_file extends StatefulWidget {
  dynamic data;
  deal_file({this.data});

  @override
  State<StatefulWidget> createState() {
    return _deal_file();
  }
}
class _deal_file extends State<deal_file> {
  var _filepath;
  var file1_id;
  var filename='';
  String gif='assets/images/memberlogin/uploadfile.png';
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    List<Widget> list = new List<Widget>();
    print(deal.filelist);
    for(var i = 0; i < deal.filelist.length; i++){
      if((i%2)==1){list.add(new Text(deal.filelist[i],style:TextStyle(color: Colors.white),));};}
    return new Scaffold(
        appBar: AppBar(
          title: Text("新增處理"),
          backgroundColor: Color(0xFF445154),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body:
        SingleChildScrollView(
            child:
            Container(
              height: height,
                width: width,
                color: Color(0xFF2A3233),
                child:
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Wrap(
                       spacing: 8.0, // 主轴(水平)方向间距
                       runSpacing: 10.0, // 纵轴（垂直）方向间距
                       alignment: WrapAlignment.center,
                       children:list
                       ),
                    SizedBox(height: 50,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                     Container(width:width-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFF898989)) ,),child: Text('確認'),onPressed: ()async{Navigator.pop(context);},)),
                Container(width:width-20,child:ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFF898989)) ,),child: Text('取消'),onPressed: ()async{
                       deal.filelist.clear();
                        Navigator.pop(context);
                        },)),

                    ],)
                  ],
                )
            )
        )
    );
  }

getfillname()async{
    var get=await(APIs().read_string('file_name'));
    setState(() {
      filename=get;
    });
}

}