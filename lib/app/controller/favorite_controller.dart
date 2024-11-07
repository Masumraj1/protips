import 'package:get/get.dart';

class FavoriteController extends GetxController {
  ///=================home select condition=========
  RxInt selectedIndex = 0.obs;

  ///==================toggle button==============
  var isAllSelected = true.obs;

  void toggleSelection() {
    isAllSelected.value = !isAllSelected.value;
  }

  ///=======================List============
  final List<String> favoriteTabList = ["Playerz", "Teamz"];
}
