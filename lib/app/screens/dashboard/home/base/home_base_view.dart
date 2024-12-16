import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/screens/dashboard/home/base/home_base_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBaseView extends GetView<HomeBaseController> {
  const HomeBaseView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: mColorAppbar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: mColorBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Statistics',
                      style: TextStyles.kPrimaryBoldPublicSans(
                        colors: kColorSecondPrimary,
                        fontSize: TextStyles.k22FontSize,
                      ),
                    ),
                    AppSpaces.v10,
                    CustomHomeCard(
                      onTap: () {
                        if (kRouteInwardStockLedgerBaseView.isNotEmpty) {
                          controller.navigateToScreen(
                            page: kRouteInwardStockLedgerBaseView,
                            arg: null,
                          );
                        }
                      },
                      bgColor: mColorCard1Primary,
                      title: kInwardStockLedger,
                      titleColor: mColorCard1Secondary,
                      image: mIconInwardStock,
                    ),
                    AppSpaces.v4,
                    CustomHomeCard(
                      onTap: () {
                        if (kRouteStockSummaryBaseView.isNotEmpty) {
                          controller.navigateToScreen(
                            page: kRouteStockSummaryBaseView,
                            arg: null,
                          );
                        }
                      },
                      bgColor: mColorCard2Primary,
                      title: kStockSummary,
                      titleColor: mColorCard2Secondary,
                      image: mIconStockSummary,
                    ),
                    AppSpaces.v4,
                    CustomHomeCard(
                      onTap: () {
                        if (kRouteStockLedgerReportBaseView.isNotEmpty) {
                          controller.navigateToScreen(
                            page: kRouteStockLedgerReportBaseView,
                            arg: null,
                          );
                        }
                      },
                      bgColor: mColorCard3Primary,
                      title: kStockLedger,
                      titleColor: mColorCard3Secondary,
                      image: mIconStockLedger,
                    ),
                    AppSpaces.v4,
                    CustomHomeCard(
                      onTap: () {
                        if (kRouteAccountLedgerReportBaseView.isNotEmpty) {
                          controller.navigateToScreen(
                            page: kRouteAccountLedgerReportBaseView,
                            arg: null,
                          );
                        }
                      },
                      bgColor: mColorCard4Primary,
                      title: kAccountLedger,
                      titleColor: mColorCard4Secondary,
                      image: mIconAccountLedger,
                    ),
                    AppSpaces.v10,
                    AppText(
                      text: 'Outwards',
                      style: TextStyles.kPrimaryBoldPublicSans(
                        colors: kColorSecondPrimary,
                        fontSize: TextStyles.k22FontSize,
                      ),
                    ),
                    AppSpaces.v10,
                    CustomHomeCard(
                      onTap: () {
                        if (kRouteOutwardRequestView.isNotEmpty) {
                          controller.navigateToScreen(
                            page: kRouteOutwardRequestView,
                            arg: null,
                          );
                        }
                      },
                      bgColor: mColorCard5Primary,
                      title: kOutwardRequest,
                      titleColor: mColorCard5Secondary,
                      image: mIconOutwardRequests,
                    ),
                    AppSpaces.v4,
                    CustomHomeCard(
                      onTap: () {
                        if (kRouteOutwardDetailsBaseView.isNotEmpty) {
                          controller.navigateToScreen(
                            page: kRouteOutwardDetailsBaseView,
                            arg: true,
                          );
                        }
                      },
                      bgColor: mColorCard6Primary,
                      title: kViewOutwardRequest,
                      titleColor: mColorCard6Secondary,
                      image: mIconViewRequests,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHomeCard extends StatelessWidget {
  const CustomHomeCard({
    super.key,
    required this.onTap,
    required this.bgColor,
    required this.title,
    required this.titleColor,
    required this.image,
  });

  final VoidCallback onTap;
  final Color bgColor;
  final String title;
  final Color titleColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: AppText(
                  text: title,
                  align: TextAlign.start,
                  style: TextStyles.kPrimarySemiBoldPublicSans(
                    fontSize: TextStyles.k22FontSize,
                    colors: titleColor,
                  ).copyWith(
                    height: 1,
                  ),
                ),
              ),
              Image.asset(
                image,
              ),
              CircleAvatar(
                backgroundColor: titleColor,
                radius: 15,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: bgColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
