import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/dimens.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/main.dart';
import 'package:good_karma_app/screens/login/forgot_password_screen.dart';
import 'package:good_karma_app/screens/login/widgets/sign_in_form.dart';
import 'package:good_karma_app/screens/register/register_screen.dart';
import 'package:good_karma_app/services/auth_service.dart';
import 'package:good_karma_app/utils/extension.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/buttons/third_party_login_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authservice = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSignIn(email, password, rememberMe) async {
    try {
      debugPrint(
          "[SignIn] email: $email, password: $password, rememberMe: $rememberMe");
      await authservice.login(email, password);
      Navigator.of(context)
          .pushReplacement(SlideRightRoute(page: const App()));
    } on PlatformException catch (error) {
      _showErrorDialog(error.message!);
    }
  }

  onGoogleSignIn() async {
    try {
      debugPrint("[SignIn Google]");
      await authservice.signInWithGoogle();
      Navigator.of(context)
          .pushReplacement(SlideRightRoute(page: const App()));
    } on PlatformException catch (error) {
      _showErrorDialog(error.message!);
    }
  }

  onForgotPassword() {
    Navigator.of(context)
        .push(SlideRightRoute(page: const ForgotPasswordScreen()));
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    Container(
                        alignment: Alignment.center,
                        height: 72,
                        child: Image.asset(
                          "assets/logos/logo_text.png",
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(height: 60.0),
                    SignInForm(
                        onSignIn: onSignIn, onForgotPassword: onForgotPassword),
                    Column(children: [
                      const SizedBox(height: 20.0),
                      Text("OR",
                          style: normalTextStyle.copyWith(
                              color: secondaryTextColor, fontSize: 16.0)),
                      const SizedBox(height: 10.0),
                      ThirdPartyLoginButton(
                          text: "Login with Google",
                          image: "assets/google.png",
                          onPressed: () => onGoogleSignIn()),
                      const SizedBox(width: 20.0),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: normalTextStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Sign up',
                                    style: mediumTextStyle.copyWith(
                                        color: primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                            SlideRightRoute(
                                                page: const RegisterScreen()));
                                      })
                              ]),
                        ).addMarginBottom(kSpacingLarge),
                      ).addMarginTop(kSpacingStandard),
                    ])
                  ],
                ).wrapPaddingAll(kSpacingContainer),
              ),
            ),
          ),
    );
  }
}
