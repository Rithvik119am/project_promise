import 'package:flutter/material.dart';
import 'package:project_promise/pages/show_off.dart';
import 'package:project_promise/util/input_template.dart';

class TakeDetailsPage extends StatefulWidget {
  const TakeDetailsPage({Key? key, required this.customerInfo}) : super(key: key);

  final Map<String, String> customerInfo;
  @override
  TakeDetailsPageState createState() => TakeDetailsPageState();
}

class TakeDetailsPageState extends State<TakeDetailsPage> {
  int _inputNumber = 0;
  List<Widget> _containers = [];
  Map<String, String> get customerInfo => widget.customerInfo;
  List<GlobalKey<InputTemplateState>> _keyContainer=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter the input number',
              ),
              onChanged: (value) {
                setState(() {
                  _inputNumber = int.tryParse(value) ?? 0;
                  for(int i=0;i<_inputNumber;i++){
                    final GlobalKey<InputTemplateState> _inputKey = GlobalKey();
                    _keyContainer.add(_inputKey);
                    _containers.add(InputTemplate(key: _inputKey,),);
                  }
                  _containers.add(
                      ElevatedButton(
                          onPressed: () {
                            final List<Map<String, String>> dataForNext = [];
                            dataForNext.add(customerInfo);
                            for (int i = 0; i < _keyContainer.length; i++) {
                            final InputTemplateState inputTemplateState = _keyContainer[i].currentState!;
                            final Map<String, String> item = inputTemplateState.getInputData();
                              dataForNext.add(item);
                            }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowOffPage(
                                    allData:dataForNext,
                                  ),
                                ),
                              );
                            },
                        child: const Text('Submit'),
                      ),
                    );
                });
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: _containers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}