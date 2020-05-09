import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:flutter/material.dart';

import 'login_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();



  var _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((user) {
      if (user != null) {
        setState(() {
          push(context, HomePage(), replace: true);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o Login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(height: 10),
            AppText("Senha", "Digite a Senha",
                password: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                focusNode: _focusSenha),
            SizedBox(height: 20),
            StreamBuilder<bool>(
                stream: _bloc.buttonBlock.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data,
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }



    String login = _tLogin.text;
    String senha = _tSenha.text;
    print("Login: $login, Senha: $senha");
    ApiResponse response = await _bloc.login(login, senha);
    if (response.ok) {
      Usuario user = response.result;

      user.save();

      print(">>> $user");
      push(context, HomePage());
    } else {
      alert(context, response.msg);
      print("Login incorreto");
    }


  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a Senha";
    }
    if (text.length < 3) {
      return "A senha deve ter pelo menos 3 caracteres";
    }
    return null;
  }
}
