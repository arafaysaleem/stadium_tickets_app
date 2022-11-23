import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import 'zone_number_box.dart';

class Stadium extends StatelessWidget {
  static const _coords = <double>[0, 1, 0, -1];

  const Stadium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 510,
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(70),
        color: const Color(0xFFF5F6FA),
        boxShadow: Shadows.universalDark,
      ),
      margin: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const Padding(
            padding: EdgeInsets.all(35),
            child: _MiddleGreyLayer(),
          ),

          // Zones Overlay
          for (int i = 0; i < _coords.length; i++)
            Align(
              alignment: Alignment(
                _coords[i],
                _coords[_coords.length - i - 1],
              ),
              child: ZoneNumberBox(number: i + 1),
            )
        ],
      ),
    );
  }
}

class _MiddleGreyLayer extends StatelessWidget {
  const _MiddleGreyLayer();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(65),
        color: const Color(0xFFEBEDF5),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: const [
          Padding(
            padding: EdgeInsets.all(35),
            child: _InnerGreyLayer(),
          ),

          // Zones Overlay
          Positioned(
            top: 27,
            left: 12,
            child: ZoneNumberBox(number: 5),
          ),

          Positioned(
            top: 27,
            right: 12,
            child: ZoneNumberBox(number: 6),
          ),

          Positioned(
            bottom: 27,
            right: 12,
            child: ZoneNumberBox(number: 7),
          ),

          Positioned(
            bottom: 27,
            left: 12,
            child: ZoneNumberBox(number: 8),
          ),

        ],
      ),
    );
  }
}

class _InnerGreyLayer extends StatelessWidget {
  static const _coords = <double>[-1, 0, 1, 0];

  const _InnerGreyLayer();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(60),
        color: const Color(0xFFE2E5F0),
      ),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(35),
            child: _GreenGround(),
          ),

          // Zones Overlay
          for (int i = 0; i < _coords.length; i++)
            Align(
              alignment: Alignment(
                _coords[i],
                -1 * _coords[_coords.length - i - 1],
              ),
              child: ZoneNumberBox(number: i + 9),
            )
        ],
      ),
    );
  }
}

class _GreenGround extends StatelessWidget {
  const _GreenGround();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Corners.rounded(15),
          color: Colors.green.shade800,
        ),
      ),
    );
  }
}
