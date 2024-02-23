import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';

class GstTranspartPage extends StatefulWidget {
  const GstTranspartPage({super.key, required this.order});
  final Order order;
  @override
  GstTranspartPageState createState() => GstTranspartPageState();
}

class GstTranspartPageState extends State<GstTranspartPage> {
  double gstPercentage = 0.0;
  double transpotationCost = 0.0;
  double loadCost = 0.0;
  double unloadCost = 0.0;
  double totalCost = 0.0;

  void calculateTotalCost() {
    totalCost = 0.0;
    totalCost = widget.order.totalAmount +
        widget.order.totalAmount * gstPercentage / 100 +
        transpotationCost +
        loadCost +
        unloadCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST and Transpotation Page'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('GST (%):', style: TextStyle(fontSize: 18)),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  gstPercentage = double.tryParse(value) ?? 0.0;
                  setState(() {
                    calculateTotalCost();
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('Transportation Cost:',
                  style: TextStyle(fontSize: 18)),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  transpotationCost = double.tryParse(value) ?? 0.0;
                  setState(() {
                    calculateTotalCost();
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('Load Cost:', style: TextStyle(fontSize: 18)),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  loadCost = double.tryParse(value) ?? 0.0;
                  setState(() {
                    calculateTotalCost();
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('Unload Cost:', style: TextStyle(fontSize: 18)),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  unloadCost = double.tryParse(value) ?? 0.0;
                  setState(() {
                    calculateTotalCost();
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text(
                  'Total Cost: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹ $totalCost',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                )
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Create PDF'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>,
                          //   ),
                          // );
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
