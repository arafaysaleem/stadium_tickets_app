import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../global/widgets/custom_network_image.dart';

class HotEventBanner extends StatelessWidget {
  const HotEventBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomNetworkImage(
        height: 210,
        fit: BoxFit.fill,
        borderRadius: Corners.rounded10,
        imageUrl: 'https://img.freepik.com/free-vector/music-event-poster-template-with-colorful-shapes_1361-1591.jpg',
      ),
    );
  }
}
