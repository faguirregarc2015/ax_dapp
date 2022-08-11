import 'package:equatable/equatable.dart';

abstract class MintDialogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoadDialog extends MintDialogEvent {
  OnLoadDialog({required this.athleteId});
  final int athleteId;
  @override
  List<Object?> get props => [];
}

class OnNewMintInput extends MintDialogEvent {
  OnNewMintInput({required this.mintInput});
  final double mintInput;
  @override
  List<Object?> get props => [mintInput];
}

class OnMaxBuyTap extends MintDialogEvent {
  @override
  List<Object?> get props => [];
}
