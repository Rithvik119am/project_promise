import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:project_promise/groups/granite.dart';
import 'package:project_promise/groups/pdf_creater.dart';
import 'package:project_promise/groups/database_app.dart';

class PdfPageForViewMeasurement extends StatelessWidget {
  final List<GraniteOrder> order;

  const PdfPageForViewMeasurement({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Page For View'),
      ),
      body: PdfPreview(
        build: (context) => makePdfMesurementSheets(order),
      ),
    );
  }
}
