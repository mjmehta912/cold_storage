import 'dart:typed_data';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/pdf_screen.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/model/res/stock_summary_details_res_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateAndOpenStockSummaryPDF(
  List<StockSummaryDetailData> stockSummaryDataList,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        List<pw.Widget> content = [];

        for (var data in stockSummaryDataList) {
          content.add(
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#CB9CA3'),
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
          );

          content.add(pw.SizedBox(height: 10));

          content.add(
            // ignore: deprecated_member_use
            pw.Table.fromTextArray(
              headers: [
                'Item',
                'Opening Qty',
                'Inward Qty',
                'Outward Qty',
                'Balance Qty',
              ],
              data: data.itemData
                      ?.map<List<String>>(
                        (item) => [
                          item.itemName ?? '',
                          item.opqty ?? '0',
                          item.iqty ?? '0',
                          item.oqty ?? '0',
                          item.bqty ?? '0',
                        ],
                      )
                      .toList() ??
                  [],
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.center,
              cellPadding: const pw.EdgeInsets.all(5),
            ),
          );

          content.add(pw.SizedBox(height: 20));
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
    Uint8List pdfBytes = await pdf.save();

    Get.to(() => PdfScreen(
          pdfBytes: pdfBytes,
          title: 'Stock Summary',
        ));
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to generate PDF: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
