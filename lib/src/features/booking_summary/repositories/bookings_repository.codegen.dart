import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Enums
import '../enums/bookings_endpoint_enum.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

part 'bookings_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
BookingsRepository bookingsRepository(BookingsRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return BookingsRepository(apiService: _apiService);
  // return MockBookingsRepository(apiService: _apiService);
}

class BookingsRepository {
  final ApiService _apiService;

  BookingsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: BookingsEndpoint.BASE.route(),
      data: data,
      converter: (response) => response.body['booking_id'] as int,
    );
  }
}

class MockBookingsRepository implements BookingsRepository {
  @override
  final ApiService _apiService;

  MockBookingsRepository({
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
