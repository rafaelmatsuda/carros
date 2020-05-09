import 'dart:async';

import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

import '../api_response.dart';

class LoginBloc {
  final buttonBlock = SimpleBloc<bool>();

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    buttonBlock.add(true);

    ApiResponse response = await LoginApi.login(login, senha);
    buttonBlock.add(false);
    return response;
  }

  void dispose(){
    buttonBlock.dispose();
  }
}
