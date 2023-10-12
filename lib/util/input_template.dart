import 'package:flutter/material.dart';

class InputTemplate extends StatefulWidget {
  const InputTemplate({Key? key}) : super(key: key);

  @override
  InputTemplateState createState() => InputTemplateState();
}

class InputTemplateState extends State<InputTemplate> {
  final TextEditingController rockNameController = TextEditingController();
  final TextEditingController squareFeetContoller = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();

  Map<String, String> getInputData() {
    final String name = rockNameController.text;
    final String address = squareFeetContoller.text;
    final String mobileNumber = unitPriceController.text;

    return {
      'rockName': name,
      'squareFeet': address,
      'unitPrice': mobileNumber,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: rockNameController,
            decoration: const InputDecoration(
              labelText: 'Enter the Rock name',
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: squareFeetContoller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Enter the Square Feet',
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  controller: unitPriceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Enter the Price per Square Foot',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}