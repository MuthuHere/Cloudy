import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/network/urls.dart';
import 'package:weatherapp/utils/toast_message.dart';
import 'api_methods.dart';

///[ServiceProvider] is common class for api's
class ServiceProvider {
  ///base
  String _baseUrl = BASE_URL;

  ///log
  final String _tagRequest = ':::::::::::::: Request ::::::::::::::';
  final String _tagResponse = ':::::::::::::: Response ::::::::::::::';

  ServiceProvider();

  Future callWebService(
      {@required String path,
      Encoding encoding,
      @required ApiMethod method,
      Map<String, dynamic> body,
      Map<String, String> headers}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      AppMessage.toast('No Network Connection!');
      return null;
    }

    var responseData;
    final url = Uri.encodeFull(_baseUrl + path);
    debugPrint(' $_tagRequest  $method   $url');
    debugPrint(' $jsonEncode($body)');
    switch (method) {
      case ApiMethod.GET:
        {
          responseData = await http.get(
            url,
            headers: headers,
          );
        }
        break;

      case ApiMethod.POST:
        {
          responseData = await http.post(url,
              headers: {
                "Content-Type": "application/json",
              },
              body: json.encode(body));
        }
        break;
    }

    debugPrint(
        '$_tagResponse ${responseData.statusCode} - $url \n ${responseData.body}::::::::::::::');
    if (responseData.statusCode == 200) {
      return (responseData);
    } else {
      AppMessage.toast(
          'Response Code: ${responseData.statusCode}- Service Unavailable!');
      return null;
    }
  }
}
