import 'package:flutter/material.dart';
import 'package:project_promise/pages/order_final_page.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/granite.dart';

class TakeDetailsPage extends StatefulWidget {
  const TakeDetailsPage({Key? key, required this.customerInfo})
      : super(key: key);

  final Customer customerInfo;
  @override
  TakeDetailsPageState createState() => TakeDetailsPageState();
}

class TakeDetailsPageState extends State<TakeDetailsPage> {
  int _inputNumber = 0;
  late List<GraniteOrder> graniteOrders;
  late List<String> graniteType;

  @override
  void initState() {
    super.initState();
    graniteOrders = [];
    graniteType = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter the number of Granite Orders',
              ),
              onChanged: (value) {
                setState(() {
                  _inputNumber = int.tryParse(value) ?? 0;
                  graniteType = List.generate(_inputNumber, (index) => '');
                  graniteOrders = List.generate(
                    _inputNumber,
                    (index) => GraniteOrder(
                      name: '',
                      numberOfSlabs: 0,
                      dimensions: [],
                      squareFeet: 0.0,
                    ),
                  );
                });
              },
            ),
            if (_inputNumber > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: _inputNumber,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Granite Type ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                graniteOrders[index].name = value;
                              });
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Number of Slabs',
                            ),
                            onChanged: (value) {
                              setState(() {
                                graniteOrders[index].numberOfSlabs =
                                    int.tryParse(value) ?? 0;
                                graniteOrders[index].dimensions = List.generate(
                                  graniteOrders[index].numberOfSlabs,
                                  (_) => Pair(0.0, 0.0),
                                );
                              });
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'PerSquare feet',
                            ),
                            onChanged: (value) {
                              setState(() {
                                graniteOrders[index].perSqurare =
                                    double.tryParse(value) ?? 0.0;
                              });
                            },
                          ),
                          for (int i = 0;
                              i < graniteOrders[index].numberOfSlabs;
                              i++)
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Length',
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        graniteOrders[index]
                                                .dimensions[i]
                                                .first =
                                            double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Width',
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        graniteOrders[index]
                                                .dimensions[i]
                                                .second =
                                            double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () {
                for (int temp = 0; temp < _inputNumber; temp++) {
                  graniteOrders[temp].calculateSquareFeet();
                  graniteOrders[temp].calculatePrice();
                }
                Order orderFullInfo = Order(
                    customer: widget.customerInfo,
                    numberOfGraniteTypes: _inputNumber,
                    graniteOrders: graniteOrders);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(order: orderFullInfo),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
