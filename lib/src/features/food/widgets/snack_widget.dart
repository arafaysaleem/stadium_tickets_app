import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/snack_model.codegen.dart';

// Providers
import '../providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class SnackWidget extends StatefulHookConsumerWidget {
  final SnackModel snack;

  const SnackWidget({required this.snack, super.key});

  @override
  _SnackWidgetState createState() => _SnackWidgetState();
}

class _SnackWidgetState extends ConsumerState<SnackWidget> {
  bool isSelected = false;

  void _onTap() {
    setState(() {
      isSelected = !isSelected;
    });
    final prov = ref.read(categorySnacksProvider.notifier);

    if (isSelected) {
      prov.selectSnack(widget.snack);
    } else {
      prov.removeSnack(widget.snack);
    }
  }

  @override
  void initState() {
    super.initState();
    isSelected =
        ref.read(currentCategorySelectedSnacksProvider).contains(widget.snack);
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
            border: isSelected
                ? Border.all(
                    color: AppColors.primaryColor,
                  )
                : null,
            borderRadius: Corners.rounded10,
          ),
          child: Center(
            child: CustomText.subtitle(
              widget.snack.name,
            ),
          ),
        ),
      ),
    );
  }
}
