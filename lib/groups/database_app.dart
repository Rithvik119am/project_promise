// ignore_for_file: non_constant_identifier_names

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project_promise/groups/customer.dart';

Future<int> temp(Order dataa) async {
  final client = Client()
      .setEndpoint(API_END_POINT)
      .setProject(PROJECT_ID)
      .setSelfSigned(status: true);
  final databases = Databases(client);

  try {
    final customerDoc = await databases.createDocument(
      databaseId: DATABASE_ID,
      collectionId: CUSTOMER_COLLECTION_ID,
      documentId: ID.unique(),
      data: dataa.toJsonCoustomers(),
    );
    List<String> orderIds = [];
    List<Map<String, dynamic>> eachGranite =
        dataa.toJsonOrders(customerDoc.$id);
    for (var i in eachGranite) {
      final orderDoc = await databases.createDocument(
        databaseId: DATABASE_ID,
        collectionId: ORDER_COLLECTION_ID,
        documentId: ID.unique(),
        data: i,
      );
      orderIds.add(orderDoc.$id);
    }
    final customer = await databases.updateDocument(
      databaseId: DATABASE_ID,
      collectionId: CUSTOMER_COLLECTION_ID,
      documentId: customerDoc.$id,
      data: {
        'graniteOrder': orderIds,
      },
    );
  } on AppwriteException catch (e) {
    print(e);
    return 1;
  }
  return 0;
}

Future<List<Order>> getDataDatabase(DateTime date) async {
  List<Order> orders = [];
  DateTime previousDate = DateTime(date.year, date.month, date.day);
  DateTime nextDate =
      DateTime(date.year, date.month, date.day).add(const Duration(days: 1));
  final client = Client()
      .setEndpoint(API_END_POINT)
      .setProject(PROJECT_ID)
      .setSelfSigned(status: true);
  final databases = Databases(client);
  try {
    final response = await databases.listDocuments(
        databaseId: DATABASE_ID,
        collectionId: CUSTOMER_COLLECTION_ID,
        queries: [
          Query.between(
              'order_date', previousDate.toString(), nextDate.toString())
        ]);
    for (var i in response.documents) {
      List<Map<String, dynamic>> graniteOrders = [];
      for (var j in i.data['graniteOrder']) {
        graniteOrders.add(j);
      }
      orders.add(Order.createOrderFromJson(i.toMap()['data'], graniteOrders));
    }
  } catch (e) {
    print("Error in fetching data from database: $e");
  }
  return orders;
}
