import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_dac/src/api/api.dart';
import 'package:projet_dac/src/api/user_model.dart';
import '../widgets/theappbar.dart';

import 'package:projet_dac/src/widgets/custom_footer.dart';

import 'package:google_fonts/google_fonts.dart';

//cas ou plusieurs modifs

class UserPage extends StatefulWidget {
  static const routeName = '/user';
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserInfo? userInfo;

  bool lock = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      userInfo = await Api.getUserInfo();
      emailController.text = userInfo!.email;
      firstNameController.text = userInfo!.firstName;
      lastNameController.text = userInfo!.lastName;
      passwordController.text = userInfo!.lastName;
    } on NoTokenExeption {
      setState(() {
        lock = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found, please log again')),
      );
    } catch (e) {
      setState(() {
        lock = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Unable to fetch User Info please try again')),
      );
    }
  }

  bool _hasChanged() {
    bool result = emailController.text != userInfo!.email ||
        firstNameController.text != userInfo!.firstName ||
        lastNameController.text != userInfo!.lastName ||
        passwordController.text != userInfo!.lastName;

    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have not changed your informations')),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Container(
            //height: 1000,
            constraints: BoxConstraints(maxWidth: width),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/trader_large.png',
                      fit: BoxFit.cover,
                      width: width,
                      height: height * 0.445,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: width * 0.05, left: width * 0.05),
                        child: Text(
                          "Your informations are safe, \n here",
                          style: GoogleFonts.varela(
                              textStyle: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    //height: 400,
                    child: Container(
                  color: const Color.fromARGB(255, 194, 204, 204),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.05),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: width * 0.3,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 217, 239, 240),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Please, make sure your infomation are up to date :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color:
                                            Color.fromARGB(255, 0, 119, 107)),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  enabled: lock,
                                  controller: emailController,
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  enabled: lock,
                                  controller: firstNameController,
                                  decoration: const InputDecoration(
                                      labelText: 'First Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  enabled: lock,
                                  controller: lastNameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Last Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  enabled: lock,
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              _hasChanged()) {
                                            //String? result; result= await if necessary
                                            try {
                                              await Api.modifyUserInfo(
                                                  firstNameController.text,
                                                  lastNameController.text,
                                                  emailController.text,
                                                  passwordController.text);
                                              if (context.mounted) {
                                                _getData(); // mouai
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Successfully Saved')),
                                                );
                                              }
                                            } on NoTokenExeption {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'No Token found, please log again')),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Unabled to Saved, please make sure your informations are correct and try again')),
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 119, 107)),
                                        child: const Text('Save Account'),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showAlertDialog(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 235, 1, 1)),
                                        child: const Text('Delete Account'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 0.10 * width),
                      SizedBox(
                        width: width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            '"We value your privacy at the highest level, thus you can modify your informations at all time. Please make sure they are correct"',
                            style: GoogleFonts.varela(
                                textStyle: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                const CustomFooter(),
              ],
            ),
          ),
        ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 235, 1, 1)),
    onPressed: () async {
      Navigator.pop(context);
      try {
        await Api.deleteUserInfo();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account Successfully deleted')));
        }
        await Api.logout();
        if (context.mounted) context.go("/");
      } on NoTokenExeption {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Token found, please log again')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unabled to Delete')),
        );
      }
    },
    child: const Text("Delete"),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete Account"),
    content: const Text("Are you sure to delete your account?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
