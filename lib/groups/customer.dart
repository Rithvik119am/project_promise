import 'package:project_promise/groups/granite.dart';

class Customer {
  String name;
  String mobileNumber;
  String address;

  Customer({
    required this.name,
    required this.mobileNumber,
    this.address = 'None',
  });

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

  // Method to convert JSON to Order object
}
