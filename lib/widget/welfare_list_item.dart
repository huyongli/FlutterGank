import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gank_flutter/entity/gank_news.dart';

class WelfareListItemWidget extends StatefulWidget {
  final GankNews _gankNews;

  WelfareListItemWidget(this._gankNews);

  @override
  State createState() {
    return WelfareListItemState(_gankNews);
  }
}

class WelfareListItemState extends State<WelfareListItemWidget> {
  final GankNews _gankNews;

  WelfareListItemState(this._gankNews);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Container(
            height: 400.0,
            child: Image.network(
              _gankNews.url,
              fit: BoxFit.cover,
            ),
          ),
          onTap: _viewPhotoDetail,
        )
    );
  }

  _viewPhotoDetail() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Stack(
        children: <Widget>[
          Container(
              child: PhotoView(
                imageProvider: NetworkImage(_gankNews.url),
              )
          ),
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 20.0,
                  bottom: 10.0,
                  right: 10.0,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white)
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }));
  }
}