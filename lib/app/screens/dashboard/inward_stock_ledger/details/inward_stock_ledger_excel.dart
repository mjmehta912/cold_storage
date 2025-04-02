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

      sheet.appendRow(
        [
          TextCellValue("Inward No."),
          TextCellValue("Date"),
          TextCellValue("Opening Qty"),
          TextCellValue("Inward"),
          TextCellValue("Outward"),
          TextCellValue("Balance"),
        ],
      );
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
          sheet.appendRow(
            [
              TextCellValue(detail.inwno ?? ''),
              TextCellValue(detail.idate ?? ''),
              TextCellValue(detail.opqty ?? '0'),
              TextCellValue(detail.iqty ?? '0'),
              TextCellValue(detail.oqty ?? '0'),
              TextCellValue(detail.bqty ?? '0'),
            ],
          );
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
