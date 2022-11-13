import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/dimens.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/screens/login/login_screen.dart';
import 'package:good_karma_app/screens/register/register_screen.dart';
import 'package:good_karma_app/utils/extension.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';

class PasswordResetConfirmScreen extends StatefulWidget {
  static const String id = 'password_reset_confirm_screen';
  const PasswordResetConfirmScreen({Key? key}) : super(key: key);

  @override
  _PasswordResetConfirmScreenState createState() => _PasswordResetConfirmScreenState();
}

class _PasswordResetConfirmScreenState extends State<PasswordResetConfirmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBackwards() {
    Navigator.pop(context);
  }

  onReturnToLogin() {
    Navigator.pop(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset email sent",
                  style: mediumTextStyle.copyWith(fontSize: kTextSizeXLarge),
                ),
                const SizedBox(height: kSpacingContainer),
                Text('A email has been sent with instructions on how to reset your password', style: mediumTextStyle)
                    .addMarginTop(kSpacingContainer),
                const SizedBox(height: kSpacingContainer),
                Center(
                    child: ActionButton(
                        width: 252,
                        height: 58,
                        text: "RETURN TO LOGIN",
                        onPressed: onReturnToLogin)),
              ],
            ).wrapPaddingAll(kSpacingContainer),
          )),
    );
  }
}
