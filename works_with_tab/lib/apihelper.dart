import 'dart:async';
import 'dart:convert';
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

Future<http.Response?> RaiseRequestPostObject(Uri uri, Object? object) async {
  var response = await http.post(
    uri,
    headers: {
        'content-type' : 'application/json',
        'Accept' : 'application/json'
    },
    body: object != null ? json.encode(object) : null,
    encoding: Encoding.getByName('utf-8')
  );
  return response;
}