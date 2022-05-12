import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

Future<HttpClientResponse?> RaiseRequest(String method,Uri uri) async {
  var httpClient = HttpClient();
  late HttpClientRequest request;
  if(method == "get") {
    request = await httpClient.getUrl(uri);
  } else if (method == "post") {
    request = await httpClient.postUrl(uri);
  } else if (method == "put") {
    request = await httpClient.putUrl(uri);
  } else if (method == "delete") {
    request = await httpClient.deleteUrl(uri);
  } else {
    developer.log(
      "Request Type Error, Request Method : " + method,
      time: DateTime.now(),
      stackTrace: StackTrace.current
      );
    return null;
  }
  var response = await request.close();
  return response;
}