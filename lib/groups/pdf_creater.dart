// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:project_promise/groups/customer.dart';
import 'package:project_promise/groups/granite.dart';
import 'package:project_promise/groups/owner_info.dart';
import 'package:intl/intl.dart' as intl;

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
  // final image = await imageDocument();
  final pdf = Document();
  pdf.addPage(
    Page(build: (context) {
      return Column(children: [
        //Image(image),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            OwnerInfo().name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mobile Number: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(OwnerInfo().mobileNumber,
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          SizedBox(width: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text('ID: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(data.id ?? 'None', style: const TextStyle(fontSize: 12)),
            ]),
            SizedBox(width: 20),
            Row(children: [
              Text('Date: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(
                intl.DateFormat('dd-MM-yyyy').format(data.customer.date),
                style: const TextStyle(fontSize: 12),
              ),
            ]),
          ]),
          Divider(
            height: 20,
            thickness: 2,
          ),
          Text(
            'Customer Details:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name: ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(data.customer.name, style: const TextStyle(fontSize: 15)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mobile Number: ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(data.customer.mobileNumber,
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Address: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(data.customer.address, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ]),
        SizedBox(height: 10),
        Table(
          defaultColumnWidth: const FlexColumnWidth(1.0),
          border: TableBorder.all(),
          children: [
            TableRow(
              // Add this line
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Item Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('SquareFeet',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Unit Price',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Item Total(Rs)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
            for (var item in data.graniteOrders!)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.name, style: const TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.squareFeet.toString(),
                      style: const TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.perSqurare.toString(),
                      style: const TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.price.toString(),
                      style: const TextStyle(fontSize: 15)),
                ),
              ]),
          ],
        ),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text('Granite Amount: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text("Rs ${data.calculatTotalAmountNoneExtra()}",
              style: const TextStyle(fontSize: 15)),
        ]),
        SizedBox(height: 10),
        Table(
          defaultColumnWidth: const FlexColumnWidth(1.0),
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Description',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Amount',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('GST: ${data.gst} %',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rs ${data.gst * data.totalAmount / 100}",
                    style: const TextStyle(fontSize: 15)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Loading and Unloading: ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rs ${data.loadAndUnload}",
                    style: const TextStyle(fontSize: 15)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Transportion: ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rs ${data.transpotation}",
                    style: const TextStyle(fontSize: 15)),
              ),
            ]),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Total Amount: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text("Rs ${data.calculatTotalAmountGst()}",
                style: const TextStyle(fontSize: 15)),
          ],
        )
      ]);
    }),
  );
  return await pdf.save();
}

Future<Uint8List> makePdfMesurementSheets(List<GraniteOrder> data) async {
  final pdf = Document();
  pdf.addPage(
    MultiPage(
      build: (context) => [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text('Date: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0)),
          Text(intl.DateFormat('dd-MM-yyyy').format(DateTime.now()))
        ]),
        for (var item in data)
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Granite Name: ${item.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            //print a table with sno, lengthXwidth, pair.squarefeet as coloum names
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sno',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Length X Width',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('SquareFeet',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ],
                ),
                for (int i = 0; i < item.numberOfSlabs; i++)
                  TableRow(children: [
                    Text((i + 1).toString(),
                        style: const TextStyle(fontSize: 15)),
                    Text(
                        '${item.dimensions![i].first} X ${item.dimensions![i].second}',
                        style: const TextStyle(fontSize: 15)),
                    Text(item.dimensions![i].squareFeet().toStringAsFixed(2),
                        style: const TextStyle(fontSize: 15)),
                  ]),
                TableRow(children: [
                  Text('', style: const TextStyle(fontSize: 15)),
                  Text('Total SquareFeet',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(item.squareFeet.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 15)),
                ]),
              ],
            ),
          ])
      ], /////////
    ),
  );
  return await pdf.save();
}
