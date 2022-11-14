import 'package:flutter/material.dart';

// Widgets
import '../../global/widgets/custom_text.dart';
import 'widgets/events_grid_list.dart';
import 'widgets/hot_event_banner.dart';
import 'widgets/search_bar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Title
            CustomText.title('Upcoming Events'),

            const SizedBox(height: 25),

            const HotEventBanner(),

            // Search bar
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SearchBar(),
            ),
            
            // Events List
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: EventsGridList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
