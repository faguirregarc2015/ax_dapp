import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';

class MintDialogState extends Equatable {

  const MintDialogState({
    required this.balance,
    required this.mintInput,
    required this.status,
    required this.tokenAddress,
    required this.athleteId,
    required this.receiveAmount,
  });

  factory MintDialogState.initial() {
    return const MintDialogState(
        balance: 0,
        mintInput: 0,
        status: BlocStatus.initial,
        tokenAddress: '',
        athleteId: 0,
        receiveAmount: 0,);
  }

  final double balance;
  final double mintInput;
  final BlocStatus status;
  final String tokenAddress;
  final int athleteId;
  final double receiveAmount;

  @override
  List<Object> get props {
    return [
      balance,
      mintInput,
      status,
      tokenAddress,
      athleteId,
      receiveAmount,
    ];
  }

  MintDialogState copyWith({
    double? balance,
    double? mintInput,
    BlocStatus? status,
    String? tokenAddress,
    int? athleteId,
    double? receiveAmount,
  }) {
    return MintDialogState(
      balance: balance ?? this.balance,
      mintInput: mintInput ?? this.mintInput,
      status: status ?? this.status,
      tokenAddress: tokenAddress ?? this.tokenAddress,
      athleteId: athleteId ?? this.athleteId,
      receiveAmount: receiveAmount ?? this.receiveAmount,
    );
  }
}
