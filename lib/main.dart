import 'package:flutter/material.dart';
import 'package:gank_flutter/widget/home_page.dart';
import 'package:gank_flutter/util/constant.dart';

void main() => runApp(GankApp());

class GankApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gank',
      theme: ThemeData(
        primaryColor: appPrimaryColor,
      ),
      home: HomePageWidget(),
    );
  }
}