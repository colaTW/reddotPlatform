import 'dart:io';
import 'package:googleapis/datastore/v1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class APIs {
  var url = 'baotai.edwardforce.tw';
  static  var filelist=List();
  login(String ac,String pas) async{
    var params = Map<String, String>();
    params["account"] = ac;
    params["password"] = pas;print(params);
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/user-login');
    var response = await client.post(uri, body: params,);
    return (response.body);
  }
  login_member(String ac,String pas) async{
    var params = Map<String, String>();
    var header = Map<String, String>();
    header["Content-Type"]="application/json";
    params["account"] = ac;
    params["password"] = pas;print(params);
    var body=json.encode(params);
    var client = http.Client();
    print(body);
    var uri = Uri.https(url,'/api/v1/client-login');
    var response = await client.post(uri, body: body,headers:header);
    print(response.body);
    return (response.body);
  }
  getlist_employee(String token,var type,var Category,var items,int pages)async{
    var params = Map<String, String>();
    var body= Map<String, String>();
    body["projectHandlerType"]=type.toString();
    body['page']=pages.toString();
    if(Category!=null){body['projectCategoryId']=Category.toString();}
    if(items!=null){body['projectItemId']=items.toString();}
    else{body['projectItemId']='0';}

    params["Authorization"] = "Bearer "+token;
    //params["Content-Type"]="application/json";
    print(body);
    print(params);
    var uri = Uri.https(url,'/api/v1/projects/main/list',body);
    //print(uri);
    var client = http.Client();
    var response = await client.get(uri,headers:params);
    return (response.body);
  }
  getlist_member(String token,var type,var Category,var items,int pages)async{
    var params = Map<String, String>();
    var body= Map<String, String>();
    body["projectHandlerType"]=type.toString();
    body['page']=pages.toString();
    if(Category!=null){body['projectCategoryId']=Category.toString();}
    if(items!=null){body['projectItemId']=items.toString();}
    else{body['projectItemId']='0';}
    params["Authorization"] = ":Bearer "+token;
    //params["Content-Type"]="application/json";
    var uri = Uri.https(url,'/api/v1/client/projects/main/list',body);
    print(body);

    var client = http.Client();
    var response = await client.get(uri,headers:params);
   // print(response.body);
    return (response.body);
  }
  getbuild_member(String token,var clinetID)async{
    var params = Map<String, String>();
    var body= Map<String, String>();
    params["Authorization"] = ":Bearer "+token;
    //params["Content-Type"]="application/json";
    var uri = Uri.https(url,'/api/v1/clients/constructions/'+clinetID.toString(),body);
    print(body);
    var client = http.Client();
    var response = await client.get(uri,headers:params);
    // print(response.body);
    return (response.body);
  }
  newdeal(String token,var info) async{
    var params = Map<String, String>();
    params["Authorization"] = ":Bearer "+token;
    params["Content-Type"]="application/json";
    var client = http.Client();
    var body=json.encode(info);
    print(body);
    var uri = Uri.https(url,'/api/v1/projects/handler/one');
    var response = await client.post(uri,headers:params,body:body);
    return (response.body);
  }
  uploadimg(String token,var name,var img)async{
    var params = Map<String, String>();
    params["Authorization"] = ":Bearer "+token;
    var body= Map<String, String>();
    body['fileName']=name.toString();
    body['file']="data:image/jpeg;base64,"+img;
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/projects/handler/image/one');
    var response = await client.post(uri,headers:params,body:body);
    print("body"+response.body);
    return (response.body);

  }
  uploadfile(String token,var filename,var filetype,var filepath)async{
    var params = Map<String, String>();
    params["Authorization"] = ":Bearer "+token;
    var body= Map<String, String>();
    body['fileName']=filename;
    if(filetype=="xls"){
      body['file']="data:@file/vnd.ms-excel;base64,"+filepath;
    }
    else if(filetype=="doc"){
      body['file']="data:@file/msword;base64,"+filepath;
    }
    else if(filetype=="pdf"){
      body['file']="data:@file/pdf;base64,"+filepath;
    }
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/projects/handler/file/one');
    var response = await client.post(uri,headers:params,body:body);
    print("body"+response.body);
    return (response.body);
  }
  _menberfix(var info) async{
    var params = Map<String, String>();
    params["Content-Type"]="application/json";
    var client = http.Client();
    var body=json.encode(info);
    print(body);
    var uri = Uri.https(url,'/api/v1/projects/main/one/nonmember');
    var response = await client.post(uri,body:body,headers:params);
    return (response.body);
  }
  menberfix(var tk,var info) async{
    var params = Map<String, String>();
    params["Content-Type"]="application/json";
    params["Authorization"] = ":Bearer "+tk;
    var client = http.Client();
    var body=json.encode(info);
    print(body);
    var uri = Uri.https(url,'/api/v1/projects/main/one/client');
    var response = await client.post(uri,body:body,headers:params);
    print("here"+response.body);
    return (response.body);
  }
  uploadimg_no(var img,var name)async{
    var params = Map<String, String>();
    var body= Map<String, String>();
    body['fileName']=name.toString();
    body['file']="data:image/jpeg;base64,"+img;
    print(body);
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/projects/main/image/one');
    var response = await client.post(uri,headers:params,body:body);
    print("body"+response.body);
    return (response.body);

  }
  sign(var tk,var handler,var img)async{
    var params = Map<String, String>();
    params["Authorization"] = ":Bearer "+tk;
    var body= Map<String, String>();
    body['handlerId']=handler.toString();
    body['clientSignImage']="data:image/jpeg;base64,"+img;
    body[ "clientAgree"]="1";
    print(body);
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/projects/handler/client/reply');
    var response = await client.post(uri,headers:params,body:body);
    print(response.body);
    return (response.body);

  }
  uploadfile_no(var filename,var filepath)async{
    var params = Map<String, String>();
    var body= Map<String, String>();
    body['fileName']=filename;
    body['file']="data:@file/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,"+filepath;
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/projects/main/file/one');
    var response = await client.post(uri,headers:params,body:body);
    return (response.body);
  }
  bulidlist()async{
    var client = http.Client();
    var uri = Uri.https(url,'/api/v1/nonmember/constructions');
    var response = await client.get(uri,);
    return (response.body);
  }
  singinbuild(var tk,var info)async{
    var params = Map<String, String>();
    params["Content-Type"]="application/json";
    params["Authorization"] = ":Bearer "+tk;
    var client = http.Client();
    var body=json.encode(info);
    print(body);
    var uri = Uri.https(url,'/api/v1/projects/client/residents');
    var response = await client.post(uri,body:body,headers:params);
    print(response.body);
    return (response.body);
  }

  getbanner()async{
    var uri = Uri.https(url,'/api/v1/home/banner/list',);
    var client = http.Client();
    var response = await client.get(uri,);
    // print(response.body);
    return (response.body);
  }

  read(var key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key) ?? 0;
   return value.toString();
  }

  save(var key,var value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    print('saved $value');
  }

  read_string(var key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? '';
    return value.toString();
  }

  save_string(var key,var value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');
  }
  Future<int> isNetWorkAvailable() async{
    var connectivityResult = await (new Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile)
      return 1;
    else if (connectivityResult == ConnectivityResult.wifi)
      return 2;
    else if (connectivityResult == ConnectivityResult.none)
      return 0;
  }

}