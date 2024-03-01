import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:project_promise/groups/customer.dart';

class PdfCreater {
  static Future<Uint8List> generateDocument() async {
    final pdf = Document();
    pdf.addPage(Page(
      build: (context) {
        return Center(
          child: Text('Hello World', textScaleFactor: 2),
        );
      },
    ));
    return pdf.save();
  }
}

Future<Uint8List> makePdf(String invoice) async {
  final pdf = Document();
  pdf.addPage(
    Page(build: (context) {
      return Column(children: [
        Text('Invoice'),
        Text(invoice),
      ]);
    }),
  );
  return await pdf.save();
}

Future<Uint8List> makePdfForOrder(Order data) async {
  final pdf = Document();
  pdf.addPage(
    Page(build: (context) {
      return Column(children: []);
    }),
  );
  return await pdf.save();
}
