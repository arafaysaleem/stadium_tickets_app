import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'card_details_model.codegen.freezed.dart';
part 'card_details_model.codegen.g.dart';

@freezed
class CardDetailsModel with _$CardDetailsModel {
  const factory CardDetailsModel({
    required String cardHolderName,
    required int cardNumber,
    required int cvv,
    required DateTime expiry,
  }) = _CardDetailsModel;

  factory CardDetailsModel.fromJson(JSON json) => _$CardDetailsModelFromJson(json);
}
