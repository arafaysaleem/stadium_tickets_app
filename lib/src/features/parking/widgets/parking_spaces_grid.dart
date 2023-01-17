import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Enums
import '../../zone_seats/enums/seat_indicator_enum.dart';

// Models
import '../models/space_model.codegen.dart';

// Widgets
import 'space_widget.dart';

class ParkingSpacesGrid extends HookWidget {
  final double spaceWidth;
  final double spaceGap;
  final int numOfRows;
  final int floorNumber;
  final bool extendBottom;
  final bool extendRight;
  final int spacesPerRow;
  final List<SpaceModel> missing;
  final List<SpaceModel> blocked;
  final List<SpaceModel> booked;

  static const _spaceHeight = 38;

  const ParkingSpacesGrid({
    super.key,
    required this.spaceWidth,
    required this.extendBottom,
    required this.extendRight,
    required this.spaceGap,
    required this.missing,
    required this.blocked,
    required this.booked,
    required this.numOfRows,
    required this.floorNumber,
    required this.spacesPerRow,
  });

  double getMaxGridHeight() {
    final height = numOfRows * (_spaceHeight + spaceGap) - spaceGap + 12;
    return max(height, 350);
  }

  bool isMissing(SpaceModel space) => missing.contains(space);

  bool isBlocked(SpaceModel space) => blocked.contains(space);

  bool isBooked(SpaceModel space) => booked.contains(space);

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
                    itemCount: numOfRows * spacesPerRow,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numOfRows,
                      crossAxisSpacing: spaceGap,
                      mainAxisExtent: spaceWidth,
                      mainAxisSpacing: spaceGap,
                    ),
                    itemBuilder: (ctx, i) {
                      final space = SpaceModel(
                        spaceRow: String.fromCharCode(i % numOfRows + 65),
                        spaceNumber: i ~/ numOfRows,
                      );
                      Widget? child;
                      if (isMissing(space)) {
                        child = Insets.shrink;
                      } else if (isBooked(space)) {
                        child = const _BookedSpace();
                      } else if (isBlocked(space)) {
                        child = const BlockedSpace();
                      }
                      return child ??
                          SpaceWidget(
                            key: ValueKey('F$floorNumber ${space.spaceRow}-${space.spaceNumber}'),
                            space: space,
                          );
                    },
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

class BlockedSpace extends StatelessWidget {
  const BlockedSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: Corners.rounded10,
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 67, 67, 67),
            borderRadius: Corners.rounded4,
          ),
          child: Center(
            child: Image.asset(
              AppAssets.lockIcon,
              color: AppColors.textWhite80Color,
            ),
          ),
        ),
      ),
    );
  }
}

class _BookedSpace extends StatelessWidget {
  const _BookedSpace();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: Corners.rounded10,
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 1,
          child: Image.asset(
            AppAssets.carIcon,
            color: SeatIndicator.TAKEN.color,
          ),
        ),
      ),
    );
  }
}
