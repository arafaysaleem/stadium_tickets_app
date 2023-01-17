import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Features
import '../../booking_summary/booking_summary.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'checkout_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
CheckoutRepository checkoutRepository(CheckoutRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  // return MockCheckoutRepository(apiService: _apiService);
  return CheckoutRepository(apiService: _apiService);
}

class CheckoutRepository {
  final ApiService _apiService;

  CheckoutRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<bool> create({
    required int bookingId,
    required JSON data,
  }) async {
    return _apiService.setData<bool>(
      endpoint: BookingsEndpoint.PROCESS_PAYMENT.route(id: bookingId),
      data: data,
      converter: (response) => response.body['error'] == '0',
    );
  }
}

class MockCheckoutRepository implements CheckoutRepository {
  @override
  final ApiService _apiService;

  MockCheckoutRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<bool> create({
    required int bookingId,
    required JSON data,
  }) {
    return Future.delayed(
      2.seconds,
      () => true,
    );
  }
}
