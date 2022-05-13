import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AptBuyInfo extends Equatable{
  final double aptPrice;
  final double minimumReceived;
  final double priceImpact;
  final double receiveAmount;
  final double totalFee;

  factory AptBuyInfo.empty() {
    return AptBuyInfo(
        aptPrice: 0.0,
        minimumReceived: 0.0,
        priceImpact: 0.0,
        receiveAmount: 0.0,
        totalFee: 0.0);
  }
  AptBuyInfo(
      {required this.aptPrice,
      required this.minimumReceived,
      required this.priceImpact,
      required this.receiveAmount,
      required this.totalFee});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [aptPrice, minimumReceived, priceImpact, receiveAmount, totalFee];
}

