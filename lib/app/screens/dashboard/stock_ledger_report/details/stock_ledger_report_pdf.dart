import 'dart:typed_data';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/pdf_screen.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/model/stock_ledger_report_res_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateAndOpenStockLedgerPDF(
  List<StockLedgerReportData> stockLedgerReportDataList,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        List<pw.Widget> content = [];

        for (var companyData in stockLedgerReportDataList) {
          content.add(
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#9CCBC9'),
                borderRadius: pw.BorderRadius.circular(10),
              ),
              padding: const pw.EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: pw.Text(
                companyData.companyName ?? 'Company Name',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          );

          content.add(pw.SizedBox(height: 10));

          for (var stockItem in companyData.stockItems ?? []) {
            content.add(
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                padding: const pw.EdgeInsets.all(8),
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                child: pw.Text(
                  stockItem.itemName ?? 'Item Name',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            );

            List<List<dynamic>> tableData = [];

            for (var itemStockDetail in stockItem.itemStockDetails ?? []) {
              tableData.add([
                itemStockDetail.inwno ?? '',
                itemStockDetail.idate ?? '',
                itemStockDetail.iqty ?? '0',
                '',
                '',
                '',
                '',
              ]);

              if (itemStockDetail.outwardList != null) {
                for (var outward in itemStockDetail.outwardList!) {
                  tableData.add([
                    '',
                    '',
                    '',
                    outward.outno ?? '',
                    outward.odate ?? '',
                    outward.oqty ?? '0',
                    outward.bqty ?? '0',
                  ]);
                }
              }
            }

            content.add(
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                headers: [
                  'I/W No.',
                  'I/W Date',
                  'I/W Qty',
                  'O/W No.',
                  'O/W Date',
                  'O/W Qty',
                  'BAL'
                ],
                data: tableData,
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.center,
                cellPadding: const pw.EdgeInsets.all(5),
              ),
            );

            content.add(pw.SizedBox(height: 10));
            content.add(pw.Divider());
          }

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
          title: 'Stock Ledger Report',
        ));
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to generate PDF: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
