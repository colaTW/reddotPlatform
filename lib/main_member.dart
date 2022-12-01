import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:flutterapp/pages/Member.dart';
import 'package:flutterapp/pages/Member_Fix.dart';
import 'package:flutterapp/pages/fisrtpage.dart';
import 'package:flutterapp/pages/buildsign.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:flutterapp/pages/fisrtpage.dart';
import 'package:flutterapp/pages/Employee.dart';
import 'package:flutterapp/pages/logoutpage.dart';




class main_member extends StatefulWidget {
  dynamic data;
  main_member({this.data});

  @override
  State<StatefulWidget> createState() {
    return _main_member();
  }
}
class _main_member extends State<main_member> {


  @override
  void initState() {
    super.initState();
    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: DefaultTabController(
        length: 5, //選項卡頁數
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF445154),
            title:  Container(
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
                      isScrollable: true,

                      labelPadding: EdgeInsets.all(0),
                      tabs: [
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b1.png',height: 75,fit:BoxFit.fill,),
                        ),
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b11.png',height: 75,fit:BoxFit.fill,),
                        ),
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b12.png',height: 75,fit:BoxFit.fill,),
                        ),
                        new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b10.png',height: 75,fit:BoxFit.fill,),
                        ),
                      /*  new Container(
                          padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                          child: Image.asset('assets/images/buttuns/b8.png',height: 75,fit:BoxFit.fill,),
                        ),*/
                        Container(child: GestureDetector(child:Image.asset('assets/images/buttuns/b7.png',height: 75,fit:BoxFit.fill,),onTap:(){ Navigator.pop(context);
                        },))
                       // new Container(
                        //  child: Image.asset('assets/images/buttuns/b7.png',width: 50,height: 50,fit:BoxFit.fill,),
                        //),
                      //  new Container(
                      //    padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                      //    child: Image.asset('assets/images/buttuns/b3.png',fit:BoxFit.fill,),
                      //  ),
                     //   new Container(
                     //     padding:EdgeInsets.only(left: 0,top:0,right: 0,bottom: 0),
                     //     child: Image.asset('assets/images/buttuns/b5.png',fit:BoxFit.fill,),
                     //   ),
                      ],
                    ))),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              firstpage(),
              Member_Fix(data:widget.data),
              Member(data:widget.data),
              buildsing(data:widget.data),

              GestureDetector(onTap: (){print('test');},),
              // Text('123'),

            ],
          ),
        ),
      ),
    );
  }

}