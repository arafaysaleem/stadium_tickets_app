import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/seat_model.codegen.dart';

part 'zone_seats_provider.codegen.g.dart';

@riverpod
class SelectedSeats extends _$SelectedSeats {
  @override
  List<SeatModel> build() => [];

  void toggleSeat({required bool isSelected, required SeatModel seat}) {
    isSelected ? _selectSeat(seat) : _removeSeat(seat);
  }

  void _selectSeat(SeatModel seat) {
    state = [...state, seat];
  }

  void _removeSeat(SeatModel seat) {
    state.remove(seat);
    state = [...state];
  }

  void clear() {
    state = [];
  }

  List<String> get seatNames =>
      state.map((e) => '${e.seatRow}-${e.seatNumber}').toList();
}
