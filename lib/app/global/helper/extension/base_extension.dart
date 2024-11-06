import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/routes/route_path.dart';

extension RouteBasePathExt on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

// extension ApiBasePathExt on String {
//   String get addBaseUrl {
//     return ApiUrl.baseUrl + this;
//   }
// }

extension HeightWidthExt on int {
  Widget get heightWidth {
    return Gap(toDouble());
  }
}