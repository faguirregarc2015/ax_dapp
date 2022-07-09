import 'package:equatable/equatable.dart';

abstract class MintDialogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoadDialog extends MintDialogEvent {
  final int athleteId;
  @override
  List<Object?> get props => [];
  OnLoadDialog({required this.athleteId});
}

class OnNewMintInput extends MintDialogEvent {
  final double mintInput;
  @override
  List<Object?> get props => [mintInput];
  OnNewMintInput({required this.mintInput});
}

class OnMaxBuyTap extends MintDialogEvent {
  @override
  List<Object?> get props => [];
}