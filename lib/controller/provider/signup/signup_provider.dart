import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tiktokclone/controller/firebase/authRepository.dart';
import 'package:tiktokclone/controller/provider/signup/signup_state.dart';

class SignupProvider extends ChangeNotifier {
  SignupState _state = SignupState.initial();
  SignupState get state => _state;

  final AuthRepository authRepository;

  SignupProvider({required this.authRepository});

  Future<void> signup({
    required String email,
    required String password,
    required String username,
    required File? image,
  }) async {
    _state = _state.copyWith(signupStatus: SignupStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signup(username, email, password, image);
      _state = _state.copyWith(signupStatus: SignupStatus.success);
      notifyListeners();
    } catch (e) {
      debugPrint("Error in signup Provider : $e");
      _state = _state.copyWith(signupStatus: SignupStatus.error);
      notifyListeners();
      rethrow;
    }
  }
}
