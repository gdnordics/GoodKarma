import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/dimens.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/screens/login/login_screen.dart';
import 'package:good_karma_app/screens/login/password_reset_confirm_sceen.dart';
import 'package:good_karma_app/screens/register/register_screen.dart';
import 'package:good_karma_app/utils/extension.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password_screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _resetPasswordFormKey = GlobalKey<FormState>();
  late String _email;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  onBackwards() {
    Navigator.pop(context);
  }

  onResetPassword() async {
    if(_resetPasswordFormKey.currentState!.validate()) {
      _resetPasswordFormKey.currentState!.save();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);

      Navigator.pushReplacement(context, SlideRightRoute(
        page: const PasswordResetConfirmScreen()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: BackAppBar.createAppBar(onBackwards),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Form(
              key: _resetPasswordFormKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset password",
                  style: mediumTextStyle.copyWith(fontSize: kTextSizeXLarge),
                ),
                const SizedBox(height: kSpacingContainer),
                Text('Enter your login email below.', style: mediumTextStyle)
                    .addMarginTop(kSpacingContainer),
                Text('We will send you an email with link to reset your password.',
                        style: mediumTextStyle)
                    .addMarginTop(kSpacingContainer),
                const SizedBox(height: kSpacingLarge),
                Text("Email", style: mediumTextStyle)
                    .addMarginLeft(kSpacingControl),
                TextFormWidget(
                  hintText: "abc@email.com",
                  maxLines: 1,
                  icon:Icon(Icons.email_outlined, color: kEditTextPrimaryColor),
                  onValidation: onValidateEmail,
                  onSaved: onSaveEmail,
                ),
                const SizedBox(height: kSpacingContainer),
                Center(
                    child: ActionButton(
                        width: 252,
                        height: 58,
                        text: "SEND EMAIL LINK",
                        onPressed: onResetPassword)),
                InkWell(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Not a member yet?',
                          style: mediumTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign up',
                                style: mediumTextStyle.copyWith(
                                    color: primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        SlideRightRoute(
                                            page: const RegisterScreen()));
                                  })
                          ]),
                    ).addMarginBottom(kSpacingLarge),
                  ).addMarginTop(kSpacingStandard),
                  onTap: () => {
                    Navigator.of(context).pushReplacement(
                        SlideRightRoute(page: const LoginScreen()))
                  },
                ),
              ],
            ).wrapPaddingAll(kSpacingContainer),
          )),
    ));
  }
}
