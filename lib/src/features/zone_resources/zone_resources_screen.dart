import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_styles.dart';

// Router
import '../../config/routes/app_router.dart';

// Widgets
import '../../global/widgets/custom_back_icon.dart';
import 'widgets/resource_type_slider.dart';
import 'widgets/zone_resources_view.dart';

class ZoneResourcesScreen extends StatelessWidget {
  const ZoneResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: const [
              Align(
                alignment: Alignment.topLeft,
                child: CustomBackIcon(
                  onTap: AppRouter.pop,
                ),
              ),

              Insets.gapH5,

              // Resource Type
              ResourceTypeSlider(),

              Insets.gapH20,

              // Zone Resources List
              Expanded(
                child: ZoneResourcesView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
