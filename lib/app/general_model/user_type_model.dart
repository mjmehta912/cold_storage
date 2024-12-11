import 'package:cold_storage/app/constants/app_constants.dart';

class UserTypeModel {
  String type;

  UserTypeModel(this.type);

  static List<UserTypeModel> userTypeModelList = [
    UserTypeModel(kAdmin),
    UserTypeModel(kStaffMember),
    UserTypeModel(kUser),
  ];
}