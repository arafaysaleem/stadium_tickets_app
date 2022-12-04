import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Helpers
import '../../helpers/constants/lottie_assets.dart';

class LottieAnimationLoader extends StatelessWidget {
  final List<String>? assets;

  const LottieAnimationLoader({
    super.key,
    this.assets,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final loaders = assets ??
        [
          LottieAssets.femaleWalkingLottie,
          LottieAssets.movingBusLottie,
          LottieAssets.peopleTalkingLottie,
        ];
    final i = Random().nextInt(3);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          loaders[i],
          width: screenWidth,
        ),
      ),
    );
  }
}
