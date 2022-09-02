// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlb_athlete_price_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLBAthletePriceHistory _$MLBAthletePriceHistoryFromJson(
        Map<String, dynamic> json) =>
    MLBAthletePriceHistory(
      price: (json['price'] as num).toDouble(),
      timeStamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$MLBAthletePriceHistoryToJson(
        MLBAthletePriceHistory instance) =>
    <String, dynamic>{
      'price': instance.price,
      'timestamp': instance.timeStamp,
    };
