import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/pages/take_order/send_database.dart';

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
  double totalCost = 0.0;

  void calculateTotalCost() {
    totalCost = 0.0;
    totalCost = widget.order.totalAmount +
        widget.order.totalAmount * gstPercentage / 100 +
        transpotationCost +
        loadCost;
  }

  @override
  Widget build(BuildContext context) {
    calculateTotalCost();
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST and Transpotation Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
            const Text('Transportation Cost:', style: TextStyle(fontSize: 18)),
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
            const Text('Loading and unloading code Cost:',
                style: TextStyle(fontSize: 18)),
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
                        widget.order.totalAmount = totalCost;
                        //generatePdf(widget.order);
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
                        widget.order.totalAmount = totalCost;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendDatabasePage(
                              order: widget.order,
                            ),
                          ),
                        );
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
