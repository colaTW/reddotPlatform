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
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';




class deal_message extends StatefulWidget {
  dynamic data;
  deal_message({this.data});

  @override
  State<StatefulWidget> createState() {
    return _deal_message();
  }
}
class _deal_message extends State<deal_message> {

  TextEditingController mesg = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  void initState() {
    super.initState();
 setState(() {
  mesg.text=widget.data['message'];
  price.text=widget.data['price'];
 });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return new Scaffold(
        appBar: AppBar(
          title: Text("維修說明"),
          backgroundColor: Color(0xFF445154),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body:
    GestureDetector(
    onTap: (){FocusScope.of(context).requestFocus(FocusNode());
    },
    child:
        SingleChildScrollView(
            child:
            Container(
              height: height,
              padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                color: Color(0xFF2A3233),                child:
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text('Remarks / 備註',style:TextStyle(color: Colors.white)),
                Container(
                  color: Colors.white,
                  child:
                    TextFormField(

                      controller: mesg,
                      minLines: 10,
                      maxLines: 15,
                    )),
                    SizedBox(height: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(width:width-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFFC9CACA)) ,),child: Text('確認'),onPressed: ()async{
                          APIs().save_string("message",mesg.text.toString());
                          APIs().save_string("price",'');

                          Navigator.pop(context);},)),
                        Container(width:width-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFF898989)) ,),child: Text('取消'),onPressed: ()async{
                          Navigator.pop(context);
                        },)),

                      ],),

                  ],
                )
            )
        ))
    );
  }

}