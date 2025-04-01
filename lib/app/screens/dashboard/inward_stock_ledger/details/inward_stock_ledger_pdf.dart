import 'dart:typed_data';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/pdf_screen.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/res/inward_stock_ledger_details_res_model.dart';

Future<void> generateAndOpenPDF(
    List<InwardStockLedgerData> inwardStockLedgerList) async {
  final pdf = pw.Document();

  for (var data in inwardStockLedgerList) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Company Name Header
              pw.Container(
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#BBB2CC'),
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                padding: const pw.EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: pw.Text(
                  data.companyName ?? 'Company Name',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              // Loop through each inward item
              for (var item in data.inwardItemsDetail ?? [])
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Table with Item Name as Header Row
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        // Item Name Header Row (Spanning all columns)
                        pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey300,
                          ),
                          children: [
                            pw.Container(
                              alignment: pw.Alignment.center,
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                item.itemName ?? 'Item Name',
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Main Table
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
                    pw.SizedBox(height: 10),

                    // Closing Stock
                    pw.Text(
                      'Closing Stock: ${item.closingStock ?? '0'}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Divider(),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  try {
    // Convert PDF to Uint8List
    Uint8List pdfBytes = await pdf.save();

    // Navigate to PDF viewer screen
    Get.to(() => LedgerPdfScreen(
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
