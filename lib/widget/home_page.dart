import 'package:flutter/material.dart';

import 'package:gank_flutter/util/constant.dart';
import 'package:gank_flutter/entity/bottom_nav_bar_item.dart';
import 'package:gank_flutter/widget/listview_widget.dart';

class HomePageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

const List<BottomNavBarItem> bottomNavTabItems = const <BottomNavBarItem>[
  const BottomNavBarItem(gankTabTitle, Icons.receipt, appPrimaryColor),
  const BottomNavBarItem(welfareTabTitle, Icons.image, appPrimaryColor),
//  const BottomNavBarItem(readTabTitle, Icons.assessment, appPrimaryColor),
];

class HomePageState extends State<HomePageWidget> {
  var _appBarTitle = bottomNavTabItems[0].title;
  var _currentIndex = 0;
  var _tabs = <String>['all', 'Android', 'iOS', '拓展资源', '前端'];

  List<BottomNavigationBarItem> _getBottomNavigationBars() {
    return bottomNavTabItems.map(
        (BottomNavBarItem item) {
          return BottomNavigationBarItem(
              icon: Icon(item.icon),
              title: Text(item.title),
              backgroundColor: item.backgroundColor
          );
        }
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          bottom: _appBarTitle == gankTabTitle ? TabBar(
            isScrollable: true,
            tabs: _tabs.map((String tab) {
              return Tab(text: tab,);
            }).toList(),
          ) : null,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _getBottomNavigationBars(),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _appBarTitle = bottomNavTabItems[index].title;
            });
          },
        ),
        body: _renderBodyView(),
      ),
    );
  }

  Widget _renderBodyView() {
    Widget widget;
    switch(_appBarTitle) {
      case welfareTabTitle:
        widget = _renderWelfareListView();
        break;
      default:
        widget = _renderGankListView();
        break;
    }
    return widget;
  }

  Widget _renderGankListView() {
    return TabBarView(
      children: _tabs.map((String tab) {
        return ListViewWidget(tab);
      }).toList(),
    );
  }

  Widget _renderWelfareListView() {
    return ListViewWidget(welfareTabTitle);
  }
}
