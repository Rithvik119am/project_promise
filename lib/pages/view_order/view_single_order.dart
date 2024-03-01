import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';

Widget buildRow(String label, String value) {
  //value = value.padRight(15 - value.length, ' ');
  //print(value + "123");
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 18),
      ),
    ],
  );
}

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
                            buildRow('Name: ', order.customer.name),
                            buildRow(
                                'Mobile Number: ', order.customer.mobileNumber),
                            buildRow('Address: ', order.customer.address),
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
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: buildRow('Number of Granite Types: ',
                            order.numberOfGraniteTypes.toString())),
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
                                    buildRow(
                                        'Granite Name: ', graniteOrder.name),
                                    buildRow('Number of Slabs: ',
                                        graniteOrder.numberOfSlabs.toString()),
                                    buildRow('Square Feet: ',
                                        graniteOrder.squareFeet.toString()),
                                    buildRow('Per Square Feet: ',
                                        graniteOrder.perSqurare.toString()),
                                    buildRow('Per Granite price: ',
                                        graniteOrder.price.toString()),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    Card(
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Other Costs:',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            buildRow('GST: ', '${order.gst}%'),
                            const SizedBox(height: 10),
                            buildRow(
                                'Transportation: ', '₹ ${order.transpotatio}'),
                            const SizedBox(height: 10),
                            buildRow('Loading and Unloading: ',
                                '₹ ${order.loadAndUnload}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Total Value: ',
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
