import 'dart:io';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/res/inward_stock_ledger_details_res_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> generateAndOpenInwardStockLedgerExcel(
  List<InwardStockLedgerData> inwardStockLedgerList,
) async {
  try {
    var excel = Excel.createExcel();
    Sheet sheet = excel[excel.getDefaultSheet()!];

    int rowIndex = 0;

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

    for (var data in inwardStockLedgerList) {
      var companyCell = sheet.cell(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: rowIndex,
        ),
      );
      companyCell.value = TextCellValue(
        data.companyName ?? 'Company Name',
      );
      companyCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        backgroundColorHex: ExcelColor.fromHexString('#BBB2CC'),
      );

      sheet.merge(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: rowIndex,
        ),
        CellIndex.indexByColumnRow(
          columnIndex: 5,
          rowIndex: rowIndex,
        ),
      );
      rowIndex++;

      List<String> headers = [
        "Inward No.",
        "Date",
        "Opening Qty",
        "Inward",
        "Outward",
        "Balance"
      ];

      for (int col = 0; col < headers.length; col++) {
        var headerCell = sheet.cell(
          CellIndex.indexByColumnRow(
            columnIndex: col,
            rowIndex: rowIndex,
          ),
        );
        headerCell.value = TextCellValue(headers[col]);
        headerCell.cellStyle = headerStyle;
      }
      rowIndex++;

      for (var item in data.inwardItemsDetail ?? []) {
        var itemCell = sheet.cell(
          CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: rowIndex,
          ),
        );
        itemCell.value = TextCellValue(
          item.itemName ?? 'Item Name',
        );
        itemCell.cellStyle = CellStyle(
          bold: true,
          fontSize: 12,
        );

        sheet.merge(
          CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: rowIndex,
          ),
          CellIndex.indexByColumnRow(
            columnIndex: 5,
            rowIndex: rowIndex,
          ),
        );
        rowIndex++;

        for (var detail in item.inwardDetail ?? []) {
          List<String> values = [
            detail.inwno ?? '',
            detail.idate ?? '',
            detail.opqty ?? '0',
            detail.iqty ?? '0',
            detail.oqty ?? '0',
            detail.bqty ?? '0',
          ];

          for (int col = 0; col < values.length; col++) {
            var cell = sheet.cell(
              CellIndex.indexByColumnRow(
                columnIndex: col,
                rowIndex: rowIndex,
              ),
            );
            cell.value = TextCellValue(values[col]);
            cell.cellStyle = cellStyle;
          }

          rowIndex++;
        }

        rowIndex++;
      }
    }

    // **Save the Excel file in a temporary directory**
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/Inward_Stock_Ledger.xlsx';
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
