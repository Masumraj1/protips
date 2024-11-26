import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final GeneralController _generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg500,

        ///========================Privacy===================
        appBar: const CustomAppBar(
          appBarContent: AppStrings.privacyPolicy,
          iconData: Icons.arrow_back,
        ),
        body: Obx(() {
          switch (_generalController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader(); // Show loading indicator

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                _generalController.getPrivacy();
              });

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  _generalController.getPrivacy(); // Retry fetching data on error
                },
              );

            case Status.completed:
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                child: HtmlWidget(
                    _generalController.privacyModel.data?.description ?? "",
                    textStyle: const TextStyle(
                        color: AppColors.gray500, fontSize: 16)),
              );
            default:
              return const SizedBox();
          }
        }));
  }
}
