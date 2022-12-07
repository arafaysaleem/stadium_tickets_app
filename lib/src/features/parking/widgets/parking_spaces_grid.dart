import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/space_model.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'space_widget.dart';

class ParkingSpacesGrid extends HookWidget {
  final double spaceWidth;
  final double spaceGap;
  final int numOfRows;
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

  @override
  Widget build(BuildContext context) {
    final vertScrollController = useScrollController();
    return Expanded(
      flex: extendBottom ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: extendRight
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )
              : Corners.rounded15,
          color: AppColors.surfaceColor,
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 7, 10),
        margin: EdgeInsets.only(left: 10, right: extendRight ? 0 : 10),
        child: Scrollbar(
          thumbVisibility: true,
          controller: vertScrollController,
          radius: const Radius.circular(20),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: _onGlowNotification,
            child: SingleChildScrollView(
              controller: vertScrollController,
              child: SizedBox(
                height: getMaxGridHeight(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Space letters' column
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 0; i < numOfRows; i++)
                            SizedBox(
                              height: spaceWidth - 1.5,
                              child: Center(
                                child: CustomText.body(
                                  String.fromCharCode(i + 65),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),

                    Insets.gapW10,

                    // Spaces
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: _onGlowNotification,
                      child: Flexible(
                        child: Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.top,
                          thumbVisibility: true,
                          radius: const Radius.circular(20),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(top: 12),
                            itemCount: numOfRows * spacesPerRow,
                            primary: true,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: numOfRows,
                              crossAxisSpacing: spaceGap,
                              mainAxisExtent: spaceWidth,
                              mainAxisSpacing: spaceGap,
                            ),
                            itemBuilder: (ctx, i) {
                              final space = SpaceModel(
                                spaceRow:
                                    String.fromCharCode(i % numOfRows + 65),
                                spaceNumber: i ~/ numOfRows,
                              );
                              Widget? child;
                              if (isMissing(space)) {
                                child = Insets.shrink;
                              } else if (isBlocked(space) || isBooked(space)) {
                                child = const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF5A5A5A),
                                    borderRadius: Corners.rounded7,
                                  ),
                                );
                              }
                              return child ?? SpaceWidget(space: space);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
