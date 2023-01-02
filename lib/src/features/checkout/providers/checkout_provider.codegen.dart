import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/extensions/extensions.dart';
import '../enums/checkout_state_enum.dart';

// Models
import '../models/card_details_model.codegen.dart';

// Repositories
import '../repositories/checkout_repository.codegen.dart';

// Features
import '../../booking_summary/booking_summary.dart';

part 'checkout_provider.codegen.g.dart';

final savedCardDetailsProvider =
    StateProvider.autoDispose<CardDetailsModel?>((ref) {
  return null;
});

final editedCardDetailsProvider =
    StateProvider.autoDispose<CardDetailsModel?>((ref) {
  return null;
});

@riverpod
class Checkout extends _$Checkout {
  @override
  Future<CheckoutState> build() => makeCheckoutPayment();

  Future<CheckoutState> makeCheckoutPayment() async {
    final checkoutRepository = ref.read(checkoutRepositoryProvider);
    state = const AsyncData(CheckoutState.PROCESSING_PAYMENT);

    state = await state.makeGuardedRequest(() async {
      final card = ref.read(savedCardDetailsProvider);
      final bookingId = ref.read(reservedBookingProvider);
      final data = card!.toJson();
      data['booking_id'] = bookingId;

      await checkoutRepository.create(data: data);

      state = const AsyncData(CheckoutState.CONFIRMING_BOOKING);

      await Future<void>.delayed(2.seconds);

      return CheckoutState.SUCCESS;
    });

    return CheckoutState.SUCCESS;
  }
}
