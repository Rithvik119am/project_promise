import 'package:flutter/material.dart';
import 'package:project_promise/pages/take_details.dart';
import 'package:project_promise/groups/customer.dart';

class TakeOrderPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  TakeOrderPage({Key? key}) : super(key: key);

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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  labelText: 'Enter the name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  labelText: 'Enter the address',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: numberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  labelText: 'Enter the Mobile Number',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 207, 175, 68),
                ),
                onPressed: () {
                  Customer customer = Customer(
                    name: nameController.text,
                    mobileNumber: numberController.text,
                    address: addressController.text,
                  );
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
