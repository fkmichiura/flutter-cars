import 'package:carros_app/domain/services/login_service.dart';
import 'package:carros_app/pages/home_page.dart';
import 'package:carros_app/utils/alerts.dart';
import 'package:carros_app/utils/navigation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController(text: "teste");
  final _passController = TextEditingController(text: "1234567");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            height: 160,
            child: Image.asset("assets/logo/app_logo.png"),
          ),
          TextFormField(
              controller: _loginController,
              validator: _validateLogin,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.blue, fontSize: 22),
              decoration: InputDecoration(
                labelText: "Login",
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                hintText: "Digite o seu login:",
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
              )),
          TextFormField(
              controller: _passController,
              validator: _validatePass,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.blue, fontSize: 22),
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                hintText: "Digite a sua senha:",
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
                color: Colors.blue,
                child: _progress
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                onPressed: () {
                  _onClickLogin(context);
                }),
          )
        ],
      ),
    );
  }

  _onClickLogin(BuildContext context) async {
    final login = _loginController.text;
    final pass = _passController.text;

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final response = await LoginService.login(login, pass);

    if (response.isOk()) {
      navPush(context, HomePage());
    }
    else {
      loginAlert(context, "Atenção", response.msg);
    }

    setState(() {
      _progress = false;
    });
  }

  String _validateLogin(String login) {
    if (login.isEmpty) {
      return "Informe o login";
    }

    return null;
  }

  String _validatePass(String pass) {
    if (pass.isEmpty) {
      return "Informe a senha";
    }

    if (pass.length <= 5) {
      return "A senha deve ter mais que 5 dígitos";
    }

    return null;
  }
}
