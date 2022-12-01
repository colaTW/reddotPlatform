import 'dart:developer';

import 'package:flutterapp/pages/CalenderClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';


class Home extends StatefulWidget {
  dynamic data;
  Home({this.data});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  var formatter = new DateFormat('yyyy-mm-dd hh-mm-ss');
  @override
  void initState() {
    print(widget.data);
    if(widget.data==null){}
    else{startTime=DateTime.parse(widget.data);}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
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
          SingleChildScrollView(child:
              Container(
                height: height,
                  color:  Color(0xFF2A3233),
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(child:Image.asset('assets/images/memberlogin/addtoC.png'),),

          Row(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2019, 3, 5),
                        maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        this.startTime = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  child: Text(
                    '事件起始日',
                    style: TextStyle(color: Colors.blue),
                  )),
              Text(formatDate(startTime, [yyyy, '-', mm, '-', dd,' ',HH,':',nn]),style: TextStyle(color: Colors.white),),
            ],
          ),
          Row(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2019, 3, 5),
                        maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        this.endTime = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  child: Text(
                    '事件結束日',
                    style: TextStyle(color: Colors.blue),
                  )),
              Text(formatDate(endTime, [yyyy, '-', mm, '-', dd,' ',HH,':',nn]),style: TextStyle(color: Colors.white)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:
            Container(
                color: Colors.white,
                child: TextField(
              controller: _eventName,
              decoration: InputDecoration(hintText: '事件名稱',),
            )),
          ),
          ElevatedButton(
              child: Text(
                '確認新增',
              ),

              onPressed: () {
                //log('add event pressed');
                calendarClient.insert(
                  _eventName.text,
                  startTime,
                  endTime,
                );
                Future.delayed(Duration(seconds: 5), (){
                  Navigator.of(context).pop();
                  print('延时5s执行');
                });
              }),
        ],
      )))),
    );
  }
}
