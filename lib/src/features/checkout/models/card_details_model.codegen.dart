import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';
import '../enums/card_provider_enum.dart';

part 'card_details_model.codegen.freezed.dart';
part 'card_details_model.codegen.g.dart';

@freezed
class CardDetailsModel with _$CardDetailsModel {
  const factory CardDetailsModel({
    required String cardHolderName,
    required int cardNumber,
    required int cvv,
    required String expiry,
    required CardProvider provider,
  }) = _CardDetailsModel;

  factory CardDetailsModel.fromJson(JSON json) => _$CardDetailsModelFromJson(json);
}
