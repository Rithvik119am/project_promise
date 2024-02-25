import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/database.dart';

class SendDatabasePage extends StatefulWidget {
  final Order order;

  const SendDatabasePage({super.key, required this.order});

  @override
  // ignore: library_private_types_in_public_api
  _SendDatabasePageState createState() => _SendDatabasePageState();
}

class _SendDatabasePageState extends State<SendDatabasePage> {
  late Future<int> futureData;

  @override
  void initState() {
    super.initState();
    futureData = sendData(widget.order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Database'),
      ),
      body: FutureBuilder<int>(
        future: futureData,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Container();
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Card(
                      color: Colors.green,
                      elevation: 10,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Data sent successfully',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('Go to Start Page'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
