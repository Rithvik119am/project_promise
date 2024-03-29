import 'package:flutter/material.dart';
import 'package:project_promise/pages/view_order/view_single_order.dart';
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
  DateTime? previourRequestDate;

  Future<void> fetchData(DateTime selectedDate) async {
    setState(() {
      isLoading = true;
    });
    previourRequestDate = selectedDate;
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
            /*
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
            ),*/
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewSingleOrderPage(
                                  order: data[index], index: index),
                            ),
                          ).then(
                            (value) {
                              if (value != null) {
                                setState(() {
                                  data.removeAt(index);
                                });
                              }
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Name: ',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: data[index].customer.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Order Value: ',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text:
                                            '₹ ${data[index].totalAmount.toString()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Mobile Number: ',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: data[index]
                                            .customer
                                            .mobileNumber
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 70,
        child: FloatingActionButton(
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
          backgroundColor: const Color.fromARGB(255, 167, 106, 207),
          child: const Icon(Icons.date_range, size: 40),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
