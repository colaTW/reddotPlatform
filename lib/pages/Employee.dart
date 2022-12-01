import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:flutterapp/pages/CalenderClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/pages/deal.dart';
import 'package:flutterapp/pages/Home.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterapp/custom_drop_down.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/message.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutterapp/pages/demo_Fix.dart';



class Employee extends StatefulWidget {
  dynamic data;
  Employee({this.data});


  @override
  State<StatefulWidget> createState() {
    return _Employee();
  }
}
class _Employee extends State<Employee>{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final url = "https://liff.line.me/1656005426-ZdRn10xN?page=check";
  String notify_token="";
  var isDisable=false;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  var type = 0;
  var Category = 0;
  var ItemID;
  var Categories;
  var HandlerTypes;
  var Itmes;
  int pagecounter=1;
  int totalpage1=1;
  int minspage=1;
  int pluspage=1;
  int how;
  var items = <ItemInfo>[];
  List<Widget> itemsData = [];
  void initState() {
    this.getlist(0);
    _firebaseMessaging.subscribeToTopic('fix');

  }
  void getlist(int mins) async {

    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var re = json.decode(await APIs().getlist_employee(widget.data['tk'], type, Category,ItemID,pagecounter));
      Categories=re['projectCategories'];
      Itmes=re['projectItems'];
      HandlerTypes=re['projectHandlerTypes'];
      for(int i=1;i<=Itmes.length;i++){
        Itmes[i.toString()]=Itmes[i.toString()];
      }
      var go = <ItemInfo>[];
      for (int i = 0; i < re['projectLists'].length; i++) {
        print( re['projectLists'][i]['createdAt']);
        var goinfo = ItemInfo();
        goinfo.deal_no = re['projectLists'][i]['projectId'].toString();
        goinfo.deal_type = re['projectLists'][i]['projectItemName'] +
            re['projectLists'][i]['projectCategoryName'];
        goinfo.deal_newdate = re['projectLists'][i]['createdAt'];
        goinfo.deal_info = re['projectLists'][i]['repair']['name'];
        goinfo.deal_case = re['projectLists'][i]['repair']['constructionName'];
        goinfo.deal_type_newdate = re['projectLists'][i]['projectItemName'] +
            re['projectLists'][i]['projectCategoryName'] + '\n' +
            re['projectLists'][i]['createdAt'];
        goinfo.deal_info_case = re['projectLists'][i]['client']['name'] + '\n' +
            re['projectLists'][i]['constructionName'];
        goinfo.deal_phone = re['projectLists'][i]['repair']['mobile'];
        goinfo.deal_status = re['projectLists'][i]['handlerType'];
        goinfo.deal_name = re['projectLists'][i]['repair']['name'];
        goinfo.deal_messg = re['projectLists'][i]['repair']['message'];
        goinfo.deal_email = re['projectLists'][i]['repair']['email'];
        goinfo.deal_address = re['projectLists'][i]['repair']['address'];
        goinfo.building=re['projectLists'][i]['repair']['constructionName'];
        goinfo.buildinfo=re['projectLists'][i]['repair']['building'].toString()+'棟'+re['projectLists'][i]['repair']['household'].toString()+'戶'+re['projectLists'][i]['repair']['floor'].toString()+'樓';
        goinfo.Warranty=re['projectLists'][i]['overResidentWarranty'];
        goinfo.page=re['currentPage'];
        goinfo.deal_img1 = ['', '', '', '', ''];
        totalpage1 = re['totalPages'];
        if (re['projectLists'][i]['handlers'].length > 0) {
          goinfo.deal_onsite = re['projectLists'][i]['handlers'][0]['onSite'];
          goinfo.deal_onsiteat = re['projectLists'][i]['handlers'][0]['onSiteAt'];
          goinfo.handler_message=re['projectLists'][i]['handlers'][0]['message'];
        }
        for (int j = 0; j < re['projectLists'][i]['images'].length; j++) {
          goinfo.deal_img1[j] = re['projectLists'][i]['images'][j]['url'];
        }
        goinfo.memos=re['projectLists'][i]['memos'];
        go.add(goinfo);
      }
      items = go;
      getPostsData(items,mins);
    }
  }
  void getPostsData(var list,int mins) {
    List<Widget> listItems = [];
    for(int i=0;i<list.length;i++) {
      String show='';
      if(list[i].deal_status=='案件結案'){show=list[i].deal_status;}
      else if(list[i].deal_status=='業外處理'){show=list[i].deal_status;}
      else if(list[i].deal_status=='會員自行處理'){show=list[i].deal_status;}
      Color cardcolor;
      cardcolor=Colors.white;
      /*偵測保固過期卡片變色
      if(list[i].Warranty==true){
        cardcolor=Color(0xFFDBADD2);
      }
      else{
        cardcolor=Colors.white;
      }*/

      listItems.add(Container(
          margin: const EdgeInsets.only(bottom:60 ),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: cardcolor, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    list[i].deal_name==null?Text(""): Text(
                      list[i].deal_name+'\n ',
                      style: const TextStyle(fontSize: 12, color: Colors.black),

                    ),
                    Text(''),
                    list[i].deal_type==null?Text(""): Text(
                      list[i].deal_type,
                      style: const TextStyle(fontSize: 12, color: Colors.black),

                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    list[i].deal_case==null?Text(""):Text(
                      list[i].deal_case,
                      style: const TextStyle(fontSize: 12, color: Colors.black),

                    ),
                    list[i].deal_phone==null?Text(""):Text(
                      list[i].deal_phone,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    list[i].Warranty==false?Text(""):Text(
                      "***過保***",
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                    Text(''),
                    list[i].deal_status==null?Text(""):Text(
                      list[i].deal_status,
                      style: const TextStyle(fontSize: 12, color: Colors.black),

                    ),

                    list[i].deal_newdate==null?Text(""): Text(
                      list[i].deal_newdate,
                      style: const TextStyle(fontSize: 12, color: Colors.black),

                    ),
                  ],),
                Column(children: [
                  ElevatedButton(child: Text('詳細資料'),onPressed:() {
                    showMyMaterialDialog(context, list[i]);
                    },),
                  list[i].deal_status=='案件結案'||list[i].deal_status=='業外處理'||list[i].deal_status=='會員自行處理'?
                      ElevatedButton(child:Text(show))
                      :ElevatedButton(child: Text('新增處理'),onPressed:() async{
                    String resultData =  await Navigator.push(context,
                        MaterialPageRoute(builder:(BuildContext context) {
                          return deal(data:{'NO':list[i].deal_no,'tk':widget.data['tk'],'ID':widget.data['ID']}) ;
                        })
                    );
                    if(resultData!=null){
                      print('ok');
                      minspage=int.parse(list[i].page);
                      pluspage=int.parse(list[i].page);
                      pagecounter=int.parse(list[i].page);
                      itemsData=[];
                      getlist(0);
                    }
                    },
                  ),
                  list[i].deal_status=='案件結案'||list[i].deal_status=='業外處理'||list[i].deal_status=='會員自行處理'?ElevatedButton(child: Text('行事曆'),): ElevatedButton(child: Text('行事曆'),onPressed:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(data:list[i].deal_onsiteat)));
                    },),
                ],)
              ],
            ),
          )));
    };
      if(mins==0){
        setState(() {
          itemsData+= listItems;
        });
      }
      else{
        setState(() {
          itemsData= listItems+itemsData;
        });
      }

  }
  Future<String> getDate() async{
    getlist(0);
    return 'success';
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
      return MaterialApp(
        title: "resr",
        home: Scaffold(
          body:
          Container(
            height: height+1,
              color: Color(0xFF2A3233),
              child:Column(
            children: [
              SizedBox(height: 10,),
    SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
    child:
              Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
        ]),
        child:
              Column(
                children: [

                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                              padding:
                              EdgeInsets.fromLTRB(20.0, 10, 28.0, 0),
                              child: Image.asset(
                                  'assets/images/memberlogin/listlogo.png'))),

                    ],
                  ),

                  Row(children: <Widget>[
                    HandlerTypes!=null? new Expanded(
                        child: new CustomDropdownButton<dynamic>(
                          isExpanded: true,
                          hint:Center(child: Text('請選擇分類',textAlign: TextAlign.center)),
                          items: HandlerTypes.map<CustomDropdownMenuItem<dynamic>>((item) {
                            return new CustomDropdownMenuItem<dynamic>(
                              child: Center(child:new Text(item['name'])),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (selectvalue) {
                            print(selectvalue);
                            setState(() {
                              type=selectvalue;
                            });
                          },
                          value: type,
                        )):Text(''),
                    Categories!=null?  new Expanded(
                        child: new CustomDropdownButton<dynamic>(
                          isExpanded: true,
                          hint:Center(child: Text('請選擇分類',textAlign: TextAlign.center)),
                          items: Categories.map<CustomDropdownMenuItem<dynamic>>((item) {
                            return new CustomDropdownMenuItem<dynamic>(
                              child: Center(child:new Text(item['name'])),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (selectvalue) {
                            print(selectvalue);
                            setState(() {
                              Category=selectvalue;
                              ItemID=null;

                            });
                          },
                          value: Category,
                        )):Text(''),
                    Category!=0?  new Expanded(
                        child: new CustomDropdownButton<dynamic>(
                          isExpanded: true,
                          hint:Center(child: Text('請選擇項目',textAlign: TextAlign.center)),
                          items: Itmes[Category.toString()].map<CustomDropdownMenuItem<dynamic>>((item) {
                            return new CustomDropdownMenuItem<dynamic>(
                              child: Center(child:new Text(item['name'])),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (selectvalue) {
                            print(selectvalue);
                            setState(() {
                              ItemID=selectvalue;
                            });
                          },
                          value: ItemID,
                        )):Text(''),
                          Padding(padding:EdgeInsets.only(right:37.0,) ,child:new ElevatedButton(child: Text("搜尋"),
                            onPressed:isDisable?null:
                            () async{
                            setState(() {
                              isDisable=true;
                            });
                            pagecounter=1;
                            minspage=1;
                            pluspage=1;
                            itemsData=[];
                            await getlist(0);
                            if(mounted){
                              setState(() {
                                isDisable=false;
                              });
                            }
                          })),
                        ],
                      ),
                ],
              ))),
              SizedBox(height: 10,),
              new GestureDetector(
                  child: Image.asset(
                      'assets/images/mainten_create/fixbutton.png'),
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                demo_Fix(data: {
                                  'info': widget.data['info'],
                                  'tk': widget.data['tk'],
                                  'Categories':Categories,
                                  'Items':Itmes,
                                })));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                  }),
              Expanded(child:

                      new NotificationListener(
                          onNotification: dataNotification,
                          child:
                   ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                       physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      }))),
            /*  Row(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: _minus,
                    child: new Icon(Icons.arrow_back_ios),
                  ),
                    Text(pagecounter.toString()+"/"+totalpage1.toString()),
                    new RaisedButton(
                    onPressed: _plus,
                    child: new Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )*/
            ],
          ),
          ),

        ),
      );

  }
  bool dataNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      //下滑到最底部
      if (notification.metrics.extentAfter == .0) {
        _plus();
        return true;
      }
      if(notification.metrics.extentBefore==0.0){
        _minus();
            return true;
      }

    }
  }
  _minus() async{
    print('mins');
    print(pagecounter);
    print(minspage);
    if(pagecounter==1){}
    else if(pagecounter>minspage){
      setState(() {
        pagecounter=minspage;
      });}
    else {
      setState(() {
        pagecounter--;
        minspage--;
      });
      getlist(1);
    }
  }
  _plus() async{
    print(pagecounter);

    if(pagecounter==totalpage1){}
    else if(pagecounter<pluspage){
      setState(() {
        pagecounter=pluspage;
      });}

    else {
      setState(() {
        pagecounter++;
        pluspage++;
      });
      print(pagecounter);
     await getlist(0);
    }
  }
}
class ItemInfo {
  String deal_no;
  String deal_type;
  String deal_newdate;
  String deal_type_newdate;
  String deal_info;
  String deal_case;
  String deal_info_case;
  String deal_phone;
  String deal_status;
  String deal_name;
  String deal_address;
  String deal_email;
  String deal_messg;
  String deal_onsite;
  String deal_onsiteat;
  String building;
  String buildinfo;
  var page;
  var deal_img1;
  var Warranty;
  String memos;
  String handler_message;

