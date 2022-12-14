import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/fourpage.dart';
import 'package:flutterapp/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterapp/APIs.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';



class Fix extends StatefulWidget {
  dynamic data;
  Fix({this.data});
  @override
  State<StatefulWidget> createState() {
    return _fix();
  }
}
class _fix extends State<Fix> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cases = TextEditingController();
  TextEditingController num = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController household = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController fix = TextEditingController();
  TextEditingController memos = TextEditingController();
  TextEditingController email = TextEditingController();
  ScrollController control=ScrollController();
  var img1Path,img2Path,img3Path,img4Path,img5Path;
  var Category;
  var img1id,img2id,img3id,img4id,img5id;
  var buildID;
  var _filepath;
  var file1_id;
  var buildInfo;
  var Itmes;
  var residentID;
  String camera='assets/images/mainten_create/cream.png';
  String upfile='assets/images/mainten_create/flieupload.png';
  String over='assets/images/mainten_create/bar1.png';

  List buliddate=List();
  @override
  void initState() {
    super.initState();
    print(widget.data['residents']);
    buliddate=widget.data['residents'];
    name.text=widget.data['info']['name'];
    phone.text=widget.data['info']['mobile'];
    email.text=widget.data['info']['email'];
    num.text=widget.data['info']['address'];
  }

  @override
  Widget build(BuildContext context) {

    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("????????????"),
        backgroundColor: Color(0xA0979F97),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
          Navigator.pop(context);
        }),
      ),
      body:
    GestureDetector(
    onTap: (){FocusScope.of(context).requestFocus(FocusNode());
    },
    child:SingleChildScrollView(
          child:
          Container(
            //  margin:  EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Color(0xA0979F97),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/name.png',height:20,width:100,),
                    Expanded(
                      child: TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                        ),
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/phone.png',height:20,width:100,),
                    Expanded(
                      child: TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(

                        ),
                      ),
                    ),
                    SizedBox(width: 10,)

                  ],
                ),
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/email.png',height:20,width:100,),
                    Expanded(
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                        ),
                      ),
                    ),
                    SizedBox(width: 10,)

                  ],
                ),
                SizedBox(width: 10,height: 10,),
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/case.png',height:20,width:100,),
                    Expanded(child:
                    new Container(color:Colors.white,
                      child:new DropdownButtonHideUnderline(child:
                    new DropdownButton(
                      isExpanded: true,
                      hint:Center(child: Text('???????????????????????????',textAlign: TextAlign.center)),
                      items: buliddate.map((item) {
                        if(item['building']==null)item['building']="";
                        if(item['household']==null)item['household']="";
                        if(item['floor']==null)item['floor']="";

                        return new DropdownMenuItem(
                          child: Center(child:new Text(item['construction']['name'].toString()+'-'+item['building']+'-'+item['household']+'-'+item['floor'],textAlign: TextAlign.center,
                          )),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (selectvalue) {
                        print(selectvalue);
                        setState(() {
                          memos.text="??????2016\n??????4564\ntest\ntest2\ntest5";
                          residentID=selectvalue['id'];
                          buildInfo=selectvalue;
                          buildID=selectvalue['construction']['id'];
                          floor.text=selectvalue['floor'];
                          household.text=selectvalue['household'];
                          building.text=selectvalue['building'];
                          num.text=selectvalue['address'];
                          print(selectvalue['overWarranty']);
                          if(selectvalue['overWarranty']==true){
                            over='assets/images/mainten_create/bar1_out.png';
                          }
                          else{
                            over='assets/images/mainten_create/bar1.png';
                          }

                        });
                      },
                      value: buildInfo,
                    )),)),
                    SizedBox(width: 10,)

                  ],

                ),
                SizedBox(height: 10,),
                Visibility(
                    visible: false,
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: building,
                        decoration: const InputDecoration(
                          hintText: "??????",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: household,
                        decoration: const InputDecoration(
                          hintText: "??????",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: floor,
                        decoration: const InputDecoration(
                          hintText: "??????",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),

                    SizedBox(width: 10,)

                    //  Expanded(
                    //     child: TextFormField(
                    //       controller: floor,
                    //       decoration: const InputDecoration(
                    //         hintText: "????????????",
                    //       ),
                    //     ),
                    //   )
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/mainten_create/bt004.png',height:20,width:100,),

                    Expanded(
                      child: TextFormField(
                        controller: num,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "????????????",
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Image.asset(over),),
                  ],
                ),
                SizedBox(width: 10,height: 10,),
             /*  memos==null?SizedBox(width: 10,height: 10,): Padding(
                  padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                  child:
                Container(
                  constraints: BoxConstraints(maxHeight: 50),
                  child:VsScrollbar(
                      color: Colors.yellow,
                      controller:control,
                      isAlwaysShown: true,
                      thickness: 3.0,
                      child:
                  SingleChildScrollView(
                    controller: control,
                    child: TextField(
                      decoration: new InputDecoration(
                          disabledBorder:new OutlineInputBorder(  //????????????
                           // borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),
                      ),
                      controller: memos,
                      maxLines: null,
                      enabled: false,
                    ),
                  )),
                ),),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/list.png',height:20,width:100,),
                    new Expanded(child:
                    new Container(color:Colors.white,
                      child:new DropdownButtonHideUnderline(child:
                      new DropdownButton<dynamic>(
                        isExpanded: true,
                        hint:Center(child: Text('???????????????????????????',textAlign: TextAlign.center)),
                        items: widget.data['Categories'].skip(1).map<DropdownMenuItem<dynamic>>((item) {
                          return new DropdownMenuItem<dynamic>(
                            child: Center(child:new Text(item['name'])),
                            value: item['id'],
                          );
                        }).toList(),
                        onChanged: (selectvalue) {
                          print(selectvalue);
                          setState(() {
                            Category=selectvalue;
                            Itmes=null;
                          });
                        },
                        value: Category,
                      )),)),
                    SizedBox(width: 10,)
                  ],
                ),
                SizedBox(height: 10,),
                Category!=null?Row(children: [
                  Image.asset('assets/images/mainten_create/list.png',height:20,width:100,),
                  Expanded(child:
                  new Container(color:Colors.white,
                    child:new DropdownButtonHideUnderline(child:
                    new DropdownButton<dynamic>(
                      isExpanded: true,
                      hint:Center(child: Text('???????????????????????????',textAlign: TextAlign.center)),
                      items: widget.data['Items'][Category.toString()].skip(1).map<DropdownMenuItem<dynamic>>((item) {
                        return new DropdownMenuItem<dynamic>(
                          child: Center(child:new Text(item['name'])),
                          value: item['id'],
                        );
                      }).toList(),
                      onChanged: (selectvalue) {
                        print(selectvalue);
                        setState(() {
                          Itmes=selectvalue;
                        });
                      },
                      value: Itmes,
                    )),)),
                  SizedBox(width: 10,)
                ],):
                Row(children: [
                  Image.asset('assets/images/mainten_create/list.png',height:20,width:100,),
                  Expanded(child:
                  new Container(color:Colors.white,
                    child:new DropdownButtonHideUnderline(child:
                    new DropdownButton<dynamic>(
                      isExpanded: true,
                      hint:Center(child: Text('???????????????????????????',textAlign: TextAlign.center)),

                      onChanged: (selectvalue) {
                        print(selectvalue);
                        setState(() {
                          Itmes=selectvalue;
                        });
                      },
                      value: Itmes,
                    )),)),
                  SizedBox(width: 10,)
                ],),


                SizedBox(width: 10,height: 10,),
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/messg.png',height:20,width:100,),
                    Expanded(
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(  //????????????
                            borderSide: BorderSide(color: Colors.blue, width: 5.0),
                          ),
                        ),
                        controller: fix,
                        minLines: 5,
                        maxLines: 10,
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/mainten_create/flie.png',height:20,width:100,),
                    Expanded(child: Text("")),
                  ],
                ),
                //  Row(children:<Widget>[new IconButton(icon:Icon(Icons.backup), onPressed: getFilePath),_filepath==null?Text('??????????????????'):
                // Expanded(child:Text(_filepath,softWrap: true,)
                //  ,) ]),
                Row(
                  children: <Widget>[
                    Expanded(child: IconButton(icon:Image.asset(camera),onPressed: _takePhoto,iconSize:100,)),
                    Expanded(child: IconButton(icon:Image.asset(upfile),onPressed: _openGallery,iconSize:100)),
                  ],
                ),
                Scrollbar(
                  child:
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         img1Path==null?Text(''): Image.network(img1Path,height:75,width:75,fit: BoxFit.fill,),
                          img1Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img1Path = null;});} ,
                            child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img2Path==null?Text(''): Image.network(img2Path,height:75,width:75,fit: BoxFit.fill),
                          img2Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img2Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img3Path==null?Text(''): Image.network(img3Path,height:75,width:75,fit: BoxFit.fill),
                          img3Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img3Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img4Path==null?Text(''): Image.network(img4Path,height:75,width:75,fit: BoxFit.fill),
                          img4Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img4Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img5Path==null?Text(''): Image.network(img5Path,height:75,width:75,fit: BoxFit.fill),
                          img5Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img5Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                        ]
                    ),
                )),
                Row(children: [
                  Expanded(child: IconButton(
                    icon:
                    Image.asset('assets/images/mainten_create/sent.png'),
                    onPressed: ()  {
                      if(checkinput()){sentfix();}
                    },
                    iconSize: 100,
                  )),
                ],)
              ],
            ),
          )
      ),
    ));
  }
  void showEnd(BuildContext context,var show) {
    Alert(
        title: '??????',
        context: context,
        type: AlertType.success,
        desc: "??????",
        buttons: [
          DialogButton(onPressed: (){
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context,"test");
          }, child: Text(show))
        ]
    ).show();
  }
  _takePhoto() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "?????????WIFI?????????????????????",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          camera = 'assets/images/cupertino.gif';
        });
        var name = image.toString().split('/');
        var filename = name[name.length - 1];
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(await APIs().uploadimg_no(base64Image, filename));
        print(re['data']);
        if (img1Path == null) {
          if (re['data']['errors'] == "") {
            img1id = re['data']['projectFileId'].toString();
            setState(() {
              img1Path = re['data']['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img2Path == null) {
          if (re['data']['errors'] == "") {
            img2id = re['data']['projectFileId'].toString();
            setState(() {
              img2Path = re['data']['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img3Path == null) {
          if (re['data']['errors'] == "") {
            img3id = re['data']['projectFileId'].toString();
            setState(() {
              img3Path = re['data']['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img4Path == null) {
          if (re['data']['errors'] == "") {
            img4id = re['data']['projectFileId'].toString();
            setState(() {
              img4Path = re['data']['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        } else if (img5Path == null) {
          if (re['data']['errors'] == "") {
            img5id = re['data']['projectFileId'].toString();
            setState(() {
              img5Path = re['data']['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else {
          setState(() {
            camera = 'assets/images/mainten_create/cream.png';
          });
          Alert(context: context, title: "??????", desc: "?????????????????????",buttons:[]).show();
        }
      }
    }
  }
  /*??????*/
  _openGallery() async {
    if (await APIs().isNetWorkAvailable() == 0) {
      Fluttertoast.showToast(
        msg: "?????????WIFI?????????????????????",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          upfile = 'assets/images/cupertino.gif';
        });
        var name = image.toString().split('/');
        var filename = name[name.length - 1];
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(await APIs().uploadimg_no(base64Image, filename));
        print(re);
        if (img1Path == null) {
          if (re['data']['errors'] == "") {
            img1id = re['data']['projectFileId'].toString();
            setState(() {
              img1Path = re['data']['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img2Path == null) {
          if (re['data']['errors'] == "") {
            img2id = re['data']['projectFileId'].toString();
            setState(() {
              img2Path = re['data']['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img3Path == null) {
          if (re['data']['errors'] == "") {
            img3id = re['data']['projectFileId'].toString();
            setState(() {
              img3Path = re['data']['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img4Path == null) {
          if (re['data']['errors'] == "") {
            img4id = re['data']['projectFileId'].toString();
            setState(() {
              img4Path = re['data']['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img5Path == null) {
          if (re['data']['errors'] == "") {
            img5id = re['data']['projectFileId'].toString();
            setState(() {
              img5Path = re['data']['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else {
          Alert(context: context, title: "??????", desc: "?????????????????????", buttons: [])
              .show();
          setState(() {
            upfile = 'assets/images/mainten_create/flieupload.png';
          });
        }
      }
    }
  }
/*  void getFilePath() async {
    var filePath = await FilePicker.getFilePath(type: FileType.custom,allowedExtensions: ['pdf', 'doc'],);
    var name=filePath.split("/");
    var filename=name[name.length-1];
    var file=File(filePath);
    List<int> file_64 = await file.readAsBytes();
    String base64file= base64Encode(file_64);
    var re=json.decode(await APIs().uploadfile_no(filename, base64file));
    print(re);
    if(re['data']['errors']==''){
      file1_id= re['data']['projectFileId'].toString();
      setState((){_filepath = filename;});
    }
    if (filePath == '') {
      return;
    }
    print("File path: " + filePath);

  }*/
  sentfix()async{
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "?????????WIFI?????????????????????",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var info = Map<String, dynamic>();
      print(name.text);
      info['projectCategoryId'] = Category.toString();
      info['projectItemId'] = Itmes.toString();
      info['constructionId'] = buildID.toString();
      info['repairName']=name.text.toString();
      info['repairPhone']=phone.text.toString();
      info['repairEmail']=email.text.toString();
      info['repairAddress']=num.text.toString()  ;
      info['repairBuilding']=building.text.toString();
      info['repairHousehold']=household.text.toString();
      info['repairFloor']=floor.text.toString();
      info['residentId']=residentID.toString();
      info['message'] = fix.text.toString();
      info['clientId'] = widget.data['info']['user_id'];
      info['repairMobile']=phone.text.toString();
      info['images'] = [img1id, img2id, img3id, img4id, img5id,];
      info['files'] = [file1_id];
      print(info);
      var end = json.decode(await APIs().menberfix(widget.data['tk'], info));
      if (end['data']['errors'] == "") {
        showEnd(context, '??????');
      }
      else {
        showEnd(context, end['data']['errors']);
      }
    }
  }
  checkinput(){
    print(buildID);
    if(name.text==""){
      Alert(
        title:'??????',
        context: context,
        type: AlertType.warning,
        desc: "???????????????",
          buttons: []
      ).show();
      return false;
    }
    else if(phone.text==""){Alert(
      title:'??????',
      context: context,
      type: AlertType.warning,
      desc: "???????????????",
        buttons: []
    ).show();
    return false;
    }
    else if(email.text==''){Alert(
      title:'??????',
      context: context,
      type: AlertType.warning,
      desc: "?????????email",
        buttons: []
    ).show();
    return false;
    }

    else if(buildID==null){Alert(
      title:'??????',
      context: context,
      type: AlertType.warning,
      desc: "???????????????",
        buttons: []
    ).show();
    return false;
    }
    else if(num.text==''){Alert(
      title:'??????',
      context: context,
      type: AlertType.warning,
      desc: "???????????????",
        buttons: []
    ).show();
    return false;
    }
    else if(Category==null){
      Alert(
        title:'??????',
        context: context,
        type: AlertType.warning,
        desc: "?????????????????????",
          buttons: []
      ).show();
      return false;
    }
    else if(Itmes==null){
      Alert(
          title:'??????',
          context: context,
          type: AlertType.warning,
          desc: "?????????????????????",
          buttons: []
      ).show();
      return false;
    }
    else if(fix.text==''){
      Alert(
        title:'??????',
        context: context,
        type: AlertType.warning,
        desc: "?????????????????????",
          buttons: []
      ).show();
      return false;
    }
    else{return true;}

  }

}
