import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/widgets/buttons/forward_action_button.dart';
import 'package:good_karma_app/widgets/checkbox_form_widget.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';

class SignUpForm extends StatefulWidget {
  final Function onSignUp;

  const SignUpForm({
    Key? key, 
    required this.onSignUp,
    }) 
    : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String _name, _email, _password, _confirmPassword;
  late bool _acceptTerms;
  final _signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  onValidateName(input) {
    if (input!.trim().isEmpty) {
      return "Please enter a name";
    }
    return null;
  }

  onValidateEmail(input) {
    if (!(input!.contains('@'))) {
      return "Invalid email";
    }
    return null;
  }

  onValidatePassword(input) {
    return null;
  }

  onValidateConfirmPassword(input) {
    //if (input != _password) {
    //  return "Must be the same as password";
    //}
    return null;
  }

  onSaveName(input) {
    _name = input;
  }

  onSaveEmail(input) {
    _email = input;
  }

  onSavePassword(input) {
    _password = input;
  }

  onSaveConfirmPassword(input) {
    _confirmPassword = input;
  }

  onSignUp() {
    if (_signupFormKey.currentState!.validate()) {
      _signupFormKey.currentState!.save();
      widget.onSignUp(_name, _email, _password, _confirmPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Text(
              "Sign up",
              style: normalTextStyle.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
              TextFormWidget(
                  hintText: "Full name",
                  icon: Icon(Icons.person_outlined, color: kEditTextPrimaryColor),
                  onValidation: onValidateName,
                  onSaved: onSaveName,
              ),
              const SizedBox(height: 8.0),
              TextFormWidget(
                  hintText: "abc@email.com",
                  icon: Icon(Icons.email_outlined, color: kEditTextPrimaryColor),
                  onValidation: onValidateEmail,
                  onSaved: onSaveEmail,
              ),
              const SizedBox(height: 8.0),
              TextFormWidget(
                hintText: "Your password",
                icon: Icon(Icons.lock_outlined, color: kEditTextPrimaryColor),
                onValidation: onValidatePassword,
                onSaved: onSavePassword,
                obscureText: true,
              ),  
              const SizedBox(height: 8.0),
              TextFormWidget(
                hintText: "Confirm password",
                icon: Icon(Icons.lock_outlined, color: kEditTextPrimaryColor),
                onValidation: onValidateConfirmPassword,
                onSaved: onSaveConfirmPassword,
                obscureText: true,
              ),
              const SizedBox(height: 8.0),
            ])
          ),
          const SizedBox(height: 36.0),
          Container(
            alignment: Alignment.center,
            child: ForwardActionButton(
                  text: "SIGN UP",
                  onPressed: onSignUp,
            )

          )
        ]
      ),
    );
  }
}