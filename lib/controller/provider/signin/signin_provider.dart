import 'package:flutter/cupertino.dart';
import 'package:tiktokclone/controller/firebase/authRepository.dart';
import 'package:tiktokclone/controller/provider/signin/signin_state.dart';

class SigninProvider extends ChangeNotifier {
  SigninState _state = SigninState.initial();
  SigninState get state => _state;

  final AuthRepository authRepository;

  SigninProvider({required this.authRepository});

  Future<void> signin({required String email, required String password}) async {
    _state = _state.copyWith(signinStatus: SigninStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signIn(email, password);
      _state = _state.copyWith(signinStatus: SigninStatus.success);
      notifyListeners();
    } catch (e) {
      debugPrint("Error in signinProvider : $e");
      _state = _state.copyWith(signinStatus: SigninStatus.error);
      notifyListeners();
      rethrow;
    }
  }
}
