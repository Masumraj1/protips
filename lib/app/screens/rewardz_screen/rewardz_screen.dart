import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/reward_card/reward_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class RewardzScreen extends StatefulWidget {
  RewardzScreen({super.key});

  @override
  State<RewardzScreen> createState() => _RewardzScreenState();
}

class _RewardzScreenState extends State<RewardzScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    // Initial API call to fetch data for the first reward
    if (homeController.rewardList.isNotEmpty) {
      homeController.selectedReward(id: homeController.rewardList[0].id ?? "");
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.rewardz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [

            /// ========================= Rewardz List =======================
            Obx(() {
              if (homeController.rewardList.isEmpty) {
                return const CustomText(
                  text: "No Rewards Found",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray500,
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                  List.generate(homeController.rewardList.length, (index) {
                    final item = homeController.rewardList[index];
                    final isSelected =
                        homeController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        // Update selected index and fetch corresponding data
                        homeController.selectedIndex.value = index;
                        homeController.selectedReward(id: item.id ?? "");
                        print("Selected Item ID: ${item.id}");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(color: AppColors.green500, width: 2)
                              : null,
                        ),
                        child: Column(
                          children: [
                            // Reward Image
                            CustomNetworkImage(
                              imageUrl:
                              "${ApiUrl.netWorkUrl}${item.image ?? ""}",
                              height: 72,
                              width: 73,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            SizedBox(height: 10.h),
                            // Reward Name
                            Text(
                              item.name ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),

            Gap(24.h),

            /// ========================= Search Input =======================
            CustomTextField(
              isColor: false,
              inputTextStyle: const TextStyle(color: AppColors.gray500),
              onFieldSubmitted: (value) {
                homeController.searchReward(search: value);
              },
              textEditingController: homeController.searchController,
              hintText: AppStrings.searchReward,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.gray500,
              ),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),

            Gap(14.h),

            /// ======================== Reward Details ======================

            Expanded(
              child: Obx(() {
                if (homeController.rxRequestStatus.value == Status.loading) {
                  return const CustomLoader(); // Show loading indicator
                }

                if (homeController.rxRequestStatus.value ==
                    Status.internetError) {
                  return const Center(
                    child: CustomText(
                      text: 'Please Connect Your Internet',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                if (homeController.rxRequestStatus.value == Status.error) {
                  return GeneralErrorScreen(
                    onTap: () {
                      if (homeController.rewardList.isNotEmpty) {
                        homeController.selectedReward(
                          id: homeController.rewardList[0].id ?? "",
                        );
                      }
                    },
                  );
                }

                if (homeController.rxRequestStatus.value == Status.completed &&
                    homeController.selectRewardList.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "No Rewards Available",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: homeController.selectRewardList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.8,
                    mainAxisExtent: 350,
                  ),
                  itemBuilder: (context, index) {
                    var data = homeController.selectRewardList[index];
                    return RewardCard(
                      imageUrl: "${ApiUrl.netWorkUrl}${data.rewardImage ?? ""}",
                      name: data.name ?? "",
                      describe: data.description ?? "",
                      points: data.pointRequired.toString(),
                      onTap: () {
                        // Fixed comparison using '==' instead of '='
                        if (data.category?.deliveryOption ==
                            "Shipping Address") {
                          whenShirtDialog(context);
                        } else if (data.category?.deliveryOption == "Email") {
                          showDialogBox(context);
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
  ///===========================Info==========================
  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
          backgroundColor: AppColors.white50,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Assets.icons.closeSmall.svg())
                  ],
                ),
                const CustomText(
                  left: 50,
                  fontSize: 16,
                  text: AppStrings.howTOReceive,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 10,
                ),
                const CustomText(
                  textAlign: TextAlign.start,
                  text: AppStrings.veryFyYourEmailAddress,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray500,
                  fontSize: 14,
                  maxLines: 10,
                ),
                const CustomText(
                  textAlign: TextAlign.start,
                  top: 16,
                  text: AppStrings.veryFyYourNameAndMailing,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.gray500,
                  bottom: 16,
                  maxLines: 10,
                ),
                const CustomText(
                  textAlign: TextAlign.start,
                  top: 16,
                  text: AppStrings.confirmationOnce,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.gray500,
                  bottom: 16,
                  maxLines: 10,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onTap: () {
                    Get.back();

                    veryFyEmailAddress(context);
                  },
                  title: AppStrings.continues,
                  fillColor: AppColors.blue500,
                )
              ],
            ),
          )),
    );
  }

  ///===========================Email=====================
  void veryFyEmailAddress(BuildContext context) {
    final fromEmail = GlobalKey<FormState>();

    Get.dialog(
      AlertDialog(
          backgroundColor: AppColors.white50,
          content: Form(
            key: fromEmail,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Assets.icons.closeSmall.svg())
                  ],
                ),
                const CustomText(
                  left: 50,
                  fontSize: 16,
                  text: "Verify Email Address",
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 10,
                ),
                const CustomText(
                  text: AppStrings.email,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  bottom: 10,
                ),

                ///============================VeryFy Email===================
                CustomTextField(
                  inputTextStyle: const TextStyle(color: AppColors.gray500),
                  textEditingController: homeController.emailController,
                  fillColor: AppColors.white600,
                  hintText: AppStrings.enterYourEmail,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.enterValidEmail;
                    } else if (!AppStrings.emailRegexp
                        .hasMatch(homeController.emailController.text)) {
                      return AppStrings.enterValidEmail;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),

                ///=========================Send Code======================
                CustomButton(
                  onTap: () {
                    if (fromEmail.currentState!.validate()) {
                      Get.back();

                      homeController.veryFyEmail(
                          rewardId: homeController.selectRewardList[0].id ?? "",
                          categoryId:
                          homeController.selectRewardList[0].category?.id ??
                              "");

                      veryFyOtp(context);

                    }
                  },
                  title: AppStrings.sendCode,
                  fillColor: AppColors.blue500,
                )
              ],
            ),
          )),
    );
  }



  ///===================================Otp =======================
  void veryFyOtp(BuildContext context) {
    final formOtp = GlobalKey<FormState>();

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.white50,
        content: Obx(
           () {
            return Form(
              key: formOtp,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Assets.icons.closeSmall.svg(),
                      ),
                    ],
                  ),
                  const CustomText(
                    left: 50,
                    fontSize: 16,
                    text: "Enter Code",
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray500,
                    bottom: 20,
                  ),
                  const CustomText(
                    text: 'Please enter the 6 digit code',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    bottom: 10,
                  ),
                  // Wrap the PinCodeTextField with an Expanded widget to avoid overflow
                  Expanded(
                    child: PinCodeTextField(
                      textStyle: const TextStyle(color: AppColors.gray500),
                      keyboardType: TextInputType.phone,
                      autoDisposeControllers: false,
                      cursorColor: AppColors.gray500,
                      appContext: context,
                      controller: homeController.pinController,
                      onCompleted: (value) {
                        homeController.resetCodeInput = value;
                      },
                      validator: (value) {
                        if (value != null && value.length == 5) {
                          return null;
                        } else {
                          return "Please enter a valid 5-digit OTP code";
                        }
                      },
                      autoFocus: true,
                      pinTheme: PinTheme(
                        disabledColor: Colors.transparent,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 49.h,
                        fieldWidth: 47.w,
                        activeFillColor: AppColors.white50,
                        selectedFillColor: AppColors.white50,
                        inactiveFillColor: AppColors.white50,
                        borderWidth: 0.5,
                        activeBorderWidth: 2.0, // Thicker border when active
                        selectedColor: AppColors.blue500, // Border color when selected
                        inactiveColor: AppColors.gray300, // Border color when inactive
                        activeColor: AppColors.blue500, // Active border color
                      ),
                      length: 5, // Ensure length is 6 for OTP input
                      enableActiveFill: true,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ///=========================verifyCode======================

                  homeController.isVeryFyOtp.value?const CustomLoader():
                  CustomButton(
                    onTap: () {
                      if (formOtp.currentState!.validate()) {
                        Get.back();
                        homeController.veryFyOtp();
                      }
                    },
                    title: AppStrings.verifyCode,
                    fillColor: AppColors.blue500,
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }


  /// ===========================Shirt==========================
  void whenShirtDialog(BuildContext context) {
    final fromShirt = GlobalKey<FormState>();

    Get.dialog(
      AlertDialog(
          backgroundColor: AppColors.white50,
          content: SingleChildScrollView(
            child: Obx(() {
              return Form(
                key: fromShirt,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Assets.icons.closeSmall.svg())
                      ],
                    ),

                    ///==========================Delete Account===============
                    const CustomText(
                      left: 20,
                      fontSize: 16,
                      maxLines: 2,
                      text: "Verify Name and Mailing Address",
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray500,
                      bottom: 10,
                    ),

                    ///===========================Full Name Controller ===================
                    CustomFromCard(
                      hinText: AppStrings.enterYourFullName,
                      isBgColor: true,
                      title: AppStrings.fullName,
                      controller: homeController.fullNameController,
                      validator: (value) {
                        if (value == null || value
                            .toString()
                            .isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStrings.enterAValidName;
                        }
                        return null;
                      },
                    ),
                    const CustomText(
                      textAlign: TextAlign.start,
                      fontSize: 16,
                      text: AppStrings.mailingAddress,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray500,
                      bottom: 18,
                      top: 18,
                    ),

                    ///==========================Street Address==================
                    CustomFromCard(
                      hinText: AppStrings.typeHere,
                      isBgColor: true,
                      title: AppStrings.streetAddress,
                      controller: homeController.streetController,
                      validator: (value) {
                        if (value == null || value
                            .toString()
                            .isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),

                    ///==========================Phone Number==================
                    CustomFromCard(
                      hinText: AppStrings.typeHere,
                      isBgColor: true,
                      title: AppStrings.phoneNumber,
                      controller: homeController.phoneController,
                      validator: (value) {
                        if (value == null || value
                            .toString()
                            .isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),

                    ///==================City Controller=====================
                    CustomFromCard(
                      hinText: AppStrings.typeHere,
                      isBgColor: true,
                      title: AppStrings.city,
                      controller: homeController.cityController,
                      validator: (value) {
                        if (value == null || value
                            .toString()
                            .isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),

                    ///=========================State Controller=================
                    CustomFromCard(
                      hinText: AppStrings.typeHere,
                      isBgColor: true,
                      title: AppStrings.state,
                      controller: homeController.stateController,
                      validator: (value) {
                        if (value == null || value
                            .toString()
                            .isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),

                    ///=========================ZipCode Controller====================
                    CustomFromCard(
                      hinText: AppStrings.typeHere,
                      isBgColor: true,
                      title: AppStrings.zipCode,
                      controller: homeController.zipCodeController,
                      validator: (value) {
                        if (value == null || value
                            .toString()
                            .isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    homeController.isSubmit.value
                        ? const CustomLoader()
                        : CustomButton(
                      onTap: () {
                        if (fromShirt.currentState!.validate()) {
                          homeController.redeemCreate(
                              rewardId:
                              homeController.selectRewardList[0].id ??
                                  "",
                              categoryId: homeController
                                  .selectRewardList[0].category?.id ??
                                  "");
                        }
                      },
                      title: AppStrings.submit,
                      fillColor: AppColors.blue500,
                    )
                  ],
                ),
              );
            }),
          )),
    );
  }
}
