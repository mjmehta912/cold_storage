import 'dart:typed_data';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/pdf_screen.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/model/res/account_ledger_detail_res_model.dart';

Future<void> generateAndOpenAccountLedgerPDF(
  AccountLedgerDetailResModel accountLedgerDetails,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        List<pw.Widget> content = [];

        // Add Account Title
        content.add(
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#BBB2CC'),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Text(
              "Account Ledger Report",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        );

        content.add(pw.SizedBox(height: 10));

        // Opening Balance
        content.add(
          pw.Text(
            "Opening Balance: ${accountLedgerDetails.opening ?? '0'}",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        );

        content.add(pw.SizedBox(height: 10));

        // Table Headers
        content.add(
          pw.Table.fromTextArray(
            headers: [
              'Date',
              'Doc No',
              'Narration',
              'Book',
              'Debit',
              'Credit',
              'Balance'
            ],
            data: accountLedgerDetails.data != null
                ? accountLedgerDetails.data!
                    .map<List<dynamic>>((entry) => [
                          entry.date ?? '',
                          entry.docno ?? '',
                          entry.narration ?? '',
                          entry.book ?? '',
                          entry.debit ?? '0',
                          entry.credit ?? '0',
                          entry.balance ?? '0',
                        ])
                    .toList()
                : [],
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.center,
            cellPadding: const pw.EdgeInsets.all(5),
          ),
        );

        content.add(pw.SizedBox(height: 20));

        content.add(
          pw.Text(
            "Debit: ${accountLedgerDetails.debit ?? '0'}",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        );
        content.add(
          pw.Text(
            "Credit: ${accountLedgerDetails.credit ?? '0'}",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        );

        // Closing Balance
        content.add(
          pw.Text(
            "Closing Balance: ${accountLedgerDetails.closing ?? '0'}",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        );

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
    Get.to(
      () => PdfScreen(
        pdfBytes: pdfBytes,
        title: 'Account Ledger Report',
      ),
    );
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to generate PDF: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
