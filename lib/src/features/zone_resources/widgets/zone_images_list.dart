import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class ZoneImagesList extends StatelessWidget {
  final List<String> imageUrls;

  const ZoneImagesList({
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: imageUrls.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (context, index) => CustomNetworkImage(
        height: 230,
        radius: 15,
        imageUrl: imageUrls[index],
        fit: BoxFit.cover,
      ),
    );
  }
}
