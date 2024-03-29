import 'dart:convert';
import 'dart:io';
import 'package:project_promise/groups/customer.dart';

Future<int> sendData(Order order) async {
  String url =
      'https://script.google.com/macros/s/AKfycbwnLCIrd_NGg27ksBVv1b0_kWfLT-DAjXcCLmpZx_gulgsVlBn25I3MY54Sd2bYXeb1Zg/exec';
  //https://script.google.com/macros/s/AKfycbwnLCIrd_NGg27ksBVv1b0_kWfLT-DAjXcCLmpZx_gulgsVlBn25I3MY54Sd2bYXeb1Zg/exec
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

  String jsonOrder = json.encode(order.toJson());
  request.headers.set('content-type', 'application/json; charset=UTF-8');

  request.add(utf8.encode(jsonOrder));

  HttpClientResponse response = await request.close();
  httpClient.close();
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return 0;
  } else {
    return response.statusCode;
  }
}
