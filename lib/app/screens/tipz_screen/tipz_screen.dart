import 'package:flutter/material.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TipzScreen extends StatelessWidget {
  const TipzScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: "Tippz",
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDescriptionText(AppStrings.tipYouFavorite, 18),
              _buildTitleText(AppStrings.chooseAPlayer, 18),
              _buildImage(Assets.images.indiana22.image()),
              _buildDescriptionText(AppStrings.selectYourFavorite, 18, top: 10),
              _buildTitleText(AppStrings.sendThem, 18),
              _buildContainerImage(Assets.images.pt.image(), height: 224),
              _buildDescriptionText(AppStrings.afterSelectingYour, 18, top: 10),
              _buildTitleText(AppStrings.earnReward, 18),
              _buildImage(Assets.images.earning.image()),
              _buildDescriptionText(AppStrings.youAreEligibleToEarn, 18, top: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionText(String text, double bottom, {double top = 0}) {
    return CustomText(
      top: top,
      bottom: bottom,
      maxLines: 5,
      textAlign: TextAlign.start,
      text: text,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.gray500,
    );
  }

  Widget _buildTitleText(String text, double bottom) {
    return CustomText(
      bottom: bottom,
      textAlign: TextAlign.start,
      text: text,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.gray500,
    );
  }

  Widget _buildImage(Image image) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: image,
    );
  }

  Widget _buildContainerImage(Image image, {required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.white50,
      child: image,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get_common/get_reset.dart';
// import 'package:protippz/app/core/custom_assets/assets.gen.dart';
// import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
// import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
// import 'package:protippz/app/utils/app_colors.dart';
// import 'package:protippz/app/utils/app_strings.dart';
//
// class TipzScreen extends StatelessWidget {
//   const TipzScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bg500,
//       appBar: CustomAppBar(
//         appBarContent: "Tippz",
//         iconData: Icons.arrow_back,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(
//                 bottom: 18,
//                 textAlign: TextAlign.start,
//                 maxLines: 4,
//                 text: AppStrings.tipYouFavorite,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.gray500,
//               ),
//               CustomText(
//                 bottom: 18,
//                 textAlign: TextAlign.start,
//                 text: AppStrings.chooseAPlayer,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//                 color: AppColors.gray500,
//               ),
//               Assets.images.indiana22.image(),
//               CustomText(
//                 top: 10,
//                 maxLines: 5,
//                 bottom: 18,
//                 text: AppStrings.selectYourFavorite,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.gray500,
//               ),
//               CustomText(
//                 bottom: 18,
//                 textAlign: TextAlign.start,
//                 text: AppStrings.sendThem,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//                 color: AppColors.gray500,
//               ),
//               Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 224,
//                   color: AppColors.white50,
//                   child: Assets.images.pt.image()),
//               CustomText(
//                 top: 10,
//                 maxLines: 5,
//                 bottom: 18,
//                 text: AppStrings.afterSelectingYour,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.gray500,
//               ),
//               CustomText(
//                 bottom: 18,
//                 textAlign: TextAlign.start,
//                 text: AppStrings.earnReward,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//                 color: AppColors.gray500,
//               ),
//               Assets.images.earning.image(),
//
//               CustomText(
//                 top: 10,
//                 maxLines: 5,
//                 bottom: 18,
//                 text: AppStrings.youAreEligibleToEarn,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.gray500,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }