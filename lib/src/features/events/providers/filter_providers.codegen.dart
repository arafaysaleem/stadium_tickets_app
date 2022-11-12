import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/event_model.codegen.dart';

part 'filter_providers.codegen.g.dart';

final searchFilterProvider = StateProvider.autoDispose<String>((ref) => '');

/// A provider used to access list of searched events
@riverpod
List<EventModel> searchedEvents(SearchedEventsRef ref, List<EventModel> events) {
  final _searchTerm = ref.watch(searchFilterProvider);
  if (_searchTerm.isEmpty) {
    return events;
  }
  return events.where((event) => true).toList();
}
