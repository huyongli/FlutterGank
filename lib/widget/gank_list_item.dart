import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:gank_flutter/entity/gank_news.dart';

class GankListItemWidget extends StatefulWidget {
  final GankNews _gankNews;

  GankListItemWidget(this._gankNews);

  @override
  State createState() {
    return GankListItemState(_gankNews);
  }
}

class GankListItemState extends State<GankListItemWidget> {
  final GankNews _gankNews;

  GankListItemState(this._gankNews);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(6.0),
            child: Row(
              children: _renderRowChildren(),
            ),
          ),
          onTap: _openNewsUrl,
        )
    );
  }

  List<Widget> _renderRowChildren() {
    var widgets = <Widget>[
      Expanded(
        child: Container(
          height: !_checkHasImage() ? null : 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(_gankNews.desc, maxLines: 3, overflow: TextOverflow.ellipsis,)
              ),
              Text('作者：${_gankNews.who}'),
            ]
          ),
        ),
      ),
    ];

    if(_checkHasImage()) {
      widgets.add(Image.network(_gankNews.images[0], width: 60.0, height: 100.0,));
    }
    return widgets;
  }

  bool _checkHasImage() {
    return _gankNews.images != null && _gankNews.images.length > 0;
  }

  void _openNewsUrl() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WebviewScaffold(
        url: _gankNews.url,
        appBar: AppBar(
          title: Text(_gankNews.desc, maxLines: 1, overflow: TextOverflow.ellipsis,),
        ),
        withZoom: false,
        withJavascript: true,
        withLocalStorage: true,
      );
    }));
  }
}