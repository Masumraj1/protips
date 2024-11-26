import 'package:get/get.dart';
import 'package:protippz/app/data/models/faq_model.dart';
import 'package:protippz/app/data/models/privacy_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class InfoController extends GetxController{

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///===================================getPrivacy=========================
  PrivacyModel privacyModel = PrivacyModel();
  getPrivacy() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getPrivacyPolicy);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      privacyModel = PrivacyModel.fromJson(response.body);
      print('Value========================"${privacyModel.data?.description}"');
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }


  ///===========================GetTerms===========================
  PrivacyModel termsModel = PrivacyModel();

  getTerms() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getTermsAndConditions);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      termsModel = PrivacyModel.fromJson(response.body);
      print('Value========================"${termsModel.data?.description}"');
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///=============================Get Faq Method=======================
// Track the selected FAQ item index
  var selectedIndex = Rx<int?>(null);

// Toggle the selected FAQ item
  void toggleItem(int index) {
    selectedIndex.value = selectedIndex.value == index ? null : index;
  }

  RxList<FaqList> faqList = <FaqList>[].obs;

  getFaq() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.faqList);

    if (response.statusCode == 200) {
      faqList.value = List<FaqList>.from(
          response.body["data"].map((x) => FaqList.fromJson(x))
      );

      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }



  @override
  void onInit() {
    getFaq();
    getTerms();
    getPrivacy();
    super.onInit();
  }

}