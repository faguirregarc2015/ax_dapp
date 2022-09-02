// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlb_athlete_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLBAthletePriceStats _$MLBAthletePriceStatsFromJson(
        Map<String, dynamic> json) =>
    MLBAthletePriceStats(
      id: json['id'] as int,
      name: json['name'] as String,
      priceHistory: (json['price_history'] as List<dynamic>)
          .map(
              (e) => MLBAthletePriceHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MLBAthletePriceStatsToJson(
        MLBAthletePriceStats instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'price_history': instance.priceHistory.map((e) => e.toJson()).toList(),
    };
