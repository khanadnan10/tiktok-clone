import 'package:equatable/equatable.dart';

enum SigninStatus {
  initial,
  submitting,
  success,
  error,
}

class SigninState extends Equatable {
  final SigninStatus signinStatus;

  SigninState({
    required this.signinStatus,
  });

  factory SigninState.initial() {
    return SigninState(signinStatus: SigninStatus.initial);
  }

  @override
  List<Object?> get props => [signinStatus];

  @override
  bool get stringify => true;

  SigninState copyWith({
    SigninStatus? signinStatus,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
    );
  }
}
