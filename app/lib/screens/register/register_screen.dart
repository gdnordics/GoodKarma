// ignore_for_file: unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/dimens.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/screens/register/widgets/sign_up_form.dart';
import 'package:good_karma_app/services/auth_service.dart';
import 'package:good_karma_app/utils/extension.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:good_karma_app/widgets/buttons/third_party_login_button.dart';
import 'package:good_karma_app/screens/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool selectTerms = false;
  final _signupFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "abc@email.com",
  );
  TextEditingController passwordController =
      TextEditingController(text: "Your password");
  final AuthService authservice = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSignUp(name, email, password, confirmPassword) async {
    try {
        await authservice.signup(name, email, password);
        final snackBar = SnackBar(content: Text('Registered successfully, Welcome!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
    } on PlatformException catch (error) {
      _showErrorDialog(error.message!);
    }
  }

  onGoBack() {
    Navigator.pop(context);
  }

  _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: BackAppBar.createAppBar(onGoBack),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Form(
                key: _signupFormKey,
                child: Column(
                  //margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignUpForm(onSignUp: onSignUp),
                    Column(children: [
                      const SizedBox(height: 20.0),
                      Text("OR", style: normalTextStyle.copyWith(
                        color:secondaryTextColor, fontSize: 16.0)),
                      const SizedBox(height: 10.0),
                      ThirdPartyLoginButton(
                        text: "Login with Google", 
                        image: "assets/google.png", 
                        onPressed: () => debugPrint("google login")
                      ),
                      const SizedBox(width: 20.0),
                       Center(
                        child: RichText(
                          text: TextSpan(
                              text: 'Already have an account?',
                              style: normalTextStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Sign in',
                                    style: mediumTextStyle.copyWith(
                                        color: primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushReplacement(
                                            SlideRightRoute(
                                                page: const LoginScreen()));
                                      })
                              ]),
                        ).addMarginBottom(kSpacingLarge),
                      ).addMarginTop(kSpacingStandard),
                    ])
                  ],
                ).wrapPaddingAll(kSpacingContainer),
              ),
            ),
          )),
    );
  }
}
