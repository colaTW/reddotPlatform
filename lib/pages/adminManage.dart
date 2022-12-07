import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/pages/adsManage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class adminManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _adminManage();
  }
}
class _adminManage extends State<adminManage> {
  var data;
  var projectCategories;
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
      appBar: new AppBar(title: new Text("建案管理"), backgroundColor: Colors.blue),
      body:SingleChildScrollView(
        child:
        new Column(children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(
              child: Text('新增建案'),
              onPressed: ()async{
              var result = await newBulidingDialog(context);
              if(result){
              setState(() {
                  data = json.decode('{"projectCategories":[{"id":0,"name":"下林9號"},{"id":1,"name":"下林10號"},{"id":2,"name":"下林11號"},{"id":3,"name":"下林41號"},{"id":4,"name":"下林51號"},{"id":5,"name":"下林16號"},{"id":6,"name":"下林71號"},{"id":7,"name":"下林81號"}]}');
                  projectCategories=data['projectCategories'];
              });};
            },),
            ElevatedButton(
              child: Text('廣告管理'),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => adsManage()));
              },),

          ],),
        new Card(
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text('建案名稱'),
              new Text('電話'),
              new Text('姓名'),
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
                    new Text(projectCategories[index]["name"]),
                    new Text('電話'+index.toString()),
                    new Text('姓名'+index.toString()),
                    new ElevatedButton(
                      child: Text("刪除"),
                      onPressed: (){
                        Alert(
                            title: '刪除',
                            context: context,
                            type: AlertType.warning,
                            desc: projectCategories[index]["id"].toString()+"號建案",
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
                        var result = await newBulidingDialog(context);

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
  Future<bool> newBulidingDialog(BuildContext context,) async{
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
                      controller:buildnumber,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "代號",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildname,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "名稱",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildphone,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "電話",
                      ),
                    ),
                  ),

                ],)

            ),
            actions: <Widget>[
              new TextButton(
                onPressed: () {
                  buildphone.clear();
                  buildnumber.clear();
                  buildname.clear();
                  Navigator.pop(context, true);
                },
                child: new Text("確認"),
              ),

            ],
          );
        });
  }
}

