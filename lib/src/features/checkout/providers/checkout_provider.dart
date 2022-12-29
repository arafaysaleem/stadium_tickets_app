import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/card_details_model.codegen.dart';

final cardDetailsProvider = StateProvider.autoDispose<CardDetailsModel?>((ref) {
  return null;
});
