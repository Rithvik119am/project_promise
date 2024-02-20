import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';

class OrderPage extends StatelessWidget {
  final Order order;

  const OrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Name: ${order.customer.name}'),
            Text('Mobile Number: ${order.customer.mobileNumber}'),
            Text('Address: ${order.customer.address}'),
            const SizedBox(height: 20),
            const Text(
              'Granite Order Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Number of Granite Types: ${order.numberOfGraniteTypes}'),
            if (order.graniteOrders != null && order.graniteOrders!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: order.graniteOrders!.map((graniteOrder) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Granite Name: ${graniteOrder.name}'),
                      Text('Number of Slabs: ${graniteOrder.numberOfSlabs}'),
                      Text('Square Feet: ${graniteOrder.squareFeet}'),
                      Text('Per Square Feet: ${graniteOrder.perSqurare}'),
                      Text('Per Granate price: ${graniteOrder.price}'),
                    ],
                  );
                }).toList(),
              ),
            Expanded(
              child: Center(
                child: Text(
                  'Value: ₹ ${order.calculatTotalAmount()}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Button action
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
