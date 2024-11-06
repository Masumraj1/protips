/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/contacts.svg
  SvgGenImage get contacts => const SvgGenImage('assets/icons/contacts.svg');

  /// File path: assets/icons/delete.svg
  SvgGenImage get delete => const SvgGenImage('assets/icons/delete.svg');

  /// File path: assets/icons/deposite.svg
  SvgGenImage get deposite => const SvgGenImage('assets/icons/deposite.svg');

  /// File path: assets/icons/drawer.svg
  SvgGenImage get drawer => const SvgGenImage('assets/icons/drawer.svg');

  /// File path: assets/icons/dropdown.svg
  SvgGenImage get dropdown => const SvgGenImage('assets/icons/dropdown.svg');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/eye_off.svg
  SvgGenImage get eyeOff => const SvgGenImage('assets/icons/eye_off.svg');

  /// File path: assets/icons/faqs.svg
  SvgGenImage get faqs => const SvgGenImage('assets/icons/faqs.svg');

  /// File path: assets/icons/favorite_selected.svg
  SvgGenImage get favoriteSelected =>
      const SvgGenImage('assets/icons/favorite_selected.svg');

  /// File path: assets/icons/favorite_unselected.svg
  SvgGenImage get favoriteUnselected =>
      const SvgGenImage('assets/icons/favorite_unselected.svg');

  /// File path: assets/icons/google_sign_in.svg
  SvgGenImage get googleSignIn =>
      const SvgGenImage('assets/icons/google_sign_in.svg');

  /// File path: assets/icons/history_selected.svg
  SvgGenImage get historySelected =>
      const SvgGenImage('assets/icons/history_selected.svg');

  /// File path: assets/icons/history_unselected.svg
  SvgGenImage get historyUnselected =>
      const SvgGenImage('assets/icons/history_unselected.svg');

  /// File path: assets/icons/home_selected.svg
  SvgGenImage get homeSelected =>
      const SvgGenImage('assets/icons/home_selected.svg');

  /// File path: assets/icons/home_unselected.svg
  SvgGenImage get homeUnselected =>
      const SvgGenImage('assets/icons/home_unselected.svg');

  /// File path: assets/icons/invite_friends.svg
  SvgGenImage get inviteFriends =>
      const SvgGenImage('assets/icons/invite_friends.svg');

  /// File path: assets/icons/key.svg
  SvgGenImage get key => const SvgGenImage('assets/icons/key.svg');

  /// File path: assets/icons/notification_selected.svg
  SvgGenImage get notificationSelected =>
      const SvgGenImage('assets/icons/notification_selected.svg');

  /// File path: assets/icons/notification_unselected.svg
  SvgGenImage get notificationUnselected =>
      const SvgGenImage('assets/icons/notification_unselected.svg');

  /// File path: assets/icons/photo_camera.svg
  SvgGenImage get photoCamera =>
      const SvgGenImage('assets/icons/photo_camera.svg');

  /// File path: assets/icons/privacy.svg
  SvgGenImage get privacy => const SvgGenImage('assets/icons/privacy.svg');

  /// File path: assets/icons/profile_selected.svg
  SvgGenImage get profileSelected =>
      const SvgGenImage('assets/icons/profile_selected.svg');

  /// File path: assets/icons/profile_unselected.svg
  SvgGenImage get profileUnselected =>
      const SvgGenImage('assets/icons/profile_unselected.svg');

  /// File path: assets/icons/right_check.svg
  SvgGenImage get rightCheck =>
      const SvgGenImage('assets/icons/right_check.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/icons/settings.svg');

  /// File path: assets/icons/terms.svg
  SvgGenImage get terms => const SvgGenImage('assets/icons/terms.svg');

  /// File path: assets/icons/transaction_log.svg
  SvgGenImage get transactionLog =>
      const SvgGenImage('assets/icons/transaction_log.svg');

  /// File path: assets/icons/withdraw.svg
  SvgGenImage get withdraw => const SvgGenImage('assets/icons/withdraw.svg');

  /// File path: assets/icons/x.svg
  SvgGenImage get x => const SvgGenImage('assets/icons/x.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        contacts,
        delete,
        deposite,
        drawer,
        dropdown,
        eye,
        eyeOff,
        faqs,
        favoriteSelected,
        favoriteUnselected,
        googleSignIn,
        historySelected,
        historyUnselected,
        homeSelected,
        homeUnselected,
        inviteFriends,
        key,
        notificationSelected,
        notificationUnselected,
        photoCamera,
        privacy,
        profileSelected,
        profileUnselected,
        rightCheck,
        search,
        settings,
        terms,
        transactionLog,
        withdraw,
        x
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
