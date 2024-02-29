import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/database_app.dart';

class ViewOrderPage extends StatefulWidget {
  const ViewOrderPage({super.key});

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  bool isLoading = false;
  List<Order> data = [];

  Future<void> fetchData(DateTime selectedDate) async {
    setState(() {
      isLoading = true;
    });
    final response = await getDataDatabase(selectedDate);

    setState(() {
      data = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Order'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    fetchData(selectedDate);
                  }
                });
              },
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const CircularProgressIndicator()
            else if (data.isEmpty)
              const Text('No data found')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Text(data[index].customer.name),
                        title:
                            Text(data[index].customer.mobileNumber.toString()),
                        trailing: Text(data[index].totalAmount.toString()),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
