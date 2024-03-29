import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_promise/pages/take_order/take_order.dart';
import 'package:project_promise/pages/view_order/view_order.dart';
import 'package:project_promise/pages/measurement_sheet/measurement_taker.dart';
import 'package:project_promise/groups/authenticate.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
        title: const Text(
          '',
        ),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 30, top: 20),
          hoverColor: Colors.transparent,
          icon: const Icon(
            Icons.logout,
            color: Color.fromARGB(255, 0, 0, 0),
            size: 40,
          ),
          onPressed: () {
            final AuthAPI appwrite = context.read<AuthAPI>();
            appwrite.signOut();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: kToolbarHeight + 20, // Adjust top padding for app bar
                  bottom: 29.0, // Add padding here to move buttons up
                ),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakeOrderPage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(320, 170),
                      ),
                      child: const Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewOrderPage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(320, 170),
                      ),
                      child: const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeasurementSheet(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(320, 170),
                      ),
                      child: const Text(
                        'Measurement Sheet',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
