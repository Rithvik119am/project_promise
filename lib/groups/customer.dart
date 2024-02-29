import 'package:project_promise/groups/granite.dart';

class Customer {
  String name;
  String mobileNumber;
  String address;
  DateTime date;

  Customer({
    required this.name,
    required this.mobileNumber,
    this.address = 'None',
    required this.date,
  });
  String get getDate {
    return date.toString();
  }

  @override
  String toString() {
    return 'Name: $name, Mobile Number: $mobileNumber, Address: $address';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobileNumber': mobileNumber,
      'address': address,
    };
  }
}

class Order {
  Customer customer;
  int numberOfGraniteTypes;
  List<GraniteOrder>? graniteOrders;
  double totalAmount = 0.0;
  double calculatTotalAmount() {
    totalAmount = 0.0;
    for (final g in graniteOrders!) {
      totalAmount += g.price;
    }
    return totalAmount;
  }

  Order({
    required this.customer,
    required this.numberOfGraniteTypes,
    this.graniteOrders,
  });
  Map<String, dynamic> toJson() {
    return {
      'customer': customer.toJson(),
      'numberOfGraniteTypes': numberOfGraniteTypes,
      'graniteOrders': graniteOrders?.map((order) => order.toJson()).toList(),
      'totalAmount': totalAmount,
      'some': graniteOrders?.length ?? 0
    };
  }

  List<Map<String, dynamic>> toJsonOrders(String id) {
    return graniteOrders!.map((order) => order.toJsonDatabase(id)).toList();
  }

  Map<String, dynamic> toJsonCoustomers() {
    return {
      'coustomer_name': customer.name,
      'Mobile_number': customer.mobileNumber,
      'Address': customer.address,
      "order_date": DateTime.now().toString(),
      "order_value": totalAmount,
    };
  }

  static Order createOrderFromJson(
      Map<String, dynamic> cusData, List<Map<String, dynamic>> graniteData) {
    final customer = Customer(
      name: cusData['coustomer_name'],
      mobileNumber: "",
      address: cusData['Address'],
      date: DateTime.parse(cusData['order_date']),
    );
    final graniteOrders =
        graniteData.map((data) => GraniteOrder.fromJsonDatabase(data)).toList();
    Order temp = Order(
      customer: customer,
      numberOfGraniteTypes: graniteOrders.length,
      graniteOrders: graniteOrders,
    );
    temp.totalAmount = (cusData['order_value'] as num).toDouble();
    return temp;
  }
}
