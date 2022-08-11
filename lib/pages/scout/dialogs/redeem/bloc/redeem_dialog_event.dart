import 'package:equatable/equatable.dart';

abstract class RedeemDialogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnRedeemLoad extends RedeemDialogEvent {
  OnRedeemLoad({required this.athleteId});
  final int athleteId;
  @override
  List<Object?> get props => [athleteId];
}

class OnShortInput extends RedeemDialogEvent {
  OnShortInput(this.shortInput);

  final double shortInput;

  @override
  List<Object?> get props => [shortInput];
}

class OnLongInput extends RedeemDialogEvent {
  OnLongInput(this.longInput);

  final double longInput;

  @override
  List<Object?> get props => [longInput];
}

class OnMaxRedeemTap extends RedeemDialogEvent {
  OnMaxRedeemTap(this.athleteId);

  final int athleteId;
  @override
  List<Object?> get props => [athleteId];
}
