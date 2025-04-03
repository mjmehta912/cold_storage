import 'dart:io';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/model/res/stock_summary_details_res_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> generateAndOpenStockSummaryExcel(
  List<StockSummaryDetailData> stockSummaryDataList,
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

    CellStyle companyStyle = CellStyle(
      bold: true,
      fontSize: 14,
      horizontalAlign: HorizontalAlign.Center,
      backgroundColorHex:
          ExcelColor.fromHexString("#CB9CA3"), // Matching PDF color
    );

    for (var data in stockSummaryDataList) {
      // **Company Name Header Row**
      var companyCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
      );
      companyCell.value = TextCellValue(data.companyName ?? 'Company Name');
      companyCell.cellStyle = companyStyle;

      // Merge company name across 5 columns
      sheet.merge(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
        CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex),
      );

      rowIndex++; // Move to the next row

      // **Table Headers**
      List<String> headers = [
        "Item",
        "Opening Qty",
        "Inward Qty",
        "Outward Qty",
        "Balance Qty",
      ];

      for (int col = 0; col < headers.length; col++) {
        var headerCell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
        );
        headerCell.value = TextCellValue(headers[col]);
        headerCell.cellStyle = headerStyle;
      }

      rowIndex++; // Move to next row after headers

      // **Item Data Rows**
      for (var item in data.itemData ?? []) {
        List<String> values = [
          item.itemName ?? '',
          item.opqty ?? '0',
          item.iqty ?? '0',
          item.oqty ?? '0',
          item.bqty ?? '0',
        ];

        for (int col = 0; col < values.length; col++) {
          var cell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
          );
          cell.value = TextCellValue(values[col]);
          cell.cellStyle = cellStyle;
        }

        rowIndex++; // Move to the next row for next data entry
      }

      rowIndex += 2; // Extra spacing before the next company entry
    }

    // **Save the Excel file in a temporary directory**
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/Stock_Summary.xlsx';
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
