import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/seat_model.codegen.dart';

final selectedSeatsProvider = StateProvider.autoDispose<List<SeatModel>>((_) => []);
