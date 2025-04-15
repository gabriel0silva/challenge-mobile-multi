import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const DefaultScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true, 
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.pngBackground,
              fit: BoxFit.cover,
            ),
          ),
          body,
        ],
      ),
    );
  }
}
