import 'dart:math';

import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Models
import '../model/seat_model.codegen.dart';

// Widgets
import '../../../global/widgets/custom_text.dart';
import 'seat_widget.dart';

class SeatsArea extends StatelessWidget {
  final double seatSize;
  final double seatGap;
  final int numOfRows;
  final int seatsPerRow;
  final List<SeatModel> missing;
  final List<SeatModel> blocked;
  final List<SeatModel> booked;

  const SeatsArea({
    super.key,
    required this.seatSize,
    required this.seatGap,
    required this.missing,
    required this.blocked,
    required this.booked,
    required this.numOfRows,
    required this.seatsPerRow,
  });

  double getMaxGridHeight() {
    final height = numOfRows * (seatSize + seatGap) - seatGap;
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
    const padding = 20.0;
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: getMaxGridHeight(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seat letters' column
                  Padding(
                    padding: const EdgeInsets.only(bottom: padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < numOfRows; i++)
                          SizedBox(
                            height: 26.5,
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
                      child: GridView.builder(
                        itemCount: numOfRows * seatsPerRow,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(
                          right: padding,
                          bottom: padding,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numOfRows,
                          crossAxisSpacing: seatGap,
                          mainAxisExtent: seatSize,
                          mainAxisSpacing: seatGap,
                        ),
                        itemBuilder: (ctx, i) {
                          final seat = SeatModel(
                            seatRow: String.fromCharCode(i % numOfRows + 65),
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
                ],
              ),
            ),
          ),

          // Bottom White text fade
          const Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: padding,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1, 0.3, 1],
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          const Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: padding,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: [0.1, 0.3, 1],
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
