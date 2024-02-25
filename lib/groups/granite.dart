// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'dart:convert';

class GraniteOrderForm extends StatefulWidget {
  const GraniteOrderForm({Key? key}) : super(key: key);

  @override
  _GraniteOrderFormState createState() => _GraniteOrderFormState();
}

class _GraniteOrderFormState extends State<GraniteOrderForm> {
  List<GraniteOrder> orders = [];

  void addOrder(GraniteOrder order) {
    setState(() {
      orders.add(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Add New Order'),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: GraniteOrderInputWidget(
                    onSubmit: (order) {
                      addOrder(order);
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                );
              },
            );
          },
        ),
        const Divider(),
        // Display existing orders here if needed
      ],
    );
  }
}

class GraniteOrderInputWidget extends StatefulWidget {
  final Function(GraniteOrder) onSubmit;

  const GraniteOrderInputWidget({Key? key, required this.onSubmit})
      : super(key: key);

  @override
  _GraniteOrderInputWidgetState createState() =>
      _GraniteOrderInputWidgetState();
}

class _GraniteOrderInputWidgetState extends State<GraniteOrderInputWidget> {
  late String name;
  late int numberOfSlabs;
  late List<Pair<double, double>> dimensions;

  @override
  void initState() {
    super.initState();
    numberOfSlabs = 1;
    dimensions = [Pair(0.0, 0.0)]; // Initialize with one pair of dimensions
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Number of Slabs'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              numberOfSlabs = int.parse(value);
              dimensions = List.generate(
                numberOfSlabs,
                (index) =>
                    Pair(0.0, 0.0), // Initialize dimensions for each slab
              );
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              0.6, // Adjust the height as needed
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < numberOfSlabs; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Dimensions for Slab ${i + 1}'),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration:
                                  const InputDecoration(labelText: 'Length'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  dimensions[i] = Pair(
                                    double.parse(value),
                                    dimensions[i].second,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration:
                                  const InputDecoration(labelText: 'Width'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  dimensions[i] = Pair(
                                    dimensions[i].first,
                                    double.parse(value),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            double totalSquareFeet = 0;
            for (final pair in dimensions) {
              totalSquareFeet += pair.first * pair.second;
            }
            final order = GraniteOrder(
              name: name,
              numberOfSlabs: numberOfSlabs,
              dimensions: dimensions,
              squareFeet: totalSquareFeet,
            );
            widget.onSubmit(order);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class GraniteOrder {
  String name;
  int numberOfSlabs;
  List<Pair<double, double>> dimensions;
  double squareFeet;
  double perSqurare = 0.0;
  double price = 0.0;

  GraniteOrder({
    required this.name,
    required this.numberOfSlabs,
    required this.dimensions,
    required this.squareFeet,
  });
  set setName(String newName) {
    name = newName;
  }

  void calculatePrice() {
    price = perSqurare * squareFeet;
  }

  void calculateSquareFeet() {
    squareFeet = 0.0;
    for (final pair in dimensions) {
      squareFeet += (pair.first * pair.second) / 144;
    }
  }

  String get dimensionsJson {
    return jsonEncode(dimensions
        .map((pair) => {'length': pair.first, 'width': pair.second})
        .toList());
  }

  set dimensionsJson(String json) {
    dimensions =
        (jsonDecode(json) as List<dynamic>).map<Pair<double, double>>((entry) {
      return Pair<double, double>(
          entry['length'] as double, entry['width'] as double);
    }).toList();
  }

  set setNumberOfSlabs(int newNumberOfSlabs) {
    numberOfSlabs = newNumberOfSlabs;
  }

  map(Map<String, dynamic> Function(dynamic graniteOrder) param0) {}

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberOfSlabs': numberOfSlabs,
      'dimensions': dimensionsJson,
      'squareFeet': squareFeet,
      'perSqurare': perSqurare,
      'price': price,
    };
  }
}

class Pair<T1, T2> {
  T1 first;
  T2 second;

  Pair(this.first, this.second);
}
