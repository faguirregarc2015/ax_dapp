import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';

class RedeemDialogState extends Equatable {
  const RedeemDialogState({
    required this.athleteId,
    required this.longBalance,
    required this.shortBalance,
    required this.status,
    required this.tokenAddress,
    required this.longInput,
    required this.shortInput,
    required this.receiveAmount,
    required this.smallestBalance,
  });

  factory RedeemDialogState.inital() {
    return const RedeemDialogState(
      athleteId: 0, 
      longBalance: '', 
      shortBalance: '', 
      status: BlocStatus.initial, 
      tokenAddress: '', 
      longInput: 0, 
      shortInput: 0, 
      receiveAmount: 0,
      smallestBalance: 0,
    );
  }

  final int athleteId;
  final String longBalance;
  final String shortBalance;
  final BlocStatus status;
  final String tokenAddress;
  final double longInput;
  final double shortInput;
  final double receiveAmount;
  final double smallestBalance;
  
  @override
  List<Object?> get props {
    return [
      athleteId,
      longBalance,
      shortBalance,
      status,
      tokenAddress,
      longInput,
      shortInput,
      receiveAmount,
      smallestBalance,
    ];
  }

  RedeemDialogState copyWith({
    int? athleteId,
    String? longBalance,
    String? shortBalance,
    BlocStatus? status,
    String? tokenAddress,
    double? longInput,
    double? shortInput,
    double? receiveAmount,
    double? smallestBalance,
  }) {
    return RedeemDialogState(
      athleteId: athleteId ?? this.athleteId, 
      longBalance: longBalance ?? this.longBalance, 
      shortBalance: shortBalance ?? this.shortBalance, 
      status: status ?? this.status, 
      tokenAddress: tokenAddress ?? this.tokenAddress, 
      longInput: longInput ?? this.longInput, 
      shortInput: shortInput ?? this.shortInput, 
      receiveAmount: receiveAmount ?? this.receiveAmount,
      smallestBalance: smallestBalance ?? this.smallestBalance,
    );
  }
}
