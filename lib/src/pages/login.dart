import 'package:flutter/material.dart';
import 'package:projet_dac/src/api/api.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType { login, register }

const Color textcolor = Color.fromARGB(255, 4, 138, 129);
const Color boxcolor = Color.fromARGB(52, 8, 246, 246);

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  FormType _form = FormType.login;

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              Image.asset('assets/images/euronaze.png'),
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
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              if (_form == FormType.register)
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              if (_form == FormType.register)
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? result;
                    if (_form == FormType.login) {
                      try {
                        result = await Api.login(
                            emailController.text, passwordController.text);
                        if (result == "user") {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login success')),
                            );
                            context.go('/home');
                          }
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Login failed, please make sure your informations are correct and try again')),
                        );
                      }
                    } else {
                      try {
                        result = await Api.register(
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            passwordController.text);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Registration success')),
                          );
                          context.go('/home');
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Registration failed, please make sure your informations are correct and try again')),
                        );
                      }
                    }
                  }
                },
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
      ),
    );
  }
}
