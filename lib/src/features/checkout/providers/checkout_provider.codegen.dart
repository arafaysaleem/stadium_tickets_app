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

final cardDetailsProvider = StateProvider.autoDispose<CardDetailsModel?>((ref) {
  return null;
});

@riverpod
class Checkout extends _$Checkout {
  @override
  FutureOr<CheckoutState?> build() => null;

  Future<void> makeCheckoutPayment() async {
    final checkoutRepository = ref.read(checkoutRepositoryProvider);
    state = const AsyncLoading();

    state = await Future.delayed(1.seconds, () {
      return const AsyncData(CheckoutState.PROCESSING_PAYMENT);
    });

    state = await state.makeGuardedRequest(() async {
      final card = ref.read(cardDetailsProvider);
      final bookingId = ref.read(reservedBookingProvider);
      final data = card!.toJson();
      data['booking_id'] = bookingId;

      await checkoutRepository.create(data: data);

      return CheckoutState.CONFIRMING_BOOKING;
    });

    state = await Future.delayed(1.seconds, () {
      return const AsyncData(CheckoutState.SUCCESS);
    });
  }
}
