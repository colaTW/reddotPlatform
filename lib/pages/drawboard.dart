import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui show ImageByteFormat, Image;
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



///
class drawboard extends StatefulWidget {
  @override
  _drawboard createState() => _drawboard();
  dynamic data;
  drawboard({this.data});
}
class _drawboard extends State<drawboard> {
  /// 标记签名画板的Key，用于截图
  GlobalKey _globalKey;
  /// 已描绘的点
  List<Offset> _points = <Offset>[];

  /// 记录截图的本地保存路径
  String _imageLocalPath;

  @override
  void initState() {
    super.initState();
    // Init
    _globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('簽名板'),
          leading: IconButton(
              icon:Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })
          ,backgroundColor: Color(0xA0979F97),
        ),

      body: Container(
        margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 180.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xA0979F97), width: 0.5),
              ),
              child: RepaintBoundary(
                key: _globalKey,
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanUpdate: (details) => _addPoint(details),
                      onPanEnd: (details) => _points.add(null),
                    ),
                    CustomPaint(painter: BoardPainter(_points)),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xA0979F97)) ,),
                  onPressed: () async {
                    setState(() {
                      _points?.clear();
                      _points = [];
                      _imageLocalPath = null;
                    });
                  },
                  child: Text(
                    '清除',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(child: Container()),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0xA0979F97)) ,),
                  onPressed: () async {
                    File toFile = await _saveImageToFile();
                    String toPath = await _capturePng(toFile);
                    print('Signature Image Path: $toPath');
                    setState(() {
                      _imageLocalPath = toPath;
                    });
                  },
                  child: Text(
                    '確認',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 添加点，注意不要超过Widget范围
  _addPoint(DragUpdateDetails details) {
    RenderBox referenceBox = _globalKey.currentContext.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    double maxW = referenceBox.size.width;
    double maxH = referenceBox.size.height;
    // 校验范围
    if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
    if (localPosition.dx > maxW || localPosition.dy > maxH) return;
    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }

  /// 选取保存文件的路径
  Future<File> _saveImageToFile() async {
    Directory tempDir = await getTemporaryDirectory();
    int curT = DateTime.now().millisecondsSinceEpoch;
    String toFilePath = '${tempDir.path}/$curT.png';
    File toFile = File(toFilePath);
    bool exists = await toFile.exists();
    if (!exists) {
      await toFile.create(recursive: true);
    }
    return toFile;
  }

  /// 截图，并且返回图片的缓存地址
  Future<String> _capturePng(File toFile) async {
    // 1. 获取 RenderRepaintBoundary
    RenderRepaintBoundary boundary =
    _globalKey.currentContext.findRenderObject();
    // 2. 生成 Image
    ui.Image image = await boundary.toImage();
    // 3. 生成 Uint8List
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    String base64file= base64Encode(pngBytes);
    var name=toFile.toString().split('/');
    var filename=name[name.length-1];
    print(widget.data);
    var re=json.decode(await APIs().sign(widget.data[0],widget.data[1],base64file));
   print(re);
    // 4. 本地存储Image
    toFile.writeAsBytes(pngBytes);
    if(re['data']['errors']==""){
      Alert(
        context: context,
        type: AlertType.success,
        title: "結果",
        desc: "簽名成功~",
        buttons: [
          DialogButton(
            child: Text(
              "確認",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context,rootNavigator: true).pop();
              Navigator.pop(context,"test");

            },
            width: 120,
          )
        ],
      ).show();
    }
  }
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

