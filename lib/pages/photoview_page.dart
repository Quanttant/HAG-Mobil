import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String title;
  final String imgUrl;
  final bool localImg;
  PhotoViewPage({this.title, this.imgUrl, this.localImg = false});

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
          )),
      body: PhotoView(
        imageProvider: widget.localImg ? AssetImage(widget.imgUrl) : NetworkImage(widget.imgUrl),
        loadingBuilder: (BuildContext context, ImageChunkEvent event) => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00B8C0)),
          ),
        ),
        errorBuilder: (_, __, ___) {
          return Text('İnternet bağlantınız yok.');
        },
      ),
    );
  }
}
