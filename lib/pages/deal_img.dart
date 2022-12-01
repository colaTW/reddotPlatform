import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
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
import 'package:fluttertoast/fluttertoast.dart';


class deal_img extends StatefulWidget {
  dynamic data;
  deal_img({this.data});

  @override
  State<StatefulWidget> createState() {
    return _deal_img();
  }
}
class _deal_img extends State<deal_img> {

  var img1,img2,img3,img4,img5;
  var img1_id="";
  var img2_id="";
  var img3_id="";
  var img4_id="";
  var img5_id="";
  String gif1='assets/images/memberlogin/uploadimg.png';
  String gif2='assets/images/memberlogin/uploadimg.png';
  String gif3='assets/images/memberlogin/uploadimg.png';
  String gif4='assets/images/memberlogin/uploadimg.png';
  String gif5='assets/images/memberlogin/uploadimg.png';
  var img1Path,img2Path,img3Path,img4Path,img5Path;
  var Category;
  var img1id,img2id,img3id,img4id,img5id;
  var buildID;
  var _filepath;
  var file1_id;
  String camera='assets/images/mainten_create/cream.png';
  String upfile='assets/images/mainten_create/flieupload.png';
  @override
  void initState() {
    super.initState();
    print(widget.data['0']);

    setState(() {
      img1Path=(widget.data['0']).toString();
      img2Path=(widget.data['1']).toString();
      img3Path=(widget.data['2']).toString();
      img4Path=(widget.data['3']).toString();
      img5Path=(widget.data['4']).toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
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
                color: Color(0xFF2A3233),
                child:
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 50,),
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
                                img1Path==''?Text(''): Image.network(img1Path,height:75,width:75,fit: BoxFit.fill,),
                                img1Path==''? Text(''):GestureDetector(onTap:(){ setState(() {img1Path = '';});} ,
                                    child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                                SizedBox(width: 50,),
                                img2Path==''?Text(''): Image.network(img2Path,height:75,width:75,fit: BoxFit.fill),
                                img2Path==''? Text(''):GestureDetector(onTap:(){ setState(() {img2Path = '';});} ,
                                    child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                                SizedBox(width: 50,),
                                img3Path==''?Text(''): Image.network(img3Path,height:75,width:75,fit: BoxFit.fill),
                                img3Path==''? Text(''):GestureDetector(onTap:(){ setState(() {img3Path = '';});} ,
                                    child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                                SizedBox(width: 50,),
                                img4Path==''?Text(''): Image.network(img4Path,height:75,width:75,fit: BoxFit.fill),
                                img4Path==''? Text(''):GestureDetector(onTap:(){ setState(() {img4Path = '';});} ,
                                    child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                                SizedBox(width: 50,),
                                img5Path==''?Text(''): Image.network(img5Path,height:75,width:75,fit: BoxFit.fill),
                                img5Path==''? Text(''):GestureDetector(onTap:(){ setState(() {img5Path = '';});} ,
                                    child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                              ]
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
    Container(width:width-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFFC9CACA)) ,),child: Text('確認'),onPressed: ()async{
                        if(img1id.toString()!=''){
                          APIs().save_string("img1_id",img1id);
                        }
                        if(img2id.toString()!=''){
                          APIs().save_string("img2_id",img2id);
                        }
                        if(img3id.toString()!=''){
                          APIs().save_string("img3_id",img3id);
                        }
                        if(img4id.toString()!=''){
                          APIs().save_string("img4_id",img4id);
                        }
                        if(img5id.toString()!=''){
                          APIs().save_string("img5_id",img5id);
                        }
                        APIs().save_string("img1",img1Path);
                        APIs().save_string("img2",img2Path);
                        APIs().save_string("img3",img3Path);
                        APIs().save_string("img4",img4Path);
                        APIs().save_string("img5",img5Path);


                        Navigator.pop(context);
                      },)),
    Container(width:width-20,child: ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xFF898989)) ,),child:Text('取消'),onPressed: ()async{
                          final prefs = await SharedPreferences.getInstance();
                          prefs.remove('img1');
                          prefs.remove('img2');
                          prefs.remove('img3');
                          prefs.remove('img4');
                          prefs.remove('img5');
                          prefs.remove('img1_id');
                          prefs.remove('img2_id');
                          prefs.remove('img3_id');
                          prefs.remove('img4_id');
                          prefs.remove('img5_id');
                          Navigator.pop(context);

                        }))

                    ],)

                  ],
                )
            )
        )
    );
  }
  _takePhoto() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
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
        var re = json.decode(await APIs().uploadimg(widget.data['tk'],filename,base64Image));
        print(re['data']);
        if (img1Path == '') {
          if (re['data']['errors'] == "") { 
            img1id = re['data']['handlerFileId'].toString();
            setState(() {
              img1Path = re['data']['handlerFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img2Path == '') {
          if (re['data']['errors'] == "") {
            img2id = re['data']['handlerFileId'].toString();
            setState(() {
              img2Path = re['data']['handlerFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img3Path == '') {
          if (re['data']['errors'] == "") {
            img3id = re['data']['handlerFileId'].toString();
            setState(() {
              img3Path = re['data']['handlerFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img4Path == '') {
          if (re['data']['errors'] == "") {
            img4id = re['data']['handlerFileId'].toString();
            setState(() {
              img4Path = re['data']['handlerFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        } else if (img5Path == '') {
          if (re['data']['errors'] == "") {
            img5id = re['data']['handlerFileId'].toString();
            setState(() {
              img5Path = re['data']['handlerFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else {
          setState(() {
            camera = 'assets/images/mainten_create/cream.png';
          });
          Alert(context: context, title: "提醒", desc: "上傳以五張為限",buttons:[]).show();
        }
      }
    }
  }
  _openGallery() async {
    if (await APIs().isNetWorkAvailable() == 0) {
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
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
        var re = json.decode(await APIs().uploadimg(widget.data['tk'], filename,base64Image));

        if (img1Path == '') {
          if (re['data']['errors'] == "") {
            img1id = re['data']['handlerFileId'].toString();
            setState(() {
              img1Path = re['data']['handlerFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img2Path == '') {
          if (re['data']['errors'] == "") {
            img2id = re['data']['handlerFileId'].toString();
            setState(() {
              img2Path = re['data']['handlerFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img3Path == '') {
          if (re['data']['errors'] == "") {
            img3id = re['data']['handlerFileId'].toString();
            setState(() {
              img3Path = re['data']['handlerFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img4Path =='') {
          if (re['data']['errors'] == "") {
            img4id = re['data']['handlerFileId'].toString();
            setState(() {
              img4Path = re['data']['handlerFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img5Path == '') {
          if (re['data']['errors'] == "") {
            img5id = re['data']['handlerFileId'].toString();
            setState(() {
              img5Path = re['data']['handlerFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else {
          Alert(context: context, title: "提醒", desc: "上傳以五張為限", buttons: [])
              .show();
          setState(() {
            upfile = 'assets/images/mainten_create/flieupload.png';
          });
        }
      }
    }
  }
  /*_openGallery1() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        gif1 = 'assets/images/cupertino.gif';
      });
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(
            await APIs().uploadimg(widget.data['tk'], base64Image));
        print(re['data']);
        if (re['data']['errors'] == "") {
          img1_id = re['data']['handlerFileId'].toString();
          setState(() {
            img1 = re['data']['handlerFileUrl'];
          });
        }
      }
      else {
        setState(() {
          gif1 = 'assets/images/memberlogin/uploadimg.png';
        });
      }
    }
  }
  _openGallery2() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        gif2 = 'assets/images/cupertino.gif';
      });
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(
            await APIs().uploadimg(widget.data['tk'], base64Image));
        if (re['data']['errors'] == "") {
          img2_id = re['data']['handlerFileId'].toString();
          setState(() {
            img2 = re['data']['handlerFileUrl'];
          });
        }
      }
      else {
        setState(() {
          gif2 = 'assets/images/memberlogin/uploadimg.png';
        });
      }
    }
  }
  _openGallery3() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        gif3 = 'assets/images/cupertino.gif';
      });
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(
            await APIs().uploadimg(widget.data['tk'], base64Image));
        if (re['data']['errors'] == "") {
          img3_id = re['data']['handlerFileId'].toString();
          setState(() {
            img3 = re['data']['handlerFileUrl'];
          });
        }
      }
      else {
        setState(() {
          gif3 = 'assets/images/memberlogin/uploadimg.png';
        });
      }
    }
  }
  _openGallery4() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        gif4 = 'assets/images/cupertino.gif';
      });
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(
            await APIs().uploadimg(widget.data['tk'], base64Image));
        if (re['data']['errors'] == "") {
          img4_id = re['data']['handlerFileId'].toString();
          setState(() {
            img4 = re['data']['handlerFileUrl'];
          });
        }
      }
      else {
        setState(() {
          gif4 = 'assets/images/memberlogin/uploadimg.png';
        });
      }
    }
  }
  _openGallery5() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        gif5 = 'assets/images/cupertino.gif';
      });
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(
            await APIs().uploadimg(widget.data['tk'], base64Image));
        if (re['data']['errors'] == "") {
          img5_id = re['data']['handlerFileId'].toString();
          setState(() {
            img5 = re['data']['handlerFileUrl'];
          });
        }
      }
      else {
        setState(() {
          gif5 = 'assets/images/memberlogin/uploadimg.png';
        });
      }
    }
  }*/

}