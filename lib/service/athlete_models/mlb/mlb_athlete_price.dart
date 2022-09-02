import 'package:ax_dapp/service/athlete_models/mlb/mlb_athlete_price_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mlb_athlete_price.g.dart';

@JsonSerializable()
class MLBAthletePriceStats {
  const MLBAthletePriceStats({
    required this.id,
    required this.name,
    required this.priceHistory,
  });

  factory MLBAthletePriceStats.fromJson(Map<String, dynamic> json) =>
      _$MLBAthletePriceStatsFromJson(json);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'price_history')
  final List<MLBAthletePriceHistory> priceHistory;

  Map<String, dynamic> toJson() => _$MLBAthletePriceStatsToJson(this);
}
