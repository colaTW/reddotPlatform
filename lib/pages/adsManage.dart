import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/pages/adminManage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

class adsManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _adsManage();
  }
}
class _adsManage extends State<adsManage> {
  var data;
  var projectCategories;
  List<int> imageBytes=null;
  TextEditingController buildname = TextEditingController();
  TextEditingController buildnumber = TextEditingController();
  TextEditingController buildphone = TextEditingController();

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode('{"projectCategories":[{"id":0,"name":"下林1號"},{"id":1,"name":"下林2號"},{"id":2,"name":"下林3號"},{"id":3,"name":"下林4號"},{"id":4,"name":"下林5號"},{"id":5,"name":"下林6號"},{"id":6,"name":"下林7號"},{"id":7,"name":"下林8號"}]}');
    });
    projectCategories=data['projectCategories'];

    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("輪播廣告管理"), backgroundColor: Colors.blue),
      body:SingleChildScrollView(
        child:
        new Column(children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(
              child: Text('新增輪播廣告'),
              onPressed: ()async{
              var result = await newAdsDialog(context,"new");
              if(result){
              setState(() {
                  data = json.decode('{"projectCategories":[{"id":0,"name":"下林9號"},{"id":1,"name":"下林10號"},{"id":2,"name":"下林11號"},{"id":3,"name":"下林41號"},{"id":4,"name":"下林51號"},{"id":5,"name":"下林16號"},{"id":6,"name":"下林71號"},{"id":7,"name":"下林81號"}]}');
                  projectCategories=data['projectCategories'];
              });};
            },),
            ElevatedButton(
              child: Text('建案管理'),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => adminManage()));
              },),

          ],),
        new Card(
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text('代碼'),
              new Text('圖片'),
              new Text('刪除'),
              new Text('修改'),
            ],) ,
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: projectCategories == null ? 0 : projectCategories.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Text(projectCategories[index]["id"].toString()),
                    new Text(projectCategories[index]["name"].toString()),
                    new ElevatedButton(
                      child: Text("刪除"),
                      onPressed: (){
                        Alert(
                            title: '刪除',
                            context: context,
                            type: AlertType.warning,
                            desc: projectCategories[index]["id"].toString()+"圖片",
                            buttons: [
                              DialogButton(
                                child: Text('確認'),
                                onPressed: (){
                                  Navigator.of(context,rootNavigator: true).pop();
                                },
                              ),
                              DialogButton(
                                child: Text('取消'),
                                color: Colors.red,
                                onPressed: (){
                                  Navigator.of(context,rootNavigator: true).pop();
                                },)
                            ]
                        ).show();
                      },),
                    new ElevatedButton(
                      child: Text("修改"),
                      onPressed: ()async{
                        buildname.text=projectCategories[index]["name"].toString();
                        buildnumber.text=projectCategories[index]["id"].toString();
                        var result = await newAdsDialog(context,'fix');

                        if(result){
                          setState(() {
                            data = json.decode('{"projectCategories":[{"id":0,"name":"下林9號"},{"id":1,"name":"下林10號"},{"id":2,"name":"下林11號"},{"id":3,"name":"下林41號"},{"id":4,"name":"下林51號"},{"id":5,"name":"下林16號"},{"id":6,"name":"下林71號"},{"id":7,"name":"下林81號"}]}');
                            projectCategories=data['projectCategories'];
                          });};

                      }, )
                  ], )
            );
          },
        ),
      ]),)
    );
  }
  Future<bool> newAdsDialog(BuildContext context,String way) async{
    return await
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            content: Container(
                child:Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildname,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "代號",
                      ),
                    ),
                  ),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: ElevatedButton(
                          child:Text('上傳圖片'),
                          onPressed: ()async{
                            _openGallery();
                          },
                        ),),
                        imageBytes==null?Text('圖片'):Expanded(child: Image.memory(imageBytes))
                  ],)
                ],)

            ),
            actions: <Widget>[
              new TextButton(
                onPressed: () {
                  imageBytes=null;
                  switch(way){
                    case 'fix':
                      break;
                  }
                  Navigator.pop(context, true);
                },
                child: new Text("確認"),
              ),

            ],
          );
        });
  }
  _openGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var name = image.toString().split('/');
        var filename = name[name.length - 1];
        imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        Navigator.pop(context, true);
        newAdsDialog(context,'fix');

      }

  }
}

