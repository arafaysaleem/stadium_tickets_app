import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/networking/custom_exception.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function() loading;
  final Widget Function()? emptyOrNull;
  final Widget Function()? onEmpty;
  final Widget Function()? onNull;
  final Widget Function()? onFirstLoad;
  final Widget Function(Object, StackTrace?) error;
  final Widget Function(T) data;
  final bool showEmptyOnNotFoundError;
  final bool showLoadingOnRefresh;

  const AsyncValueWidget({
    super.key,
    this.onFirstLoad,
    this.emptyOrNull,
    this.onEmpty,
    this.onNull,
    this.showEmptyOnNotFoundError = false,
    this.showLoadingOnRefresh = true,
    required this.value,
    required this.loading,
    required this.error,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (showLoadingOnRefresh && value.isRefreshing) return loading();
    return value.when(
      loading: onFirstLoad ?? loading,
      error: (ex, st) {
        if (showEmptyOnNotFoundError && emptyOrNull != null) {
          if (ex is CustomException && ex.code == 'NotFoundException') {
            return emptyOrNull!.call();
          }
        }
        return error(ex, st);
      },
      data: (d) {
        if (emptyOrNull != null && (d == null || (d is List && d.isEmpty))) {
          return emptyOrNull!.call();
        } else if (onEmpty != null && (d is List && d.isEmpty)) {
          return onEmpty!.call();
        } else if (onNull != null && d == null) {
          return onNull!.call();
        }
        return data(d);
      },
    );
  }
}
