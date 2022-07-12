part of 'response_bloc.dart';

class ResponseState extends Equatable {
  final bool sucessful;
  factory ResponseState.initial() {
    return ResponseState(sucessful: false);
  }

  ResponseState({
    required this.sucessful,
  });

  @override
  List<Object> get props => [
        sucessful,
      ];

  ResponseState copyWith({
    bool? sucessful,
  }) {
    return ResponseState(
      sucessful: sucessful ?? this.sucessful,
    );
  }
}
