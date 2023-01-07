import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../global/widgets/custom_text.dart';
import '../widgets/events_list.dart';
import '../widgets/hot_event_banner.dart';
import '../widgets/search_and_filters_bar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Insets.gapH20,

            // Title
            CustomText.title('Upcoming Events'),

            Insets.gapH20,

            const HotEventBanner(),

            // Search bar
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SearchAndFiltersBar(),
            ),
            
            // Events List
            const Expanded(
              child: EventsList(),
            ),
          ],
        ),
      ),
    );
  }
}
