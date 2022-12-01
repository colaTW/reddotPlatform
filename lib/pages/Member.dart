import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/drawboard.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:flutterapp/pages/CalenderClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/custom_drop_down.dart';
import 'package:flutterapp/pages/deal.dart';
import 'dart:convert';
import 'package:nice_button/nice_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pinch_zoom/pinch_zoom.dart';



class Member extends StatefulWidget {
  dynamic data;
  Member({this.data});

  @override
  State<StatefulWidget> createState() {
    return _Member();
  }
}

class _Member extends State<Member> {
  var isDisable=false;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  var type = 0;
  int pagecounter = 1;
  int totalpage1 = 1;
  int how;
  var Category=0;
  var ItemID;
  var Categories;
  var Itmes;
  var HandlerTypes;
  var items = <ItemInfo>[];
  List<Widget> itemsData = [];
  void initState() {
    pagecounter=1;
    this.getlist();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent-100 ) {
        _plus();
      }
    });
  }
  void getlist() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      print(ItemID);
      var re = json.decode(await APIs().getlist_member(widget.data['tk'], type,Category,ItemID, pagecounter));
      Categories=re['projectCategories'];
      Itmes=re['projectItems'];
      HandlerTypes=re['projectHandlerTypes'];
      for(int i=1;i<=Itmes.length;i++){
        Itmes[i.toString()]=Itmes[i.toString()];
      }
      var go = <ItemInfo>[];
      for (int i = 0;i < re['projectLists'].length; i++) {
        var goinfo = ItemInfo();
        goinfo.deal_no = re['projectLists'][i]['projectId'].toString();
        goinfo.deal_type = re['projectLists'][i]['projectItemName'] + re['projectLists'][i]['projectCategoryName'];
        goinfo.deal_newdate =re['projectLists'][i]['createdAt'];
        goinfo.deal_case = re['projectLists'][i]['repair']['constructionName'];
        goinfo.deal_phone = re['projectLists'][i]['repair']['mobile'];
        goinfo.deal_status =re['projectLists'][i]['handlerType'];
        goinfo.deal_name = re['projectLists'][i]['repair']['name'];
        goinfo.deal_messg =re['projectLists'][i]['repair']['message'];
        goinfo.deal_email = re['projectLists'][i]['repair']['email'];
        goinfo.deal_address = re['projectLists'][i]['repair']['address'];
        goinfo.Warranty=re['projectLists'][i]['overResidentWarranty'];
        goinfo.deal_img1 = ['', '', '', '', ''];
        goinfo.deal_hasmesg = re['projectLists'][i]['handlers'].length;
        //print('fileher');print(re['projectLists'][i]['files'].leng);
        if (re['projectLists'][i]['handlers'].length > 0) {
          goinfo.deal_onsite = re['projectLists'][i]['handlers'][0]['onSite'];
          goinfo.deal_price = re['projectLists'][i]['handlers'][0]['price'];
          goinfo.deal_siteat = re['projectLists'][i]['handlers'][0]['onSiteAt'];
          goinfo.deal_username =re['projectLists'][i]['handlers'][0]['userName'];
          goinfo.deal_handlerID =re['projectLists'][i]['handlers'][0]['handlerId'].toString();
          goinfo.deal_agree = re['projectLists'][i]['handlers'][0]['clientAgree'];
          goinfo.handler_mesg = re['projectLists'][i]['handlers'][0]['message'];
          if (re['projectLists'][i]['handlers'][0]['files'].length > 0) {
            goinfo.filename =re['projectLists'][i]['handlers'][0]['files'][0]['name'].toString();
            goinfo.file_url = re['projectLists'][i]['handlers'][0]['files'][0]['url'].toString();
          }
          for (int j = 0; j <re['projectLists'][i]['handlers'][0]['images'].length; j++) {
            goinfo.deal_img1[j] = re['projectLists'][i]['handlers'][0]['images'][j]['url'];
          }
        }
        //print(re['projectLists'][i]['handlers'].length);
        totalpage1 = re['totalPages'];

        go.add(goinfo);
      }
      getPostsData(go);
    }
  }
  void getPostsData(var list) {
    print(list);
    List<Widget> listItems = [];
    Color cardcolor;
    cardcolor=Colors.white;

    for (int i = 0; i < list.length; i++) {
      /*偵測卡片過期變色
      if(list[i].Warranty==true){
        cardcolor=Color(0xFFDBADD2);
      }
      else{
        cardcolor=Colors.white;
      }*/
      listItems.add(Container(
          margin: const EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: cardcolor,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    list[i].deal_name==null?Text(""):  Text(
                      list[i].deal_name,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    SizedBox(height: 15,),
                    Text(''),
                    list[i].deal_type==null?Text(""):   Text(
                      list[i].deal_type,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    list[i].deal_case==null?Text(""):  Text(
                      list[i].deal_case,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    list[i].deal_phone==null?Text(""):  Text(
                      list[i].deal_phone,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    list[i].Warranty==false?Text(""):Text(
                      "***過保***",
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                    Text(''),
                    list[i].deal_status==null?Text(""):  Text(
                      list[i].deal_status,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    list[i].deal_newdate==null?Text(""):   Text(
                      list[i].deal_newdate,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(""),
                    Container(
                        child: ElevatedButton(
                      child: Text('查看明細'),
                      onPressed: () async{
                        showMyMaterialDialog(context, list[i], widget.data['tk'],);
                      },
                    )),
                  ],
                ),
              ],
            ),
          )));
    }
    ;
    print(listItems);
    if(mounted) {
      setState(() {
        itemsData+= listItems;
      });
    }
  }
  Future<String>  getDate()async{
    getlist();
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
          color:Color(0xFF2A3233),
          child:
          Column(
            children: [
              SizedBox(
                height: 10,                
              ),
         
         RefreshIndicator(
           onRefresh: (){
             itemsData=[];
             pagecounter=1;
             return getDate();} ,
           child:
               SingleChildScrollView(
                   physics: AlwaysScrollableScrollPhysics(),
                   child:
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(100),
                            blurRadius: 10.0),
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
                                      'assets/images/memberlogin/listlogo.png')))
                        ],
                      ),
                      Row(
                        children: <Widget>[
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
                                    child: Center(child: new Text(item['name'])),
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
                          Padding(
                              padding: EdgeInsets.only(
                                right: 28.0,
                              ),
                              child: new ElevatedButton(
                                  child: Text("搜尋"),
                                  onPressed: isDisable?null:() async {
                                    setState(() {
                                      isDisable=true;
                                    });
                                    pagecounter=1;
                                    itemsData=[];
                                   await getlist();
                                   if(mounted){
                                     setState(() {
                                       isDisable=false;
                                     });
                                   }
                                  })),
                        ],
                      ),
                    ],
                  )))),
              SizedBox(height: 10,),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: (){
                    itemsData=[];
                    pagecounter=1;
                    return getDate();} ,
                  child:
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
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      }))),
              ),
              /*Row(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: _minus,
                    child: new Icon(Icons.arrow_back_ios),
                  ),
                  Text(pagecounter.toString() + "/" + totalpage1.toString()),
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
      if (notification.metrics.extentAfter == 0.0) {
        _plus();
        return true;

      }

    }
  }
  _minus() async {
    if (pagecounter == 1) {
    } else {
      setState(() {
        pagecounter--;
        print('this');
        print(pagecounter);
      });
     getlist();
    }
  }

  _plus() async {
    if (pagecounter == totalpage1) {
    } else {
      setState(() {
        pagecounter++;print('that');
        print(pagecounter);
      });
      getlist();
    }
  }
  void showMyMaterialDialog(BuildContext context, var show, var tk,) {
    print(show.deal_img1[0]);
    print(show.deal_img1[1]);
    print(show.deal_img1[2]);
    print(show.deal_agree);
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
                Text("報修回覆"),
                SizedBox(height: 5,),
                Container(width: double.infinity,child:
                DecoratedBox(
                  decoration:BoxDecoration(
                      border:Border.all(color: Colors.grey,width: 1.0)
                  ),
                )),
              ],),
            content:
            show.deal_hasmesg == 0
                ? Text('尚未回覆')
                :
            Container(
                height: height*0.5,
                child:SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    show.deal_onsite==null?Text(''):  show.deal_onsite == '是'
                        ? Text('現場勘驗:\n'+show.deal_siteat,style:TextStyle(height: 1.5))
                        : Text('現場勘驗:\n聯繫後無需現場勘驗',style:TextStyle(height: 1.5)),
                    SizedBox(height: 15,),
                    show.deal_username==null?Text(''): new Text('處理人員:\n' + show.deal_username,style:TextStyle(height: 1.5)),
                    SizedBox(height: 15,),
                    show.handler_mesg==null?Text(''):  new Text(
                      '維修說明:\n' + show.handler_mesg,
                    ),
                    SizedBox(height: 15,),
                    new Text('回覆照片:'),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        show.deal_img1[0]==''?Text(''): Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[0]),)
                          ,onTap: (){
                            showImageDialog(context, show.deal_img1[0]);

                          },)),
                        SizedBox(width: 5,),
                        show.deal_img1[1]==''?Text(''):Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[1]),)
                          ,onTap: (){
                            showImageDialog(context, show.deal_img1[1]);

                          },)),
                        SizedBox(width: 5,),
                        show.deal_img1[2]==''?Text(''):Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[2]),)
                          ,onTap: (){
                            showImageDialog(context, show.deal_img1[2]);

                          },)),


                      ],),
                    SizedBox(height: 15,),
                    new Text('回覆檔案:'),
                    show.filename==null?Text(''):
                    GestureDetector(onTap: (){
                      launch(show.file_url);
                    },child: Text(''+show.filename,style:TextStyle(height: 1.5,color: Colors.blue))),
                    SizedBox(height:15),
                    show.deal_status=='案件結案'||show.deal_status=='業外處理'?Text(''): show.deal_agree == '否' ? Text('同意修繕:\n待確認',style:TextStyle(height: 1.5)) : Text('同意修繕:\n同意',style:TextStyle(height: 1.5)),


                  ],
                )))
            // new Text('案場照片:'),
            //new Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //    children: <Widget>[
            //   show.deal_img1[0]==''?Text(''): Expanded(child:new Image(image: NetworkImage(show.deal_img1[0]),)),
            //   show.deal_img1[1]==''?Text('no'): Expanded(child:new Image(image: NetworkImage(show.deal_img1[1]),)),
            //    show.deal_img1[2]==''?Text('no'): Expanded(child:new Image(image: NetworkImage(show.deal_img1[2]),)),
            //   ],),
            ,
            actions: <Widget>[

              show.deal_hasmesg== 0
                  ? new TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text("確認"),
              )
                  : show.deal_status=='案件結案'|| show.deal_status=='業外處理'?TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text("確認"),
              ):show.deal_agree=='否'? new TextButton(
                onPressed: () async{
                  print(show.deal_handlerID);
                  String resultData =  await  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              drawboard(data: [tk, show.deal_handlerID])));
                  if(resultData!=null){
                    print('ok');
                    itemsData=[];
                    pagecounter=1;
                    getDate();
                    Navigator.pop(context);
                  }
                },
                child: new Text("電子簽名同意修繕"),
              ):new TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text("確認"),
              ),
            ],
          );
        });
  }
}

List<CustomDropdownMenuItem> typeList() {
  List<CustomDropdownMenuItem> items = new List();
  CustomDropdownMenuItem item1 =
      new CustomDropdownMenuItem(value: '0', child: new Text('所有'));
  CustomDropdownMenuItem item2 =
      new CustomDropdownMenuItem(value: '1', child: new Text('未處理'));
  CustomDropdownMenuItem item3 =
      new CustomDropdownMenuItem(value: '2', child: new Text('處理中'));
  CustomDropdownMenuItem item4 =
      new CustomDropdownMenuItem(value: '3', child: new Text('案件結案'));
  CustomDropdownMenuItem item5 =
      new CustomDropdownMenuItem(value: '4', child: new Text('業外處理'));
  
  items.add(item1);
  items.add(item2);
  items.add(item3);
  items.add(item4);
  items.add(item5);
  

  return items;
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
  var deal_img1;
  String deal_onsite;
  String deal_siteat;
  String deal_username;
  int deal_hasmesg;
  String deal_handlerID;
  String deal_agree;
  String handler_mesg;
  var filename;
  var file_url;
  int deal_price;
  var Warranty;

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
    this.deal_onsite,
    this.deal_siteat,
    this.deal_username,
    this.deal_hasmesg,
    this.deal_handlerID,
    this.deal_agree,
    this.handler_mesg,
    this.deal_case,
    this.deal_info,
    this.deal_newdate,
    this.deal_type,
    this.filename,
    this.file_url,
    this.deal_price,
    this.Warranty,
  });
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


