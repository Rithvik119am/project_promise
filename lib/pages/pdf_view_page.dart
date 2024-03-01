import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:project_promise/groups/pdf_creater.dart';

class PdfPageForView extends StatelessWidget {
  const PdfPageForView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Page For View'),
      ),
      body: PdfPreview(
        build: (context) => makePdf("this is Rithvik's invoice"),
      ),
    );
  }
}
