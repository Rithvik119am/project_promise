import 'package:flutter/material.dart';
import 'package:project_promise/pages/take_order/take_details.dart';
import 'package:project_promise/groups/customer.dart';

class TakeOrderPage extends StatelessWidget {
  Customer customer =
      Customer(name: '', mobileNumber: '', address: '', date: DateTime.now());
  TakeOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Take Order',
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 350.0,
          height: 400.0,
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  labelText: 'Enter the name',
                ),
                onChanged: (value) => customer.name = value,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  labelText: 'Enter the address',
                ),
                onChanged: (value) => customer.address = value,
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  labelText: 'Enter the Mobile Number',
                ),
                onChanged: (value) => customer.mobileNumber = value,
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    if (value != null) {
                      customer.date = value;
                    }
                  });
                },
                child: Text(
                  'Date: ${customer.date.day}/${customer.date.month}/${customer.date.year}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 207, 175, 68),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TakeDetailsPage(
                        customerInfo: customer,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Submit',
                  selectionColor: Color.fromARGB(255, 216, 22, 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
