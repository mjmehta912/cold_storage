import 'package:cold_storage/app/constants/app_constants.dart';

class ClosingBalModel {
  int id;
  String name;

  ClosingBalModel({required this.id, required this.name});

  static List<ClosingBalModel> closingBalList = [
    ClosingBalModel(id: 0, name: kAll),
    ClosingBalModel(id: 1, name: kAboveZero),
  ];
}
