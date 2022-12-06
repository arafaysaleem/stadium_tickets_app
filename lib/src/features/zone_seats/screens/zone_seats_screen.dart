import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Features
import '../../stadium_zones/stadium_zones.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Router
import '../../../config/routing/routing.dart';

// Providers
import '../providers/zone_seats_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/select_seats_button.dart';
import '../widgets/seat_color_indicators.dart';
import '../widgets/seats_area.dart';

class ZoneSeatsScreen extends ConsumerWidget {
  const ZoneSeatsScreen({super.key});

  static const _seatSize = 28.0;
  static const _seatGap = 7.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zone = ref.watch(currentZoneProvider)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Insets.gapH10,

            // Icon and title row
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
              child: Row(
                children: [
                  CustomBackIcon(
                    onTap: () {
                      AppRouter.pop();
                      ref.read(selectedSeatsProvider.notifier).state = [];
                    },
                  ),

                  // Zone Name
                  Expanded(
                    child: CustomText(
                      zone.name,
                      fontSize: 22,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 30),
                ],
              ),
            ),

            Insets.gapH15,

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
                    final extendBottom = zone.numOfRows > 12;
                    final extendRight = zone.seatsPerRow > 8;
                    return Column(
                      children: [
                        // Seat color indicators
                        const SeatColorIndicators(),

                        Insets.gapH15,

                        // Seats Area
                        SeatsArea(
                          seatSize: _seatSize,
                          seatGap: _seatGap,
                          extendRight: extendRight,
                          extendBottom: extendBottom,
                          numOfRows: zone.numOfRows,
                          seatsPerRow: zone.seatsPerRow,
                          missing: zoneSeatingModel.missing,
                          blocked: zoneSeatingModel.blocked,
                          booked: zoneSeatingModel.booked,
                        ),

                        if (!extendBottom) Insets.expand,

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
                                borderColor: AppColors.primaryColor,
                                contentColor: AppColors.primaryColor,
                                borderWidth: 1.5,
                                fontWeight: FontWeight.bold,
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.3),
                                isScrollable: true,
                              );
                            },
                          ),
                        ),

                        // Purchase seats button
                        const PurchaseSeatsButton(),

                        Insets.gapH10,
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
    );
  }
}
