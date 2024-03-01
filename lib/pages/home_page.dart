import 'package:flutter/material.dart';
import 'package:project_promise/pages/take_order/take_order.dart';
import 'package:project_promise/pages/view_order/view_order.dart';
import 'package:project_promise/pages/pdf_view_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TakeOrderPage()),
                );
              },
              child: const Text('Take Order'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewOrderPage()),
                );
              },
              child: const Text('View Order'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PdfPageForView()),
                );
              },
              child: const Text('Pdf test'),
            ),
          ],
        ),
      ),
    );
  }
}
