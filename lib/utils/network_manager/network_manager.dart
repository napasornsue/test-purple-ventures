import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:test_purple_ventures/values/app_config.dart';
import 'package:test_purple_ventures/values/app_string.dart';

class NetworkManager {
  NetworkManager();

  Future<dynamic> get({required String endPoint, dynamic params}) async {
    return http.get(Uri.parse(AppConfig.SERVICE_ENDPOINT + endPoint).replace(queryParameters: params)).then((response) {
      if (AppConfig.IS_DEBUG_MODE) {
        print("############  $endPoint ############ ");
        print("EndPoint is ${Uri.parse(AppConfig.SERVICE_ENDPOINT + endPoint).replace(queryParameters: params).toString()}");
        print("Method : GET");
        print("Body : ${params.toString()}");
        print(
            "\n curl --location -g --request GET '${Uri.parse(AppConfig.SERVICE_ENDPOINT + endPoint).replace(queryParameters: params).toString()}'");
        print("Response : ${response.body.toString()}");
        print("################################################");
      }

      if (response.body.isEmpty) {
        throw Exception(_checkErrorType(""));
      }

      return response;
    }).timeout(const Duration(seconds: 60), onTimeout: () async {
      throw await _checkErrorType(ErrorType.timeout);
    }).onError((error, stackTrace) async {
      throw await _checkErrorType(ErrorType.internet);
    });
  }

  _checkErrorType(Object? error) async {
    if (error is ErrorType) {
      if (error == ErrorType.internet) {
        return AppString.ERROR_INTERNET;
      } else if (error == ErrorType.timeout) {
        if (await _checkInternetConnection()) {
          return AppString.ERROR_SERVER;
        } else {
          return AppString.ERROR_INTERNET;
        }
      }
    }
    return AppString.ERROR_DEFAULT;
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final Connectivity connectivity = Connectivity();
      ConnectivityResult result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

enum ErrorType { internet, timeout, server }