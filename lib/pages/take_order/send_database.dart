import 'package:flutter/material.dart';
import 'package:project_promise/groups/customer.dart';
//import 'package:project_promise/groups/database.dart';
import 'package:project_promise/pages/pdf_view_page.dart';
import 'package:project_promise/groups/database_app.dart';

class SendDatabasePage extends StatefulWidget {
  final Order order;

  const SendDatabasePage({super.key, required this.order});

  @override
  _SendDatabasePageState createState() => _SendDatabasePageState();
}

class _SendDatabasePageState extends State<SendDatabasePage> {
  late Future<int> futureData;

  @override
  void initState() {
    super.initState();
    futureData = temp(widget.order);
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
              if (snapshot.data == 1) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Card(
                        color: Color.fromARGB(255, 158, 63, 19),
                        elevation: 10,
                        margin: EdgeInsets.all(20),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Data not sent',
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
                          setState(() {
                            futureData = temp(widget.order);
                          });
                        },
                        child: const Text('Tryagain'),
                      ),
                    ],
                  ),
                );
              }
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
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PdfPageForView(order: widget.order),
                          ),
                        );
                      },
                      child: const Text('Create a PDF'),
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
