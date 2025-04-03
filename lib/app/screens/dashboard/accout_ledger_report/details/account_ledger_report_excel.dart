import 'dart:io';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/model/res/account_ledger_detail_res_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> generateAndOpenAccountLedgerExcel(
  AccountLedgerDetailResModel accountLedgerDetails,
) async {
  try {
    var excel = Excel.createExcel();
    Sheet sheet = excel[excel.getDefaultSheet()!];

    int rowIndex = 0;

    // **Styles for Formatting**
    CellStyle headerStyle = CellStyle(
      bold: true,
      fontSize: 12,
      horizontalAlign: HorizontalAlign.Center,
      backgroundColorHex: ExcelColor.fromHexString("#D3D3D3"),
    );

    CellStyle cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
      fontSize: 11,
    );

    CellStyle titleStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
      backgroundColorHex:
          ExcelColor.fromHexString("#BBB2CC"), // Matching PDF color
    );

    // **Account Ledger Title**
    var titleCell = sheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
    );
    titleCell.value = TextCellValue("Account Ledger Report");
    titleCell.cellStyle = titleStyle;

    // Merge title across 7 columns
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
      CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex),
    );

    rowIndex += 2; // Extra spacing

    // **Opening Balance**
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex))
      ..value = TextCellValue("Opening Balance:")
      ..cellStyle = headerStyle;

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
      ..value = TextCellValue(accountLedgerDetails.opening ?? '0')
      ..cellStyle = cellStyle;

    rowIndex += 2; // Move to next section

    // **Table Headers**
    List<String> headers = [
      "Date",
      "Doc No",
      "Narration",
      "Book",
      "Debit",
      "Credit",
      "Balance"
    ];

    for (int col = 0; col < headers.length; col++) {
      var headerCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
      );
      headerCell.value = TextCellValue(headers[col]);
      headerCell.cellStyle = headerStyle;
    }

    rowIndex++; // Move to the next row

    // **Ledger Entries**
    if (accountLedgerDetails.data != null) {
      for (var entry in accountLedgerDetails.data!) {
        List<String> rowData = [
          entry.date ?? '',
          entry.docno ?? '',
          entry.narration ?? '',
          entry.book ?? '',
          entry.debit ?? '0',
          entry.credit ?? '0',
          entry.balance ?? '0',
        ];

        for (int col = 0; col < rowData.length; col++) {
          var cell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
          );
          cell.value = TextCellValue(rowData[col]);
          cell.cellStyle = cellStyle;
        }

        rowIndex++; // Move to next row
      }
    }

    rowIndex += 2; // Extra spacing before totals

    // **Total Debit**
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex))
      ..value = TextCellValue("Total Debit:")
      ..cellStyle = headerStyle;

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex))
      ..value = TextCellValue(accountLedgerDetails.debit ?? '0')
      ..cellStyle = cellStyle;

    rowIndex++;

    // **Total Credit**
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex))
      ..value = TextCellValue("Total Credit:")
      ..cellStyle = headerStyle;

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex))
      ..value = TextCellValue(accountLedgerDetails.credit ?? '0')
      ..cellStyle = cellStyle;

    rowIndex += 2; // Move to closing balance

    // **Closing Balance**
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex))
      ..value = TextCellValue("Closing Balance:")
      ..cellStyle = headerStyle;

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex))
      ..value = TextCellValue(accountLedgerDetails.closing ?? '0')
      ..cellStyle = cellStyle;

    // **Save the Excel file in a temporary directory**
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/Account_Ledger_Report.xlsx';
    final File file = File(filePath)..writeAsBytesSync(excel.save()!);

    // **Open the file in an external app**
    await OpenFilex.open(file.path);
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to generate Excel file: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
