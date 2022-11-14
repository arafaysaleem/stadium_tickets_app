import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/extensions/context_extensions.dart';

// Models
import '../stadium_zones/models/zone_model.codegen.dart';
import '../stadium_zones/models/zone_seating_model.codegen.dart';

// Widgets
import '../../global/widgets/async_value_widget.dart';
import '../../global/widgets/custom_chips_list.dart';
import '../../global/widgets/custom_circular_loader.dart';
import '../../global/widgets/error_response_handler.dart';
import 'widgets/curved_screen.dart';
import 'widgets/purchase_seats_button.dart';
import 'widgets/seat_color_indicators.dart';
import 'widgets/seats_area.dart';

class ZoneSeatsScreen extends HookConsumerWidget {
  final ZoneModel zone;
  const ZoneSeatsScreen({
    required this.zone,
    super.key,
  });

  static const _seatSize = 28.0;
  static const _seatGap = 7.0;

  double getMaxGridHeight(int numOfRows) {
    return _seatSize * (14) + _seatGap + 3;
  }

  double getMaxScreenWidth(int seatsPerRow) {
    return seatsPerRow * (_seatSize + _seatGap + 3);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Icons row
              const _BackIcon(),

              const SizedBox(height: 5),

              // Zone Seating details
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  switchOutCurve: Curves.easeInBack,
                  child: AsyncValueWidget<ZoneSeatingModel>(
                    value: const AsyncData(
                      ZoneSeatingModel(
                        missing: [],
                        blocked: [],
                        booked: [],
                      ),
                    ),
                    data: (zoneSeatingModel) {
                      final minScreenWidth = context.screenWidth;
                      var screenWidth = getMaxScreenWidth(zone.seatsPerRow);
                      screenWidth = max(screenWidth, minScreenWidth);
                      final maxGridHeight = getMaxGridHeight(zone.numOfRows);
                      late final screenScrollController = useScrollController();

                      return Column(
                        children: [
                          // Screen
                          CurvedScreen(
                            screenScrollController: screenScrollController,
                            screenWidth: screenWidth,
                          ),

                          const Spacer(),

                          // Seats Area
                          SeatsArea(
                            maxGridHeight: maxGridHeight,
                            seatSize: _seatSize,
                            seatGap: _seatGap,
                            maxRows: 25,
                            numOfRows: zone.numOfRows,
                            seatsPerRow: zone.seatsPerRow,
                            missing: zoneSeatingModel.missing,
                            blocked: zoneSeatingModel.blocked,
                            booked: zoneSeatingModel.booked,
                            screenScrollController: screenScrollController,
                          ),

                          const Spacer(),

                          // Seat color indicators
                          const SeatColorIndicators(),

                          const Spacer(),

                          // Selected Seats Chips
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 2, 0, 22),
                            child: Consumer(
                              builder: (ctx, ref, child) {
                                // final _theatersProvider =
                                //     ref.watch(theatersProvider);
                                return CustomChipsList(
                                  // chipContents: _theatersProvider.selectedSeatNames,
                                  chipContents: const [],
                                  chipHeight: 27,
                                  chipGap: 10,
                                  fontSize: 14,
                                  chipWidth: 60,
                                  borderColor: AppColors.lightPrimaryColor,
                                  contentColor: AppColors.lightPrimaryColor,
                                  borderWidth: 1.5,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor:
                                      Colors.red.shade700.withOpacity(0.3),
                                  isScrollable: true,
                                );
                              },
                            ),
                          ),

                          // Purchase seats button
                          const PurchaseSeatsButton(),

                          const SizedBox(height: 5),
                        ],
                      );
                    },
                    loading: () => const CustomCircularLoader(),
                    error: (error, st) => ErrorResponseHandler(
                      error: error,
                      // retryCallback: () => ref.refresh(showSeatingFuture),
                      retryCallback: () {},
                      stackTrace: st,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackIcon extends ConsumerWidget {
  const _BackIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkResponse(
        radius: 25,
        onTap: () {
          // ref.read(theatersProvider).clearSelectedSeats();
          // AppRouter.pop();
        },
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white30,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_rounded, size: 23),
          ),
        ),
      ),
    );
  }
}
