import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Models
import '../models/event_model.codegen.dart';

// Providers
import '../providers/filter_providers.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'events_list_item.dart';

class EventsList extends ConsumerWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(filtersProvider),
      child: AsyncValueWidget<List<EventModel>>(
        value: ref.watch(filteredEventsProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(filtersProvider),
          stackTrace: st,
        ),
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No Events found',
          subtitle: 'Try changing the filters or search term',
        ),
        data: (filteredEvents) {
          final events = ref.watch(searchedEventsProvider(filteredEvents));
          return ListView.separated(
            itemCount: events.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => EventsListItem(
              event: events[i],
            ),
          );
        },
      ),
    );
  }
}
