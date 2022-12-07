import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Enums
import '../enums/space_indicator_enum.dart';

// Models
import '../models/space_model.codegen.dart';

// Providers
import '../providers/parking_spaces_provider.codegen.dart';

class SpaceWidget extends StatefulHookConsumerWidget {
  final SpaceModel space;

  const SpaceWidget({required this.space, super.key});

  @override
  _SpaceWidgetState createState() => _SpaceWidgetState();
}

class _SpaceWidgetState extends ConsumerState<SpaceWidget> {
  bool isSelected = false;

  void _onTap() {
    setState(() {
      isSelected = !isSelected;
    });
    ref
        .read(selectedSpacesProvider.notifier)
        .toggleSpace(isSelected: isSelected, space: widget.space);
  }

  @override
  Widget build(BuildContext context) {
    final animController = useAnimationController(
      duration: const Duration(milliseconds: 90),
    );
    final bounceAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: animController,
        curve: Curves.easeInQuad,
      ),
    );
    useEffect(
      () {
        bounceAnimation.addStatusListener((status) {
          if (status == AnimationStatus.completed) animController.reverse();
        });
        return null;
      },
      const [],
    );
    return GestureDetector(
      onTap: _onTap,
      onTapDown: (_) => animController.forward(),
      child: AnimatedBuilder(
        animation: bounceAnimation,
        builder: (ctx, child) => Transform.scale(
          scale: bounceAnimation.value,
          child: child,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected
                ? SpaceIndicator.SELECTED.color
                : SpaceIndicator.AVAILABLE.color,
            borderRadius: Corners.rounded7,
          ),
        ),
      ),
    );
  }
}
