import 'dart:convert';
import 'dart:io';
import 'package:project_promise/groups/customer.dart';

Future<int> sendData(Order order) async {
  // Implement the getOrder() function to get the Order object

  String url =
      'https://script.google.com/macros/s/AKfycbwnLCIrd_NGg27ksBVv1b0_kWfLT-DAjXcCLmpZx_gulgsVlBn25I3MY54Sd2bYXeb1Zg/exec';
  //https://script.google.com/macros/s/AKfycbwnLCIrd_NGg27ksBVv1b0_kWfLT-DAjXcCLmpZx_gulgsVlBn25I3MY54Sd2bYXeb1Zg/exec
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

  // Convert Order object to JSON
  String jsonOrder = json
      .encode(order.toJson()); // Implement toJson() method in your Order class

  // Set headers
  request.headers.set('content-type', 'application/json; charset=UTF-8');

  // Add JSON data to the request body
  request.add(utf8.encode(jsonOrder));

  // Send the request
  HttpClientResponse response = await request.close();
  httpClient.close();
  if (response.statusCode >= 200 && response.statusCode < 300) {
    // The request was successful
    return 0;
  } else {
    // The request failed
    return response.statusCode;
  }
  // Close the HttpClient
}
