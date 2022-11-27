import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../global/widgets/custom_network_image.dart';

class ZoneVideosList extends StatelessWidget {
  final List<String> videoUrls;

  const ZoneVideosList({
    super.key,
    required this.videoUrls,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: videoUrls.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (context, index) => CustomNetworkImage(
        height: 230,
        radius: 15,
        imageUrl: videoUrls[index],
        fit: BoxFit.cover,
      ),
    );
  }
}
