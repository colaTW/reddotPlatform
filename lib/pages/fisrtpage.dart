import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/secondpage.dart';
import 'package:flutterapp/pages/thirdpage.dart';
import 'package:flutterapp/pages/register.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:googleapis/customsearch/v1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterapp/APIs.dart';
import 'dart:convert';



class firstpage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _firstpage();
  }
}



class _firstpage extends State<firstpage> {
  List<dynamic> upimg = [];
  List<dynamic> midimg = [];
  List<dynamic> downimg = [];
  void initState() {
    print(upimg);
   getbanner();
  }

  final Color bkcolor = HexColor.fromHex('#666259');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
        color: Color(0xFF2A3233),
        child:
        Container(
          margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: SingleChildScrollView(
          padding:EdgeInsetsDirectional.zero ,
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('reddotDemoV1.1'),
            Container(
                padding:EdgeInsetsDirectional.zero ,
                width:width-20,
                height: 250,
                child:
                upimg.length==0?Text(''):new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: Image.network(upimg[index]['image'],fit:BoxFit.fitWidth,),
                      onTap:()async{
                        _launchURL(upimg[index]['url']);
                      },
                    );
                  },
                  itemCount: upimg.length,
                  loop: true,
                  autoplay: true,
                  pagination:
                      new SwiperPagination(), //如果不填則不顯示指示點 control: new SwiperControl(),//如果不填則不顯示左右按鈕 ), ),
                )
            ),
            Container(
              width:width-20,
              height: 250,
              child: IconButton(
              icon:
              Image.asset('assets/images/home/registed.png'),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => register()));
              },
              iconSize: 100,
            )),
            Container(
                width:width-20,
                height: 250,
                child: IconButton(
                  icon:
                  Image.asset('assets/images/home/login.png'),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => secondpage()));
                  },
                  iconSize: 100,
                )),
          ],
        )
        )));
  }
  getbanner()async{
    if(await APIs().isNetWorkAvailable()==0){
    Fluttertoast.showToast(
    msg: "請連接WIFI或使用行動網路",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,

    );
    }
    else{
      var re=json.decode(await APIs().getbanner());
      if(re['data'].length==0){
        return;
      }
      for(int i=0;i<re['data'].length;i++){
        if(re['data'][i]['area']==1){
          if(re['data'][i]['imageUrl']==''){re['data'][i]['imageUrl']='https://baotai.com.tw/baotai/img/index1.png';}
          setState(() {
            upimg.add({'image':re['data'][i]['imageUrl'],'url':re['data'][i]['url']});
          });
        }
        else if(re['data'][i]['area']==2){
          if(re['data'][i]['imageUrl']==''){re['data'][i]['imageUrl']='https://baotai.com.tw/baotai/img/index1.png';}

          setState(() {
            midimg.add({'image':re['data'][i]['imageUrl'],'url':re['data'][i]['url']});
          });
        }
        else if(re['data'][i]['area']==3){
          if(re['data'][i]['imageUrl']==''){re['data'][i]['imageUrl']='https://baotai.com.tw/baotai/img/index1.png';}

          setState(() {
            downimg.add({'image':re['data'][i]['imageUrl'],'url':re['data'][i]['url']});
            print(downimg);
          });
        }
      }

    }
  }

}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

_launchURL(var url) async {
  if(await APIs().isNetWorkAvailable()==0){
    Fluttertoast.showToast(
      msg: "請連接WIFI或使用行動網路",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,

    );
  }
  else {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("123");
    }
  }
}

