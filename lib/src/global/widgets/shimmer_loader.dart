import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShimmerLoader extends HookWidget {
  final Widget child;

  const ShimmerLoader({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    late final controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
      lowerBound: 0.5,
    );
    useEffect(
      () {
        controller
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          })
          ..forward();
        return null;
      },
      const [],
    );
    return FadeTransition(
      opacity: controller,
      child: child,
    );
  }
}
