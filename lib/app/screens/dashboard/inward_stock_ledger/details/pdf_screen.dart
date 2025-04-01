import 'dart:io';
import 'dart:typed_data';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class PdfScreen extends StatelessWidget {
  final Uint8List pdfBytes;
  final String title;

  const PdfScreen({
    super.key,
    required this.pdfBytes,
    required this.title,
  });

  Future<void> _sharePdf() async {
    try {
      final tempDir = await getTemporaryDirectory();

      final sanitizedTitle = title.replaceAll(
        RegExp(r'[^\w\s]+'),
        '_',
      );
      final fileName = '$sanitizedTitle.pdf';

      final file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(pdfBytes);

      await Share.shareXFiles(
        [
          XFile(file.path),
        ],
        text: 'Here is a PDF file: $title',
      );
    } catch (e) {
      // showErrorSnackbar(
      //   'Error',
      //   e.toString(),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        titleText: title,
        onTap: () {
          Get.back();
        },
        actions: IconButton(
          icon: const Icon(
            Icons.share,
            size: 25,
            color: mColorPrimaryText,
          ),
          onPressed: _sharePdf,
        ),
      ),
      body: PDFView(
        pdfData: pdfBytes,
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
        fitPolicy: FitPolicy.BOTH,
        // swipeHorizontal: true,
      ),
    );
  }
}
