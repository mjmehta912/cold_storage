import 'package:cold_storage/app/constants/app_constants.dart';

class VehicleTypeModel {
  int? id;
  String? typeName;

  VehicleTypeModel({this.id, this.typeName});

  static List<VehicleTypeModel> vehicleTypeList = [
    VehicleTypeModel(id: 0, typeName: kPartyVehicle),
    VehicleTypeModel(id: 1, typeName: kColdVehicle),
  ];
}
