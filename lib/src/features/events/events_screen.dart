import 'package:flutter/material.dart';

// Widgets
import 'widgets/events_grid_list.dart';
import 'widgets/search_bar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [

          // Search bar
          SearchBar(),

          // Events List
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: EventsGridList(),
          ),
        ],
      ),
    );
  }
}
