import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:flutter/material.dart';

class DrawerData {
  String? name;
  String? navigateTo;
  IconData? icon;
  bool? isHeader = false;

  DrawerData({
    this.name,
    this.navigateTo,
    this.icon,
    this.isHeader,
  });

  static List<DrawerData> drawerList = [
    DrawerData(
      name: kChangeCompany,
      icon: Icons.sync,
      navigateTo: kRouteSelectCompanyView,
    ),
  ];
  static List<DrawerData> drawerList2 = [
    // DrawerData(
    //   name: kAuthorizeRequest,
    //   icon: Icons.verified_outlined,
    //   navigateTo: kRouteOutwardDetailsBaseView,
    // ),
    DrawerData(
      name: kUserRegistration,
      icon: Icons.people_outline,
      navigateTo: kRouteUserRegisterView,
    ),
    DrawerData(
      name: kChangeCompany,
      icon: Icons.sync,
      navigateTo: kRouteSelectCompanyView,
    ),
  ];
}
