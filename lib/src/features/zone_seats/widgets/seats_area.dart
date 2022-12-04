import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../model/seat_model.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'seat_widget.dart';

class SeatsArea extends HookWidget {
  final double seatSize;
  final double seatGap;
  final int numOfRows;
  final bool extendBottom;
  final bool extendRight;
  final int seatsPerRow;
  final List<SeatModel> missing;
  final List<SeatModel> blocked;
  final List<SeatModel> booked;

  const SeatsArea({
    super.key,
    required this.seatSize,
    required this.extendBottom,
    required this.extendRight,
    required this.seatGap,
    required this.missing,
    required this.blocked,
    required this.booked,
    required this.numOfRows,
    required this.seatsPerRow,
  });

  double getMaxGridHeight() {
    final height = numOfRows * (seatSize + seatGap) - seatGap + 12;
    return max(height, 250);
  }

  bool isMissing(SeatModel seat) => missing.contains(seat);

  bool isBlocked(SeatModel seat) => blocked.contains(seat);

  bool isBooked(SeatModel seat) => booked.contains(seat);

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
                    // Seat letters' column
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 0; i < numOfRows; i++)
                            SizedBox(
                              height: seatSize - 1.5,
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

                    // Seats
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: _onGlowNotification,
                      child: Flexible(
                        child: Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.top,
                          thumbVisibility: true,
                          radius: const Radius.circular(20),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(top: 12),
                            itemCount: numOfRows * seatsPerRow,
                            primary: true,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: numOfRows,
                              crossAxisSpacing: seatGap,
                              mainAxisExtent: seatSize,
                              mainAxisSpacing: seatGap,
                            ),
                            itemBuilder: (ctx, i) {
                              final seat = SeatModel(
                                seatRow:
                                    String.fromCharCode(i % numOfRows + 65),
                                seatNumber: i ~/ numOfRows,
                              );
                              Widget? child;
                              if (isMissing(seat)) {
                                child = Insets.shrink;
                              } else if (isBlocked(seat) || isBooked(seat)) {
                                child = const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF5A5A5A),
                                    borderRadius: Corners.rounded7,
                                  ),
                                );
                              }
                              return child ?? SeatWidget(seat: seat);
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
