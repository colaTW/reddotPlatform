import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui show ImageByteFormat, Image;
import 'package:webview_flutter/webview_flutter.dart';



///
class fivepage extends StatefulWidget {
  @override
  _fivepage createState() => _fivepage();
}
class _fivepage extends State<fivepage> {


  @override
  Widget build(BuildContext context) {
        return Scaffold(

      body: WebView(
        initialUrl: 'https://hocom.tw/h/News?key=260737138508',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );

//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Color(0xFF666259),
//
//      ),
//      body: Container(
//        margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
//        child: Column(
//          children: <Widget>[
//            Text('敬請期待')
//          ],
//      ),
//    ));
  }

  /// 添加点，注意不要超过Widget范围

  /// 选取保存文件的路径


  /// 截图，并且返回图片的缓存地址

}

class BoardPainter extends CustomPainter {
  BoardPainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  bool shouldRepaint(BoardPainter other) => other.points != points;
}

