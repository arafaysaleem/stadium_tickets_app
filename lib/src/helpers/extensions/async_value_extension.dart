import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';

extension AsyncGuardedRequest<T> on AsyncValue<T> {
  Future<AsyncValue<T>> makeGuardedRequest(
    Future<T> Function() callback,
  ) async {
    try {
      final result = await callback.call();
      return AsyncValue.data(result);
    } on CustomException catch (ex, st) {
      debugPrintStack(label: ex.message, stackTrace: st);
      return AsyncValue.error(ex.message, st);
    }
  }
}
