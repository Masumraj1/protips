import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final double? appBarWidth;
  final Color appBarBgColor;
  final String? appBarContent;
  final IconData? iconData;

  const CustomAppBar({
    this.appBarHeight = 64,
    this.appBarWidth,
    this.appBarBgColor = AppColors.white50,
    this.appBarContent,
    super.key,
    this.iconData,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(appBarWidth ?? double.infinity, appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.appBarBgColor,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            if (widget.iconData != null)
              IconButton(
                icon: Icon(widget.iconData),
                color: AppColors.green500,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            const Spacer(),
            if (widget.appBarContent != null)
              CustomText(
                text: widget.appBarContent!,
                fontWeight: FontWeight.w500,
                fontSize:20,
                color: AppColors.gray500,
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}