import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:gank_flutter/api/api.dart';
import 'package:gank_flutter/util/constant.dart';
import 'package:gank_flutter/entity/gank_news.dart';
import 'package:gank_flutter/widget/gank_list_item.dart';
import 'package:gank_flutter/widget/welfare_list_item.dart';

class ListViewWidget extends StatefulWidget {
  final String tab;

  ListViewWidget(this.tab):super();

  @override
  State createState() {
    return ListViewState(tab);
  }
}

class ListViewState extends State<ListViewWidget> {
  final String _tab;
  var _list = <GankNews>[];
  var _pageSize = 1;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  CancelToken token = new CancelToken();

  ListViewState(this._tab):super();

  Future<Null> _handleRefreshTabContent() {
    _pageSize = 1;
    return _handleRequest((data) {
      setState(() {
        _list = data;
        _pageSize++;
      });
    });
  }

  Future<Null> _handleRequest(Function successHandler) {
    return Api.queryGank(
        category: _tab,
        pageSize: _pageSize,
        successHandler: successHandler,
        errorHandler: (){},
        cancelToken: token,
    );
  }


  @override
  void dispose() {
    super.dispose();
    token.cancel('cancelled');
  }

  @override
  void initState() {
    showRefreshLoading();
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _handleRequest((data) {
          setState(() {
            _list.addAll(data);
            _pageSize++;
          });
        });
      }
    });
    super.initState();
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  _getCount() {
    if(_list.isEmpty) {
      return 0;
    } else {
      return _list.length + 1;
    }
  }

  _renderItem(int index) {
    if(index == _getCount() - 1) {
      return _buildLoadMoreIndicator();
    } else {
      Widget widget;
      switch(_tab) {
        case welfareTabTitle:
          widget = WelfareListItemWidget(_list[index]);
          break;
        default:
          widget = GankListItemWidget(_list[index]);
          break;
      }
      return widget;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefreshTabContent,
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: _getCount(),
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _renderItem(index);
          },
        ),
    );
  }

  ///上拉加载更多
  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///loading框
              CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor),
              Container(
                width: 5.0,
              ),

              ///加载中文本
              Text(
                'loading...',
                style: TextStyle(
                  color: Color(0xFF121917),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]
        ),
      ),
    );
  }
}