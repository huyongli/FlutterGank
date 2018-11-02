import 'package:gank_flutter/entity/gank_news.dart';

List<GankNews> parseGankNews(List<dynamic> news) {
  List<GankNews> list = [];
  for(var item in news) {
    list.add(GankNews.fromJson(item));
  }
  return list;
}