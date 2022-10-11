// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:fwc_album_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:fwc_album_app/app/services/login/login_service.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view.dart';

import './login_presenter.dart';

class LoginPresenterImpl implements LoginPresenter {
  final LoginService loginService;
  late final LoginView _view;

  LoginPresenterImpl({
    required this.loginService,
  });

  @override
  Future<void> login(String email, String password) async {
    try {
      await loginService.execute(email: email, password: password);
      _view.success();
    } on UnauthorizedException {
      _view.error('Usuário ou senha inválidos.');
    } catch (e, s) {
      log('Erro ao realizar o login', error: e, stackTrace: s);
      _view.error('Erro ao realizar o login.');
    }
  }

  @override
  set view(view) => _view = view;
}
