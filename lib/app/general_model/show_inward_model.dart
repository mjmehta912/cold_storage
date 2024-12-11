import 'package:cold_storage/app/constants/app_constants.dart';

class ShowInwardModel {
  int id;
  String name;

  ShowInwardModel({required this.id, required this.name});

  static List<ShowInwardModel> showInwardList = [
    ShowInwardModel(id: 0, name: kComplete),
    ShowInwardModel(id: 1, name: kPending),
    ShowInwardModel(id: 2, name: kAll),
  ];
}
