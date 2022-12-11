import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/zone_model.codegen.dart';

// Providers
import '../providers/zones_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'zone_number_box.dart';

class Stadium extends ConsumerWidget {
  static const _coords = <double>[0, 1, 0, -1];

  const Stadium({
    super.key,
    required this.isSelected,
    required this.slideRight,
    required this.offset,
    required this.height,
  });

  final bool isSelected;
  final bool slideRight;
  final double offset;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<Map<int, ZoneModel>>(
      value: ref.watch(zonesFutureProvider),
      data: (zones) {
        return AnimatedPositioned(
          duration: Durations.medium,
          curve: Curves.fastOutSlowIn,
          bottom: offset,
          left: !isSelected
              ? 0
              : !slideRight
                  ? -185
                  : 185,
          right: !isSelected
              ? 0
              : slideRight
                  ? -185
                  : 185,
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: Corners.rounded(70),
              color: AppColors.surfaceColor,
              boxShadow: Shadows.universalDark,
            ),
            margin: const EdgeInsets.all(20),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: _MiddleGreyLayer(zonesMap: zones),
                ),

                // Zones Overlay
                for (int i = 0; i < _coords.length; i++)
                  Align(
                    alignment: Alignment(
                      _coords[i],
                      _coords[_coords.length - i - 1],
                    ),
                    child: ZoneNumberBox(
                      zone: zones[i + 1],
                    ),
                  )
              ],
            ),
          ),
        );
      },
      loading: () => const CustomCircularLoader(),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        retryCallback: () => ref.refresh(zonesFutureProvider),
        stackTrace: st,
      ),
    );
  }
}

class _MiddleGreyLayer extends StatelessWidget {
  final Map<int, ZoneModel> zonesMap;

  const _MiddleGreyLayer({required this.zonesMap});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(65),
        color: const Color.fromARGB(255, 57, 57, 57),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(35),
            child: _InnerGreyLayer(zonesMap: zonesMap),
          ),

          // Zone 5
          Positioned(
            top: 27,
            left: 12,
            child: ZoneNumberBox(
              zone: zonesMap[5],
            ),
          ),

          // Zone 6
          Positioned(
            top: 27,
            right: 12,
            child: ZoneNumberBox(
              zone: zonesMap[6],
            ),
          ),

          // Zone 7
          Positioned(
            bottom: 27,
            right: 12,
            child: ZoneNumberBox(
              zone: zonesMap[7],
            ),
          ),

          // Zone 8
          Positioned(
            bottom: 27,
            left: 12,
            child: ZoneNumberBox(
              zone: zonesMap[8],
            ),
          ),
        ],
      ),
    );
  }
}

class _InnerGreyLayer extends StatelessWidget {
  static const _coords = <double>[-1, 0, 1, 0];

  final Map<int, ZoneModel> zonesMap;

  const _InnerGreyLayer({required this.zonesMap});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(60),
        color: const Color.fromARGB(255, 68, 67, 67),
      ),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(35),
            child: _MainGround(),
          ),

          // Zones Overlay
          for (int i = 0; i < _coords.length; i++)
            Align(
              alignment: Alignment(
                _coords[i],
                -1 * _coords[_coords.length - i - 1],
              ),
              child: ZoneNumberBox(zone: zonesMap[i + 9]),
            )
        ],
      ),
    );
  }
}

class _MainGround extends StatelessWidget {
  const _MainGround();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Corners.rounded(15),
          color: Colors.greenAccent.shade700,
        ),
      ),
    );
  }
}
