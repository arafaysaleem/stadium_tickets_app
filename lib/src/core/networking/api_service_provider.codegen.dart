import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Services
import '../local/path_provider_service.dart';
import 'api_endpoint.dart';
import 'api_service.dart';
import 'dio_service.dart';

// Interceptors
import 'interceptors/api_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

part 'api_service_provider.codegen.g.dart';

/// A provider used to access instance of [Dio] service
@Riverpod(keepAlive: true)
Dio _dio(_DioRef ref) {
  final baseOptions = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
  );
  return Dio(baseOptions);
}

/// A provider used to access instance of [DioService] service
@Riverpod(keepAlive: true)
DioService _dioService(_DioServiceRef ref) {
  final dio = ref.watch(_dioProvider);
  CacheOptions? cacheOptions;
  if (!kIsWeb){
    cacheOptions = CacheOptions(
      store: HiveCacheStore(PathProviderService.path),
      policy: CachePolicy.noCache, // Bcz we force cache on-demand in repositories
      maxStale: const Duration(days: 30), // No of days cache is valid
      keyBuilder: (options) => options.path,
    );
  }
  return DioService(
    dioClient: dio,
    globalCacheOptions: cacheOptions,
    interceptors: [
      // Order of interceptors very important
      ApiInterceptor(),
      if (!kIsWeb) DioCacheInterceptor(options: cacheOptions!),
      if (kDebugMode) LoggingInterceptor(),
    ],
  );
}

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) {
  final dioService = ref.watch(_dioServiceProvider);
  return ApiService(dioService);
}
