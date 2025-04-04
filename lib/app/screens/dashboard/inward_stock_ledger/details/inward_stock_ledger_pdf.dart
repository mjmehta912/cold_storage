import 'dart:typed_data';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/pdf_screen.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/res/inward_stock_ledger_details_res_model.dart';

Future<void> generateAndOpenInwardStockLedgerPDF(
  List<InwardStockLedgerData> inwardStockLedgerList,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        List<pw.Widget> content = [];

        for (var data in inwardStockLedgerList) {
          // Company Name Header
          content.add(
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#BBB2CC'),
                borderRadius: pw.BorderRadius.circular(10),
              ),
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: pw.Text(
                data.companyName ?? 'Company Name',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          );

          content.add(pw.SizedBox(height: 10));

          // Loop through inward items
          for (var item in data.inwardItemsDetail ?? []) {
            // Add Item Name Header (Spanning Full Width)
            content.add(
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                padding: const pw.EdgeInsets.all(8),
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                child: pw.Text(
                  item.itemName ?? 'Item Name',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            );

            // Main Table
            content.add(
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                headers: [
                  'Inward No.',
                  'Date',
                  'Opening Qty',
                  'Inward',
                  'Outward',
                  'Balance'
                ],
                data: item.inwardDetail != null
                    ? item.inwardDetail!
                        .map<List<dynamic>>((detail) => [
                              detail.inwno ?? '',
                              detail.idate ?? '',
                              detail.opqty ?? '0',
                              detail.iqty ?? '0',
                              detail.oqty ?? '0',
                              detail.bqty ?? '0',
                            ])
                        .toList()
                    : [],
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.center,
                cellPadding: const pw.EdgeInsets.all(5),
              ),
            );

            content.add(
              pw.SizedBox(
                height: 10,
              ),
            );

            // // Closing Stock
            // content.add(
            //   pw.Text(
            //     'Closing Stock: ${item.closingStock ?? '0'}',
            //     style: pw.TextStyle(
            //       fontSize: 14,
            //       fontWeight: pw.FontWeight.bold,
            //     ),
            //   ),
            // );

            // content.add(pw.Divider());
          }

          content.add(
            pw.SizedBox(
              height: 20,
            ),
          );
        }

        return content;
      },
      footer: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Page ${context.pageNumber}',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        );
      },
    ),
  );

  try {
    // Convert PDF to Uint8List
    Uint8List pdfBytes = await pdf.save();

    // Navigate to PDF viewer screen
    Get.to(() => PdfScreen(
          pdfBytes: pdfBytes,
          title: 'Inward Stock Ledger',
        ));
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to generate PDF: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
