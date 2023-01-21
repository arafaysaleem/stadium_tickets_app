import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/snack_model.codegen.dart';

// Widgets
import 'snack_widget.dart';

class CategorySnacksGrid extends HookWidget {
  final bool extendBottom;
  final List<SnackModel> snacks;

  static const _snackHeight = 38;
  static const _snackWidth = 68.0;
  static const _snackGap = 11.0;

  const CategorySnacksGrid({
    super.key,
    required this.extendBottom,
    required this.snacks,
  });

  double getMaxGridHeight() {
    final height = snacks.length * (_snackHeight + _snackGap) - _snackGap + 12;
    return max(height, 350);
  }

  bool _onGlowNotification(OverscrollIndicatorNotification overScroll) {
    overScroll.disallowIndicator();
    return true;
  }

  Shader getShader(Rect bounds) {
    return LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      stops: const [0.93, 1],
      colors: [Colors.transparent, AppColors.backgroundColor.withOpacity(0.98)],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    final vertScrollController = useScrollController();
    return Expanded(
      flex: extendBottom ? 1 : 0,
      child: Scrollbar(
        thumbVisibility: true,
        controller: vertScrollController,
        scrollbarOrientation: ScrollbarOrientation.left,
        radius: const Radius.circular(20),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: _onGlowNotification,
          child: ShaderMask(
            shaderCallback: getShader,
            blendMode: BlendMode.dstOut,
            child: SingleChildScrollView(
              controller: vertScrollController,
              child: SizedBox(
                height: getMaxGridHeight(),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: _onGlowNotification,
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 15, 15),
                    itemCount: snacks.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: _snackGap,
                      mainAxisExtent: _snackWidth,
                      mainAxisSpacing: _snackGap,
                    ),
                    itemBuilder: (ctx, i) => SnackWidget(snack: snacks[i]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
