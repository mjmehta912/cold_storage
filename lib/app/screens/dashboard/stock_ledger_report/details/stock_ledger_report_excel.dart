import 'dart:io';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/model/stock_ledger_report_res_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> generateAndOpenStockLedgerExcel(
  List<StockLedgerReportData> stockLedgerReportDataList,
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

    CellStyle companyStyle = CellStyle(
      bold: true,
      fontSize: 14,
      horizontalAlign: HorizontalAlign.Center,
      backgroundColorHex: ExcelColor.fromHexString("#9CCBC9"),
    );

    CellStyle itemStyle = CellStyle(
      bold: true,
      fontSize: 13,
      horizontalAlign: HorizontalAlign.Left,
      backgroundColorHex: ExcelColor.fromHexString("#E0E0E0"),
    );

    for (var companyData in stockLedgerReportDataList) {
      var companyCell = sheet.cell(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: rowIndex,
        ),
      );
      companyCell.value = TextCellValue(
        companyData.companyName ?? 'Company Name',
      );
      companyCell.cellStyle = companyStyle;

      sheet.merge(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: rowIndex,
        ),
        CellIndex.indexByColumnRow(
          columnIndex: 6,
          rowIndex: rowIndex,
        ),
      );

      rowIndex++;

      for (var stockItem in companyData.stockItems ?? []) {
        var itemCell = sheet.cell(
          CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: rowIndex,
          ),
        );
        itemCell.value = TextCellValue(
          stockItem.itemName ?? 'Item Name',
        );
        itemCell.cellStyle = itemStyle;

        sheet.merge(
          CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: rowIndex,
          ),
          CellIndex.indexByColumnRow(
            columnIndex: 6,
            rowIndex: rowIndex,
          ),
        );

        rowIndex++;

        List<String> headers = [
          "I/W No.",
          "I/W Date",
          "I/W Qty",
          "O/W No.",
          "O/W Date",
          "O/W Qty",
          "BAL"
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

        for (var itemStockDetail in stockItem.itemStockDetails ?? []) {
          List<String> inwValues = [
            itemStockDetail.inwno ?? '',
            itemStockDetail.idate ?? '',
            itemStockDetail.iqty ?? '0',
            '',
            '',
            '',
            '',
          ];

          for (int col = 0; col < inwValues.length; col++) {
            var cell = sheet.cell(
              CellIndex.indexByColumnRow(
                columnIndex: col,
                rowIndex: rowIndex,
              ),
            );
            cell.value = TextCellValue(inwValues[col]);
            cell.cellStyle = cellStyle;
          }

          rowIndex++;

          if (itemStockDetail.outwardList != null) {
            for (var outward in itemStockDetail.outwardList!) {
              List<String> outValues = [
                '',
                '',
                '',
                outward.outno ?? '',
                outward.odate ?? '',
                outward.oqty ?? '0',
                outward.bqty ?? '0',
              ];

              for (int col = 0; col < outValues.length; col++) {
                var cell = sheet.cell(
                  CellIndex.indexByColumnRow(
                    columnIndex: col,
                    rowIndex: rowIndex,
                  ),
                );
                cell.value = TextCellValue(outValues[col]);
                cell.cellStyle = cellStyle;
              }

              rowIndex++;
            }
          }
        }

        rowIndex += 2;
      }

      rowIndex += 2;
    }

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/Stock_Ledger_Report.xlsx';
    final File file = File(filePath)..writeAsBytesSync(excel.save()!);

    await OpenFilex.open(file.path);
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to generate Excel file: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
