import 'package:flutter/material.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:flutterapp/pages/Fix.dart';
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class buildsing extends StatefulWidget {
  dynamic data;
  buildsing({this.data});
  List buildlist=List();


  @override
  State<StatefulWidget> createState() {

    return _buildsing();
  }
}

class _buildsing extends State<buildsing> {

  void initState() {
    getbuild();  }

getbuild() async{
  var get =
  await APIs().bulidlist(); //getData()延遲執行後賦值給data
  var info = json.decode(get);
 widget.buildlist=info['data'];
 print(widget.buildlist);

}
  DateTime warranty1 = DateTime.now();
  DateTime warranty2 = DateTime.now();
  var buildID1;
  var buildID2;
  bool visible1=false;
  TextEditingController building1 = TextEditingController();
  TextEditingController household1 = TextEditingController();
  TextEditingController floor1 = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController building2 = TextEditingController();
  TextEditingController household2 = TextEditingController();
  TextEditingController floor2 = TextEditingController();
  TextEditingController address2 = TextEditingController();




  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Scaffold(

        body:
        GestureDetector(
          onTap: (){FocusScope.of(context).requestFocus(FocusNode());
          },
          child:SingleChildScrollView(
              child:
              Container(
                height: height+height/2,

                //  margin:  EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: Color(0xFF2A3233),
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/buildsign/p1.png'),
                    SizedBox(height: 20,),
                    Row(children: [
                      Image.asset('assets/images/buildsign/p2.png',height:20,width:100,),
                      Expanded(child:
                      new Container(color:Colors.white,
                        child:new DropdownButtonHideUnderline(child:
                        new DropdownButton(
                          isExpanded: true,
                          hint: new Center(child:new Text('－－請選擇建案－－',textAlign: TextAlign.center,)),
                          items: widget.buildlist.map((item) {
                            return new DropdownMenuItem(
                              child: Center(child:new Text(item['name'],textAlign: TextAlign.center,
                              )),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (selectvalue) {
                            setState(() {
                              buildID1 = selectvalue;
                            });
                          },
                          value: buildID1,
                        )),))
                    ],),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Image.asset('assets/images/buildsign/p3.png',height:20,width:100,),
                        Expanded(
                          child: TextFormField(
                            controller: building1,
                            decoration: const InputDecoration(
                              hintText: "棟別",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: household1,
                            decoration: const InputDecoration(
                              hintText: "戶別",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: floor1,
                            decoration: const InputDecoration(
                              hintText: "樓層",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,)
                      ],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Image.asset('assets/images/buildsign/space.png',height:20,width:100,),
                        Expanded(child:
                        TextFormField(
                            controller: address1,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "填入地址",
                            ),
                          )),

                        SizedBox(width: 10,),
                      ],
                    ),

                    SizedBox(height: 20,),

                    Visibility(
                      visible: visible1,
                      child: Container(
                        //  margin:  EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFF2A3233),
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/images/buildsign/p1.png'),
                            SizedBox(height: 20,),
                            Row(children: [
                              Image.asset('assets/images/buildsign/p2.png',height:20,width:100,),
                              Expanded(child:
                              new Container(color:Colors.white,
                                child:new DropdownButtonHideUnderline(child:
                                new DropdownButton(
                                  isExpanded: true,
                                  hint: new Center(child:new Text('－－請選擇建案－－',textAlign: TextAlign.center,)),
                                  items: widget.buildlist.map((item) {
                                    return new DropdownMenuItem(
                                      child: Center(child:new Text(item['name'],textAlign: TextAlign.center,
                                      )),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (selectvalue) {
                                    setState(() {
                                      buildID2 = selectvalue;
                                    });
                                  },
                                  value: buildID2,
                                )),))
                            ],),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                Image.asset('assets/images/buildsign/p3.png',height:20,width:100,),
                                Expanded(
                                  child: TextFormField(
                                    controller: building2,
                                    decoration: const InputDecoration(
                                      hintText: "棟別",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: household2,
                                    decoration: const InputDecoration(
                                      hintText: "戶別",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: floor2,
                                    decoration: const InputDecoration(
                                      hintText: "樓層",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,)
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('assets/images/buildsign/space.png',height:20,width:100,),
                                Expanded(child:
                                TextFormField(
                                    controller: address2,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "填入地址",
                                    ),
                                  )),

                                SizedBox(width: 10,),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset('assets/images/buildsign/p4.png'),
                      onTap: (){
                        if(!visible1){
                          setState(() {
                            visible1=!visible1;
                            print(visible1);
                          });
                        }

                      },
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      child: Image.asset('assets/images/buildsign/p5.png'),
                      onTap: ()async{
                        var info = Map<String, dynamic>();
                        var residentDatas1= Map<String, dynamic>();
                        var residentDatas2= Map<String, dynamic>();
                        List list = new List();
                        if(buildID1!=null&&address1.text!=''&&building1!=''&&household1.text!=''&&floor1.text!=''&&warranty1!='')
                        {
                          residentDatas1['constructionId']=buildID1;
                          residentDatas1['address']=address1.text;
                          residentDatas1['building']=building1.text;
                          residentDatas1['household']=household1.text;
                          residentDatas1['floor']=floor1.text;
                          residentDatas1['warranty']='2021-01-01';
                          list.add(residentDatas1);
                          if(buildID2!=null){
                            print('有2');

                            if(address2.text!=''&&building2!=''&&household2.text!=''&&floor2.text!=''&&warranty2!='') {
                              residentDatas2['constructionId'] = buildID2;
                              residentDatas2['address'] = address2.text;
                              residentDatas2['building'] = building2.text;
                              residentDatas2['household'] = household2.text;
                              residentDatas2['floor'] = floor2.text;
                              residentDatas2['warranty'] = '2020-01-02';
                              list.add(residentDatas2);
                            }
                            else{
                              Alert(
                                  title:'提示',
                                  context: context,
                                  type: AlertType.warning,
                                  desc: "請選擇建案並填入資料",
                                  buttons: []
                              ).show();
                            }
                          }

                        }
                        else{

                          Alert(
                              title:'提示',
                              context: context,
                              type: AlertType.warning,
                              desc: "請選擇建案並填入資料",
                              buttons: []
                          ).show();
                          return;
                        }
                        info['residentDatas']=list;
                        var end = json.decode(await  APIs().singinbuild(widget.data['tk'], info));
                        if (end['data']['errors'] == "") {
                          setState(() {
                            buildID1=null;buildID2=null;
                            building1.text='';building2.text='';
                            household1.text='';household2.text='';
                            address1.text='';address2.text='';
                            floor1.text='';floor2.text='';
                          });
                          Alert(
                              title:'成功',
                              context: context,
                              type: AlertType.success,
                              buttons: []
                          ).show();
                        }

                      },
                    ),
                    SizedBox(height: 20,),
                    Image.asset('assets/images/buildsign/p6.png'),
                  ],
                ),
              ),

          ),
        ));
  }
}


