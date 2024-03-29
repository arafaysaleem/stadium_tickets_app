import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helpers/constants/constants.dart';

// Enums
import '../enums/seat_indicator_enum.dart';

// Models
import '../models/seat_model.codegen.dart';

// Providers
import '../providers/zone_seats_provider.codegen.dart';

class SeatWidget extends StatefulHookConsumerWidget {
  final SeatModel seat;

  const SeatWidget({required this.seat, super.key});

  @override
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends ConsumerState<SeatWidget> {
  bool isSelected = false;

  void _onTap() {
    setState(() {
      isSelected = !isSelected;
    });
    ref
        .read(selectedSeatsProvider.notifier)
        .toggleSeat(isSelected: isSelected, seat: widget.seat);
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
                ? SeatIndicator.SELECTED.color
                : SeatIndicator.AVAILABLE.color,
            borderRadius: Corners.rounded7,
          ),
        ),
      ),
    );
  }
}
