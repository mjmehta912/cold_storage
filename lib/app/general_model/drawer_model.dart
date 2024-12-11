import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';

class DrawerData {
  String? name;
  String? navigateTo;
  String? iconName;
  bool? isHeader = false;

  DrawerData({this.name, this.navigateTo, this.iconName, this.isHeader});

  static List<DrawerData> drawerList = [
    // DrawerData(name: kGeneralAction, isHeader: false),
    DrawerData(
        name: kChangeCompany, iconName: kIconChangeCompany, navigateTo: kRouteSelectCompanyView),
  ];
  static List<DrawerData> drawerList2 = [
    // DrawerData(name: kAdminAction, isHeader: false),
    DrawerData(
        name: kAuthorizeRequest, iconName: kIconAuthRequest, navigateTo: kRouteOutwardDetailsBaseView),
    DrawerData(name: kUserRegistration, iconName: kIconAddUser, navigateTo: kRouteUserRegisterView),
    // DrawerData(name: kGeneralAction, isHeader: false),
    DrawerData(
        name: kChangeCompany, iconName: kIconChangeCompany, navigateTo: kRouteSelectCompanyView),
  ];
}
