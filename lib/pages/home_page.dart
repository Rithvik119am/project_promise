import 'package:flutter/material.dart';
import 'package:project_promise/pages/take_order/take_order.dart';
import 'package:project_promise/pages/view_order/view_order.dart';
import 'package:project_promise/pages/measurement_sheet/measurement_taker.dart';
import 'package:project_promise/groups/authenticate.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            final AuthAPI appwrite = context.read<AuthAPI>();
            appwrite.signOut();
          },
        ),
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
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius here
                ),
                minimumSize: const Size(400, 100), // Adjust button size here
              ),
              child: const Text('Take Order',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 255, 0, 0))),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewOrderPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius here
                ),
                minimumSize: const Size(400, 100), // Adjust button size here
              ),
              child: const Text('View Order',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 255, 0, 0))),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MeasurementSheet()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius here
                ),
                minimumSize: const Size(400, 100), // Adjust button size here
              ),
              child: const Text('Measurement Sheet',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 255, 0, 0))),
            ),
          ],
        ),
      ),
    );
  }
}
