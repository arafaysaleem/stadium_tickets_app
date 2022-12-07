import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

// Features
import '../parking.dart';

class ParkingFloorsList extends ConsumerWidget {
  const ParkingFloorsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<ParkingFloorModel>>(
      value: ref.watch(parkingFloorsFutureProvider),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 70),
        child: CustomCircularLoader(),
      ),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        retryCallback: () {},
        stackTrace: st,
      ),
      emptyOrNull: () => const EmptyStateWidget(
        height: 395,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        title: 'No Parkings found',
        subtitle: 'Try checking back later',
      ),
      data: (floors) {
        return ListView.separated(
          itemCount: floors.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          separatorBuilder: (_, __) => Insets.gapW20,
          itemBuilder: (_, i) => ParkingFloorListItem(number: i),
        );
      },
    );
  }
}
