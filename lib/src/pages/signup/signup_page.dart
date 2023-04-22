import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marker/src/models/credential_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late Credential _credential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XXX'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration:
            const BoxDecoration(color: Colors.black87),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white70,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Let's Mark",
                  style: TextStyle(
                      color: Colors.white70,
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
                                      color: Colors.blueGrey,
                                      width: 4)),
                              width: double.infinity,
                              child: TextButton(
                                  onPressed: () async { },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blueGrey,

                                    padding: const EdgeInsets.all(12.0),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  child: const Text('Sign up'))),
                        )
                      ],
                    ),
                  ),
                ),
                _buildTextButton('Back to Login', onPressed: () => Navigator.pop(context)),
                const SizedBox(height: 80)
              ],
            ),
          )
        ],
      )
    );
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
          color: Colors.black54,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.blueGrey)),
          labelText: label,
          labelStyle:
          (const TextStyle(color: Colors.blueGrey))),
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
        style: TextStyle(
            color: Colors.white70, fontSize: fontSize),
      ));
}

