import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marker/src/bloc/user_bloc/user_bloc.dart';
import 'package:marker/src/config/route.dart' as custom_route;
import 'package:marker/src/constants/setting.dart';
import 'package:marker/src/models/credential_model.dart';
import 'package:marker/src/services/network_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late Credential _credential;

  @override
  void initState() {
    _credential = Credential(email: "", password: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Marker'),
          centerTitle: true,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.black26),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Icon(
                        FontAwesomeIcons.marker,
                        color: Colors.blueGrey,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Welcome to Marker',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _form,
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              bottom: 22, left: 22, right: 22),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            children: [
                              buildTextInput(
                                  label: 'E-mail',
                                  onSaved: (String? value) {
                                    _credential.email =
                                        value!.isEmpty ? "" : value;
                                  }),
                              buildTextInput(
                                  obscureText: true,
                                  label: 'Password',
                                  onSaved: (String? value) {
                                    _credential.password =
                                        value!.isEmpty ? "" : value;
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.blueGrey, width: 4)),
                                    width: double.infinity,
                                    child: TextButton(
                                        onPressed: () async {
                                          showLoading(
                                                  msg: 'Logging in...',
                                                  icon: Icons.login)
                                              .show(context);
                                          _form.currentState?.save();
                                          NetworkService()
                                              .userLogin(_credential)
                                              .then((result) {
                                            SharedPreferences.getInstance()
                                                .then((pref) {
                                              pref.setString(Setting.token,
                                                  result['token']);
                                              pref.setString(Setting.email,
                                                  result['email']);
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/',
                                                  (route) => false);
                                            });
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.blueGrey,
                                          padding: const EdgeInsets.all(12.0),
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        child: const Text('Login'))),
                              )
                            ],
                          ),
                        ),
                      ),
                      _buildTextButton('Forgot Password', onPressed: () {}),
                      _buildTextButton("Don't have account",
                          onPressed: () => Navigator.pushNamed(
                              context, custom_route.Route.signup)),
                      const SizedBox(height: 80)
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}

Padding buildTextInput(
    {required String label,
    required void Function(String?)? onSaved,
    bool obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextFormField(
      onSaved: onSaved,
      style: const TextStyle(
          color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey)),
          labelText: label,
          labelStyle: (const TextStyle(color: Colors.blueGrey))),
      obscureText: obscureText,
    ),
  );
}

TextButton _buildTextButton(String text,
    {required VoidCallback onPressed, double fontSize = 20}) {
  return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.blueGrey, fontSize: fontSize),
      ));
}

Flushbar<dynamic> showLoading({required String msg, required IconData icon}) {
  return Flushbar(
    message: msg,
    icon: Icon(
      icon,
      size: 28.0,
      color: Colors.orange,
    ),
    showProgressIndicator: true,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
  );
}
