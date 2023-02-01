import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType { login, register }

const Color textcolor = Color.fromARGB(255, 4, 138, 129);
const Color boxcolor = Color.fromARGB(52, 8, 246, 246);

class _LoginPageState extends State<LoginPage> {
  FormType _form = FormType.login;

  void _formChange() => setState(() =>
      _form = _form == FormType.register ? FormType.login : FormType.register);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 50,
              ),
              _buildBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox() {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            color: boxcolor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _form == FormType.login
                    ? "Welcome back ! Please, login."
                    : "Welcome ! Please, register.",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textcolor),
              ),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            if (_form == FormType.register)
              const TextField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(_form == FormType.login ? 'Login' : 'Register'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _formChange,
              child: Text(_form == FormType.login
                  ? 'Dont have an account? Click here to register.'
                  : 'Already have an account ? Click here to login.'),
            ),
          ],
        ),
      ),
    );
  }
}
