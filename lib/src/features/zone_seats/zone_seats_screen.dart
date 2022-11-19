import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../config/routes/app_router.dart';
import '../../helpers/constants/app_colors.dart';

// Providers
import 'providers/zone_seats_provider.codegen.dart';

// Models
import '../stadium_zones/models/zone_seating_model.codegen.dart';

// Widgets
import '../../global/widgets/async_value_widget.dart';
import '../../global/widgets/custom_chips_list.dart';
import '../../global/widgets/custom_circular_loader.dart';
import '../../global/widgets/error_response_handler.dart';
import 'widgets/purchase_seats_button.dart';
import 'widgets/seat_color_indicators.dart';
import 'widgets/seats_area.dart';

class ZoneSeatsScreen extends ConsumerWidget {
  const ZoneSeatsScreen({super.key});

  static const _seatSize = 28.0;
  static const _seatGap = 7.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zone = ref.watch(currentZoneProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Icons row
              const _BackIcon(),

              const SizedBox(height: 20),

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
                      return Column(
                        children: [
                          // Seat color indicators
                          const SeatColorIndicators(),

                          const SizedBox(height: 10),

                          // Seats Area
                          SeatsArea(
                            seatSize: _seatSize,
                            seatGap: _seatGap,
                            numOfRows: zone.numOfRows,
                            seatsPerRow: zone.seatsPerRow + 4,
                            missing: zoneSeatingModel.missing,
                            blocked: zoneSeatingModel.blocked,
                            booked: zoneSeatingModel.booked,
                          ),

                          // Selected Seats Chips
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 22, 0, 22),
                            child: Consumer(
                              builder: (ctx, ref, child) {
                                final _selectedSeats =
                                    ref.watch(selectedSeatsProvider);
                                final seatNames = _selectedSeats
                                    .map((e) => '${e.seatRow}-${e.seatNumber}')
                                    .toList();
                                return CustomChipsList(
                                  chipContents: seatNames,
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
          ref.read(selectedSeatsProvider.notifier).state = [];
          AppRouter.pop();
        },
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
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