  ItemInfo({
    this.deal_no,
    this.deal_type_newdate,
    this.deal_info_case,
    this.deal_phone,
    this.deal_status,
    this.deal_name,
    this.deal_address,
    this.deal_email,
    this.deal_messg,
    this.deal_img1,
    this.deal_case,
    this.deal_info,
    this.deal_newdate,
    this.deal_type,
    this.deal_onsite,
    this.deal_onsiteat,
    this.building,
    this.buildinfo,
    this.Warranty,
    this.page,
    this.memos,
    this.handler_message,

  });
}

void showMyMaterialDialog(BuildContext context,var show) {
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;
  showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("住戶資料"),
            SizedBox(height: 5,),
            Container(width: double.infinity,child:
            DecoratedBox(
              decoration:BoxDecoration(
                  border:Border.all(color: Colors.grey,width: 1.0)
              ),
            )),
          ],),
          content:
                  Container(height: height*0.5,child:
                  SingleChildScrollView(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              show.deal_name==null?Text(""):new Text('姓名:\n'+show.deal_name,style:TextStyle(height: 1.5)),
            SizedBox(height: 15,),
              new Text("電話:\n"),
              show.deal_phone==null?Text(""): new GestureDetector( onTap: (){
                _call(show.deal_phone);
              },child:new Text(show.deal_phone,style:TextStyle(height: 1.5,color: Colors.blue))),
              SizedBox(height: 15,),
              show.building==null?Text(""): new Text('所屬建案:\n'+show.building,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),
              show.buildinfo==null?Text(""): new Text('建案門牌:\n'+show.buildinfo,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),
              /*new Text('地址:\n'+show.deal_address,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),*/
              show.deal_email==null?Text(""):new Text('Email:\n'+show.deal_email,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),
              show.deal_messg==null?Text(""):new Text('報修說明:\n'+show.deal_messg,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),
              new Text('案場照片:'),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              show.deal_img1[0]==''?Text(''): Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[0]),)
                ,onTap: (){
                showImageDialog(context, show.deal_img1[0]);

              },)),
                SizedBox(width: 5,),
                show.deal_img1[1]==''?Text(''): Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[1]),)
                  ,onTap: (){
                    showImageDialog(context, show.deal_img1[1]);
                  },)),
                SizedBox(width: 5,),
                show.deal_img1[2]==''?Text(''):Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[2]),)
                  ,onTap: (){
                    showImageDialog(context, show.deal_img1[2]);
                  },)),
                SizedBox(width: 5,),
                show.deal_img1[3]==''?Text(''): Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[3]),)
                  ,onTap: (){
                    showImageDialog(context, show.deal_img1[3]);
                  },)),
                SizedBox(width: 5,),
                show.deal_img1[4]==''?Text(''):Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[4]),)
                  ,onTap: (){
                    showImageDialog(context, show.deal_img1[4]);
                  },)),
              ],),
              show.memos==null?Text('保固備註:\n'):new Text('保固備註:\n'+show.memos),
              SizedBox(height: 15,),
              show.deal_onsite==null?Text(''): show.deal_onsite=="是"?new Text('預計場刊日期:\n'+show.deal_onsiteat):Text(""),
              SizedBox(height: 15,),
              show.handler_message==null?Text(''): new Text('處理狀況:\n'+show.handler_message)


              //new Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //  children: <Widget>[
             //    show.deal_img1[3]==''?Text(''): Expanded(child:new Image(image: NetworkImage(show.deal_img1[3]),)),
              //    show.deal_img1[4]==''?Text(''): Expanded(child:new Image(image: NetworkImage(show.deal_img1[4]),)),
              //  ],),
          ],))),
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text("確認"),
            ),

          ],
        );
      });
}
_call(String tel) async {
   var url = 'tel:'+tel;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
void showImageDialog(BuildContext context,var imgurl) {
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;
  showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          content: Container(
            width: width,
            height:height ,
            child:
          PinchZoom(
            image: Image.network(imgurl),
            zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 3.5,
             ),
          ),
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text("確認"),
            ),

          ],
        );
      });
}


