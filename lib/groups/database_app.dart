// ignore_for_file: non_constant_identifier_names

import 'package:appwrite/appwrite.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/constants.dart';

Future<int> getBillNo() async {
  final client = Client().setEndpoint(API_END_POINT).setProject(PROJECT_ID);
  final databases = Databases(client);
  int billNo = -1;
  try {
    final response = await databases.listDocuments(
      databaseId: DATABASE_ID,
      collectionId: BILL_NO,
    );
    billNo = response.documents[0].data['Bill_no'];
  } catch (e) {
    print("Error in fetching data from database: $e");
  }
  return billNo;
}

Future<void> incrementBillNo(int billNo) async {
  final client = Client().setEndpoint(API_END_POINT).setProject(PROJECT_ID);
  final databases = Databases(client);
  try {
    final response = await databases.updateDocument(
      databaseId: DATABASE_ID,
      collectionId: BILL_NO,
      documentId: '6603e99d6d2abf5b61ff',
      data: {
        'Bill_no': billNo + 1,
      },
    );
  } catch (e) {
    print("Error in fetching data from database: $e");
  }
}

String API_END_POINT = "https://cloud.appwrite.io/v1";
String PROJECT_ID = "project-promise";
String CUSTOMER_COLLECTION_ID = "65dca03db9e19fbf10ec";
String ORDER_COLLECTION_ID = "65dca17966a16db176f3";
String DATABASE_ID = "65dca00e73512a903fae";

Future<int> temp(Order dataa) async {
  final client = Client().setEndpoint(API_END_POINT).setProject(PROJECT_ID);
  final databases = Databases(client);

  try {
    int previousBillNo = await getBillNo();
    final customerDoc = await databases.createDocument(
      databaseId: DATABASE_ID,
      collectionId: CUSTOMER_COLLECTION_ID,
      documentId: (previousBillNo + 1).toString(),
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
    incrementBillNo(previousBillNo);
  } on AppwriteException catch (e) {
    print(e);
    return 1;
  }
  return 0;
}

void deleteOrderDatabase(String id) async {
  try {
    final client = Client().setEndpoint(API_END_POINT).setProject(PROJECT_ID);
    final databases = Databases(client);
    final response = await databases.deleteDocument(
        databaseId: DATABASE_ID,
        collectionId: CUSTOMER_COLLECTION_ID,
        documentId: id);
  } catch (e) {
    print("Error in deleting data from database: $e");
  }
}

Future<List<Order>> getDataDatabase(DateTime date) async {
  List<Order> orders = [];
  DateTime previousDate = DateTime(date.year, date.month, date.day);
  DateTime nextDate =
      DateTime(date.year, date.month, date.day).add(const Duration(days: 1));
  final client = Client().setEndpoint(API_END_POINT).setProject(PROJECT_ID);
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
