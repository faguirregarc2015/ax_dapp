import 'package:json_annotation/json_annotation.dart';

part 'mlb_athlete_price_history.g.dart';

@JsonSerializable()
class MLBAthletePriceHistory {
  const MLBAthletePriceHistory({
    required this.price,
    required this.timeStamp,
  });

  factory MLBAthletePriceHistory.fromJson(Map<String, dynamic> json) =>
      _$MLBAthletePriceHistoryFromJson(json);

  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'timestamp')
  final String timeStamp;

  Map<String, dynamic> toJson() => _$MLBAthletePriceHistoryToJson(this);
}
