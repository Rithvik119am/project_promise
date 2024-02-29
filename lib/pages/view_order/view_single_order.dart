import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';

class ViewSingleOrderPage extends StatelessWidget {
  final Order order;

  const ViewSingleOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Customer Details:',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Name: ${order.customer.name}',
                                style: const TextStyle(fontSize: 18)),
                            Text(
                                'Mobile Number: ${order.customer.mobileNumber}',
                                style: const TextStyle(fontSize: 18)),
                            Text('Address: ${order.customer.address}',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Granite Order Details:',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        'Number of Granite Types: ${order.numberOfGraniteTypes}',
                        style: const TextStyle(fontSize: 18)),
                    if (order.graniteOrders != null &&
                        order.graniteOrders!.isNotEmpty)
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              (order.graniteOrders ?? []).map((graniteOrder) {
                            return Card(
                              margin: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Granite Name: ${graniteOrder.name}',
                                        style: const TextStyle(fontSize: 18)),
                                    Text(
                                        'Number of Slabs: ${graniteOrder.numberOfSlabs}',
                                        style: const TextStyle(fontSize: 18)),
                                    Text(
                                        'Square Feet: ${graniteOrder.squareFeet}',
                                        style: const TextStyle(fontSize: 18)),
                                    Text(
                                        'Per Square Feet: ${graniteOrder.perSqurare}',
                                        style: const TextStyle(fontSize: 18)),
                                    Text(
                                        'Per Granite price: ${graniteOrder.price}',
                                        style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Value: ',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹ ${order.calculatTotalAmount()}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back to View Orders'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
