import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<LoginViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF188095), Color(0xFF2AB3C6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
            child: const Stack(
              children: [
                // Centered text
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'STC\nHEALTH',
                    style: TextStyle(
                        fontSize: 22,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                // Bottom left text
                Positioned(
                  bottom: 40,
                  left: 15,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                // Add padding to left and right
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  autofocus: false,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(32.0)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          //  _obscureText = !_obscureText;
                        });
                      },
                      child: const Icon(
                        Icons.account_circle_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obsecurePassword.value,
                        focusNode: passwordFocusNode,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(32.0)),
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_open_rounded),
                          suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                              child: Icon(_obsecurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility)),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: height * .055,
              ),
              RoundButton(
                title: 'Login',
                loading: authViewMode.loading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage('Please enter email', context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Please enter password', context);
                  } else if (_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        'Please enter 6 digit password', context);
                  } else {
                    Map data = {
                      'username': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };

                    // Map data = {
                    //   'email' : 'eve.holt@reqres.in',
                    //   'password' : 'cityslicka',
                    // };

                    authViewMode.loginApi(data, context);
                    print('api hit');
                  }
                },
              ),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.home);
                  },
                  child: const Text("Need Help?")),
            ],
          ),
        )
      ],
    ));
  }
}
