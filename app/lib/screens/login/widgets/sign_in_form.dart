import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/widgets/buttons/forward_action_button.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';

class SignInForm extends StatefulWidget {
  final Function onSignIn;
  final Function onForgotPassword;

  const SignInForm({
    Key? key, 
    required this.onSignIn,
    required this.onForgotPassword
    }) 
    : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late String _email, _password;
  late bool _rememberMe;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _rememberMe = true;
    super.initState();
  }

  onValidateEmail(input) {
    if (!(input!.contains('@'))) {
      return "Invalid email";
    }
    return null;
  }

  onSaveEmail(input) {
    _email = input;
  }

  onSavePassword(input) {
    _password = input;
  }

  onValidatePassword(input) {
    return null;
  }

  onRemeberMeUpdate(remember) {
    setState(() {
      _rememberMe = remember;
    });
  }

  onSignIn() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      widget.onSignIn(_email, _password, _rememberMe);
    }
  }

  onForgotPassword() {
    widget.onForgotPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              "Sign in",
              style: normalTextStyle.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormWidget(
                    hintText: "abc@email.com",
                    maxLines: 1,
                    icon: Icon(Icons.email_outlined, color: kEditTextPrimaryColor),
                    onValidation: onValidateEmail,
                    onSaved: onSaveEmail,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormWidget(
                    hintText: "Your password",
                    maxLines: 1,
                    icon: Icon(Icons.lock_outlined, color: kEditTextPrimaryColor),
                    onValidation: onValidatePassword,
                    onSaved: onSavePassword,
                    obscureText: true,
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20.0),
                  InkWell(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Forgot password?",
                        style: mediumTextStyle.copyWith(fontSize: 14.0)
                      )
                    ),
                    onTap: onForgotPassword
                  ),
                ],
              )
              
            ])
          ),
          const SizedBox(height: 36.0),
          Container(
            alignment: Alignment.center,
            child: ForwardActionButton(
                  text: "SIGN IN",
                  onPressed: onSignIn,
            )

          )
        ]
      ),
    );
  }
}