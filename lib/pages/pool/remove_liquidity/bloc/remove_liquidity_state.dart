import 'package:ax_dapp/pages/pool/my_liqudity/models/my_liquidity_item_info.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';

class RemoveLiquidityState extends Equatable {
  const RemoveLiquidityState({
    required this.tokenOneRemoveAmount,
    required this.tokenTwoRemoveAmount,
    required this.percentRemoval,
    required this.status,
    required this.liquidityPositionInfo,
  });

  factory RemoveLiquidityState.initial() {
    return RemoveLiquidityState(
      tokenOneRemoveAmount: 0,
      tokenTwoRemoveAmount: 0,
      percentRemoval: 0,
      status: BlocStatus.initial,
      liquidityPositionInfo: LiquidityPositionInfo.empty(),
    );
  }

  final double tokenOneRemoveAmount;
  final double tokenTwoRemoveAmount;
  final double percentRemoval;
  final BlocStatus status;
  final LiquidityPositionInfo liquidityPositionInfo;

  @override
  List<Object> get props {
    return [
      tokenOneRemoveAmount,
      tokenTwoRemoveAmount,
      percentRemoval,
      status,
      liquidityPositionInfo,
    ];
  }

  RemoveLiquidityState copyWith({
    double? tokenOneRemoveAmount,
    double? tokenTwoRemoveAmount,
    double? percentRemoval,
    BlocStatus? status,
    LiquidityPositionInfo? liquidityPositionInfo,
  }) {
    return RemoveLiquidityState(
      tokenOneRemoveAmount: tokenOneRemoveAmount ?? this.tokenOneRemoveAmount,
      tokenTwoRemoveAmount: tokenTwoRemoveAmount ?? this.tokenTwoRemoveAmount,
      percentRemoval: percentRemoval ?? this.percentRemoval,
      status: status ?? this.status,
      liquidityPositionInfo: liquidityPositionInfo ?? this.liquidityPositionInfo,
    );
  }
}
