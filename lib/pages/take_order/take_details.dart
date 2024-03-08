import 'package:flutter/material.dart';
import 'package:project_promise/pages/take_order/order_final_page.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/granite.dart';

class TakeDetailsPage extends StatefulWidget {
  const TakeDetailsPage({super.key, required this.customerInfo});

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
                  if (_inputNumber > graniteOrders.length) {
                    graniteOrders.addAll(
                      List.generate(
                        _inputNumber - graniteOrders.length,
                        (index) => GraniteOrder(
                          name: '',
                          numberOfSlabs: 0,
                          squareFeet: 0.0,
                        ),
                      ),
                    );
                  } else {
                    graniteOrders.removeRange(
                        _inputNumber, graniteOrders.length);
                  }
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
                          DropdownButton<String>(
                            hint: const Text('Select Granite Type'),
                            value: graniteType[index],
                            items: <String>[
                              'Black Galaxy',
                              'Nano White',
                              'Tan Brown',
                              'Z-Black',
                              'Black Pearl',
                              'Artificial Box',
                              'Maha Ghani',
                              'Cell White',
                              'Bose Pradise',
                              'Fish Black',
                              'Tan Brown Lapothra',
                              'Cell White Flemming',
                              // ... many more to come
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                graniteType[index] = value!;
                                graniteOrders[index].name = value;
                          /*TextField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                graniteOrders[index].name = value;
                              });
                            },
                          ),*/
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Number of Slabs',
                            ),
                            onChanged: (value) {
                              setState(() {
                                graniteOrders[index].numberOfSlabs =
                                    int.tryParse(value) ?? 0;
                              });
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Square Feet',
                            ),
                            onChanged: (value) {
                              setState(() {
                                graniteOrders[index].squareFeet =
                                    double.tryParse(value) ?? 0.0;
                              });
                            },
                          ),
                          // ignore: prefer_const_constructors
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'PerSquare feet',
                            ),
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
