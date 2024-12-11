import 'package:cold_storage/app/constants/app_constants.dart';

class ViewByModel {
  int id;
  String name;

  ViewByModel({required this.id, required this.name});

  static List<ViewByModel> viewByList = [
    ViewByModel(id: 0, name: kIndividual),
    ViewByModel(id: 1, name: kConsolidated),
  ];
}
