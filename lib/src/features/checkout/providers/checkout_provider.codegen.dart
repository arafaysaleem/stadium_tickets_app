import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/extensions/extensions.dart';
import '../enums/checkout_state_enum.dart';

// Models
import '../models/card_details_model.codegen.dart';
import '../models/payment_model.codegen.dart';

// Repositories
import '../repositories/checkout_repository.codegen.dart';

// Features
import '../../stadium_zones/stadium_zones.dart';
import '../../events/events.dart';
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
      final event = ref.read(currentEventProvider)!;
      final bookingId = ref.read(reservedBookingProvider)!;
      final seatPrice = ref.read(currentZoneProvider)!.type.price;
      final seatTickets = ref.read(seatTicketsProvider).length;
      final parkingTickets = ref.read(parkingTicketsProvider);
      final data = PaymentModel(
        card: card!,
        event: PaymentEventModel(
          name: event.name,
          date: event.date,
          time: event.startTime,
        ),
        seats: PaymentSeatsModel(
          price: seatPrice,
          qty: seatTickets,
          total: seatTickets * seatPrice,
        ),
        parking: PaymentParkingModel(
          price: parkingTickets.first.price!,
          qty: parkingTickets.length,
          total: parkingTickets.length * parkingTickets.first.price!,
        ),
        orderAmount: ref.read(totalAmountProvider),
        orderDate: DateTime.now(),
      );

      await checkoutRepository.create(
        bookingId: bookingId,
        data: data.toJson(),
      );

      state = const AsyncData(CheckoutState.CONFIRMING_BOOKING);

      await Future<void>.delayed(2.seconds);

      return CheckoutState.SUCCESS;
    });

    return CheckoutState.SUCCESS;
  }
}
