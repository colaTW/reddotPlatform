import 'package:flutter/material.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:flutterapp/pages/Fix.dart';
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Member_Fix extends StatefulWidget {
  dynamic data;
  Member_Fix({this.data});
  @override
  State<StatefulWidget> createState() {
    return _Member_Fix();
  }
}

class _Member_Fix extends State<Member_Fix> {
  String value = '3';
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  int pagecounter = 1;
  int totalpage1 = 1;
  var Itmes;
  var Category;
  void initState() {
    this.getlist();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 100) {
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
      var re = json.decode(await APIs().getlist_member(widget.data['tk'], '0', '0', 0,pagecounter));
      var go = <ItemInfo>[];
      totalpage1 = re['totalPages'];
      for (int i = 0; i < re['projectLists'].length; i++) {
        var goinfo = ItemInfo();
        goinfo.deal_no =re['projectLists'][i]['projectId'].toString();
        goinfo.deal_type = re['projectLists'][i]['projectItemName'] +re['projectLists'][i]['projectCategoryName'];
        goinfo.deal_newdate =re['projectLists'][i]['createdAt'];
        goinfo.deal_info =re['projectLists'][i]['client']['name'];
        goinfo.deal_case =re['projectLists'][i]['constructionName'];
        goinfo.deal_type_newdate = re['projectLists'][i]['projectItemName'] +re['projectLists'][i]['projectCategoryName'] +'\n' +re['projectLists'][i]['createdAt'];
        goinfo.deal_info_case = re['projectLists'][i]['client']['name'] +'\n' +re['projectLists'][i]['constructionName'];
        goinfo.deal_phone =re['projectLists'][i]['client']['mobile'];
        goinfo.deal_status =re['projectLists'][i]['handlerType'];
        goinfo.deal_name =re['projectLists'][i]['client']['name'];
        goinfo.deal_messg = re['projectLists'][i]['repair']['message'];
        goinfo.deal_email =re['projectLists'][i]['client']['email'];
        goinfo.deal_address = re['projectLists'][i]['repair']['address'];
        goinfo.building=re['projectLists'][i]['repair']['constructionName'];
        goinfo.buildinfo=re['projectLists'][i]['repair']['building'].toString()+'棟/'+re['projectLists'][i]['repair']['household'].toString()+'戶/'+re['projectLists'][i]['repair']['floor'].toString()+'樓';
        goinfo.deal_img1 = ['', '', '', '', ''];
        for (int j = 0; j < re['projectLists'][i]['images'].length; j++) {
          goinfo.deal_img1[j] = re['projectLists'][i]['images'][j]['url'];
        }
        for (int j = 0; j < re['projectLists'][i]['files'].length; j++) {
          goinfo.filename = re['projectLists'][i]['files'][j]['name'];
          goinfo.fileurl = re['projectLists'][i]['files'][j]['url'];
        }
        go.add(goinfo);
      }
      getPostsData(go);
    }
  }

  void getPostsData(var list) {
    print(list);
    List<Widget> listItems = [];
    for (int i = 0; i < list.length; i++) {
      listItems.add(
          GestureDetector(
            onTap: (){showMyMaterialDialog(context, list[i]);},
              child:
          Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color(0xFFA4A49D),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    list[i].deal_type==null?Text(""):Text(
                      list[i].deal_type,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    list[i].deal_status==null?Text(""): Text(
                      list[i].deal_status + '\n' + list[i].deal_newdate,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ))));
    }
    ;
    print(listItems);
    if(mounted) {
      setState(() {
        itemsData+= listItems;
      });
    }
  }

  Future<String> getCountryData() async {
    getlist();
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;
    return MaterialApp(
      color: Color(0xFF2A3233),
      title: "resr",
      home: Scaffold(
    bottomNavigationBar: BottomAppBar(
    child:Image.asset(
      'assets/images/mainten_create/fixbom.png',
      fit: BoxFit.fill,
    ),),
          body: Container(
            color: Color(0xFF2A3233),
            child:
            RefreshIndicator(
                onRefresh: () {
                  itemsData=[];
                  pagecounter=1;
                  return getCountryData();
                },
                child: SingleChildScrollView(
                    controller: controller,
                    child:
                Container(
                    height: height + 1, child:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                        'assets/images/mainten_create/fixlogo.png'),
                    new GestureDetector(
                        child: Image.asset(
                            'assets/images/mainten_create/fixbutton.png'),
                        onTap: () async {

                          var re = json.decode(await APIs().getlist_member(widget.data['tk'], '0', '0',0, 0));
                          var Categories=re['projectCategories'];
                          var Items=re['projectItems'];
                          print('here'+widget.data.toString());

                          re=json.decode(await APIs().getbuild_member(widget.data['tk'],widget.data['info']["user_id"]));
                          var residents=re['data'];
                          print("test"+residents.length.toString());
                          if(residents.length==0){
                            Alert(
                                title: '提醒',
                                context: context,
                                type: AlertType.warning,
                                desc: "請先至建案登錄功能登錄您所屬的建案",
                              buttons: []

                            ).show();

                          }
                          else{
                            String resultData =  await  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Fix(data: {
                                          'info': widget.data['info'],
                                          'tk': widget.data['tk'],
                                          'Categories':Categories,
                                          'Items':Items,
                                          'residents':residents,
                                        })));
                            if(resultData!=null) {
                              print(resultData);
                              itemsData=[];
                              pagecounter=1;
                              getlist();
                            }
                          }

                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                        }),
                    Flexible(child:
                    Container(
                        height: 300,
                        child:new NotificationListener(
                            onNotification: dataNotification,
                            child:
                        ListView.builder(
                            itemCount: itemsData.length,
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
                                  transform: Matrix4.identity()
                                    ..scale(scale, scale),
                                  alignment: Alignment.bottomCenter,
                                  child: Align(
                                      heightFactor: 0.7,
                                      alignment: Alignment.topCenter,
                                      child: itemsData[index]),
                                ),
                              );
                            })))),
                  /*  Row(
                      children: <Widget>[
                        new RaisedButton(
                          onPressed: _minus,
                          child: new Icon(Icons.arrow_back_ios),
                        ),
                        Text(pagecounter.toString() + "/" +
                            totalpage1.toString()),
                        new RaisedButton(
                          onPressed: _plus,
                          child: new Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),*/

                  ],
                )))),
          )),
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
    if (pagecounter == 1) {}
    else {
      setState(() {
        pagecounter--;
        getlist();
      });
    }
  }

  _plus() async {
    if (pagecounter == totalpage1) {}
    else {
      setState(() {
        pagecounter++;
        getlist();
      });
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
  var deal_img1;
  String deal_onsite;
  String deal_siteat;
  String deal_username;
  int deal_hasmesg;
  String deal_handlerID;
  String deal_agree;
  String handler_mesg;
  String buildinfo;
  String building;
  String filename;
  String fileurl;

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
    this.buildinfo,
    this.building,
    this.filename,
    this.fileurl,
  });
}
void showMyMaterialDialog(BuildContext context,var show) {
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;
  print(show);
  showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("報修紀錄"),
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
              new Text('建案門牌:\n'+show.building+"/"+show.buildinfo,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),
              /*new Text('地址:\n'+show.deal_address,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),*/
              show.deal_messg==null?Text(""):new Text('報修說明:\n'+show.deal_messg,style:TextStyle(height: 1.5)),
              SizedBox(height: 15,),
              new Text('上傳照片:'),
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
                  show.deal_img1[4]==''?Text(''): Expanded(child:GestureDetector(child:new Image(image: NetworkImage(show.deal_img1[4]),)
                    ,onTap: (){
                      showImageDialog(context, show.deal_img1[4]);

                    },)),
                ],),
              SizedBox(height: 15,),
              new Text('上傳檔案:'),
              show.filename==null?Text(''): GestureDetector(onTap:(){
                launch(show.fileurl);
              },child: Text(show.filename,style:TextStyle(height: 1.5,color: Colors.blue))),


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

