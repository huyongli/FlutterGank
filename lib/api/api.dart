import 'package:dio/dio.dart';

import 'package:gank_flutter/util/util.dart';

class Api {
  static final dio = Dio(Options(
      baseUrl: 'https://gank.io/api/',
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        'user-agent': 'dio',
        'api': '1.0.0',
      },
      validateStatus: (status) {
        return status >= 200 && status < 300 || status == 304;
      }
  ));

  static Future<Null> queryGank({String category, int pageSize,
    Function successHandler, Function errorHandler, CancelToken cancelToken}) async {
    final path = 'data/$category/10/$pageSize';
    try {
      Response response = await dio.get(path, cancelToken: cancelToken);
      if(response.data['error'] == false) {
        final list = parseGankNews(response.data['results']);
        if(list.isEmpty) {
          errorHandler();
        } else {
          successHandler(list);
        }
      } else {
        errorHandler();
      }
    } on DioError catch(e) {
      if(!CancelToken.isCancel(e)) {
        errorHandler();
      }
    }
    return null;
  }
}