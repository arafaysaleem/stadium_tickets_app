import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Enums
import '../enums/checkout_endpoint_enum.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
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

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: CheckoutEndpoint.BASE.route(),
      data: data,
      converter: (response) => response.body['payment_id'] as int,
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
  Future<int> create({required JSON data}) {
    return Future.delayed(
      2.seconds,
      () => AppUtils.randomizer().nextInt(10),
    );
  }
}
