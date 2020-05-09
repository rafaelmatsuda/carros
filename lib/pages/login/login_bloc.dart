import 'dart:async';

import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

import '../api_response.dart';

class LoginBloc {
  final _streamControllerLogin = StreamController<bool>();

  get buttonStream => _streamControllerLogin.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    _streamControllerLogin.add(true);

    ApiResponse response = await LoginApi.login(login, senha);
    _streamControllerLogin.add(false);
    return response;
  }

  void dispose(){
    _streamControllerLogin.close();
  }
}
