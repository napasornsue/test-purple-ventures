import 'dart:convert';
import 'package:test_purple_ventures/models/response/task/task_response.dart';
import 'package:test_purple_ventures/utils/network_manager/network_endpoints.dart';
import 'package:test_purple_ventures/utils/network_manager/network_manager.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

class BaseRepository {
  late NetworkManager _http;

  BaseRepository() {
    _http = AppDependency.instance.get<NetworkManager>();
  }

  Future<NetworkResponse<TaskResponse>>? getTodoList({
    required int offset,
    required int limit,
    required String sortBy,
    required bool isAsc,
    required String status
  }) {
    var params = {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "sortBy": sortBy,
      "isAsc": isAsc.toString(),
      "status": status,
    };
    return _http.get(endPoint: NetworkEndpoints.TODO_LIST, params: params).then((response) {
      try {
        final _response = TaskResponse.fromJson(jsonDecode(response.body));
        return NetworkResponse(httpResponse: response, response: _response);
      } on Exception catch (_) {
        throw Exception(response.statusCode);
      }
    });
  }

}