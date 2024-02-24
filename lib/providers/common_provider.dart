import 'package:flutter/foundation.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';

class CommonProvider extends ChangeNotifier {
  Future<NewModel> fetchNews() {
    final snapshot = ApiService<NewModel>().build(
      weCanUrl: ApiUrl.news,
      isPublic: true,
      apiType: ApiType.get,
      builder: NewModel.fromJson,
    );
    return snapshot;
  }
}
