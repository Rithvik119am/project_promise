import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/pdf_creater.dart';
import 'package:project_promise/groups/database_app.dart';

class PdfPageForView extends StatelessWidget {
  final Order order;

  const PdfPageForView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Page For View'),
      ),
      body: PdfPreview(
        build: (context) => makePdfForOrder(order),
      ),
    );
  }
}
