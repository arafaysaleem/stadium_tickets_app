import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/space_model.codegen.dart';

part 'parking_spaces_provider.codegen.g.dart';

@riverpod
class SelectedSpaces extends _$SelectedSpaces {
  @override
  List<SpaceModel> build() => [];

  void toggleSpace({required bool isSelected, required SpaceModel space}) {
    isSelected ? _selectSpace(space) : _removeSpace(space);
  }

  void _selectSpace(SpaceModel space) {
    state = [...state, space];
  }

  void _removeSpace(SpaceModel space) {
    state.remove(space);
    state = [...state];
  }

  void clear() {
    state = [];
  }

  List<String> get spaceNames =>
      state.map((e) => '${e.spaceRow}-${e.spaceNumber}').toList();
}
