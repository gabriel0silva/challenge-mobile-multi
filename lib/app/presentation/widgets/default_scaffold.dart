import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool isSplash;

  const DefaultScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.isSplash = false,
  });

  const DefaultScaffold.withOpacity({
    super.key,
    required this.body,
    this.appBar,
    this.isSplash = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true, 
      backgroundColor: isSplash ? AppColors.black : null,
      body: DecoratedBox(
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(AppAssets.pngBackground),
            fit: BoxFit.cover,
            opacity: isSplash ? 0.5 : 1.0,
          ),
        ),
        child: SizedBox.expand(
          child: body,
        ),
      ),
    );
  }
}
