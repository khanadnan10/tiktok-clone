import 'package:equatable/equatable.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;

  SignupState({
    required this.signupStatus,
  });

  factory SignupState.initial() {
    return SignupState(signupStatus: SignupStatus.initial);
  }

  @override
  List<Object?> get props => [signupStatus];

  @override
  bool get stringify => true;

  SignupState copyWith({
    SignupStatus? signupStatus,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
    );
  }
}
