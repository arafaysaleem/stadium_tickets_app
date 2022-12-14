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

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      stops: [0.95, 1],
      colors: [Colors.transparent, Colors.black87],
    ).createShader(bounds);
  }

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
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          height: 60,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
          child: ShaderMask(
            shaderCallback: getShader,
            blendMode: BlendMode.dstOut,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              reverse: true,
              padding: const EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemCount: floors.length,
              separatorBuilder: (_, __) => Insets.gapW15,
              itemBuilder: (ctx, i) => ParkingFloorListItem(
                parking: floors[i],
              ),
            ),
          ),
        );
      },
    );
  }
}
