import 'dart:io';

import 'package:flutter/cupertino.dart';
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



class deal_how extends StatefulWidget {
  dynamic data;
  deal_how({this.data});

  @override
  State<StatefulWidget> createState() {
    return _deal_how();
  }
}
class _deal_how extends State<deal_how> {
  int way;
  int how;
  var HandlerTypes;
  var howWidth;
  var howHeight;
  TextEditingController mesg = TextEditingController();
  @override
  void initState() {
    super.initState();
 setState(() {
  how=int.parse(widget.data['go']);
  HandlerTypes=widget.data['HandlerTypes'];
 });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    howWidth=width;
    return new Scaffold(
        appBar: AppBar(
          title: Text("維修進度"),
          backgroundColor: Color(0xFF445154),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body:
        SingleChildScrollView(
            child:
            Container(
              width: double.infinity,
                height:height,
                color: Color(0xFF2A3233),
                child:
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  data(),
                )

            )
        )
    );
  }
  data()  {
    List<Widget> list = List();
    list.add(SizedBox(height: 50,));
    for (int i = 1; i < HandlerTypes.length; i++) {
      list.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Theme(
              data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                  disabledColor: Colors.blue
              ),
              child:
              Radio(
                value: HandlerTypes[i]["id"],
                groupValue: this.how,
                onChanged: (value) {
                  setState(() {this.how = value;});
                },
              )),Center(child: Text(HandlerTypes[i]["name"].padRight(6, '　'),style: TextStyle(color: Colors.white)))],
      ));
    }
    list.add(Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(width:howWidth-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFFC9CACA)) ,),child: Text('確認'),onPressed: ()async{
            APIs().save("how",how);
            Navigator.pop(context);
          },)),
          Container(width:howWidth-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFF898989)) ,),child: Text('取消'),onPressed: ()async{
            Navigator.pop(context);
          },))
        ]));
    return list;
  }

}