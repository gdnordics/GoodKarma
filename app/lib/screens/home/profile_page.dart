import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/home/widgets/profile_avatar.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:provider/provider.dart';
import 'package:good_karma_app/widgets/eula_dialog.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onLogout;

  const ProfilePage({
    Key? key,
    required this.onLogout
    }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<AppUser> getUserInformation() async {
    String currentUserId = Provider.of<UserData>(context, listen: false).currentUserId!;
    return await Provider.of<DatabaseService>(context, listen: false).getUser(currentUserId);
  }

  void onEditProfile() {
    debugPrint("Edit Profile pressed!");
  }

  onShowUserAgreement() {
    showDialog(
      context: context, 
      builder: (BuildContext ctx) {
        return EULADialog(onClose: () {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 72.0,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              decoration: const BoxDecoration(
              color: panelColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0x339E9E9E),
                  blurRadius: 5,
                  spreadRadius: 4
                )
              ]
            ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Profile",
                            style: normalTextStyle.copyWith(fontSize: 24.0))),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(
                      child: Icon(
                        Icons.logout_rounded,
                        size: 24.0),
                      onTap: widget.onLogout,
                    ))
                  ]))),
      Expanded(
          child: FutureBuilder(
            future: getUserInformation(),
            builder: 
              (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  AppUser user = snapshot.data;
                  return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                },
              ),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(children: [
                        ProfileAvatar(
                          imagePath: user.profileImageUrl, 
                          name: user.name ?? ""),
                        const SizedBox(height: 40.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          alignment: Alignment.center,
                          child: Column(children: [
                            Text(
                            "Empowering communities through connecting volunteers and fostering kindness, one act of service at a time.", 
                            textAlign: TextAlign.center,
                          style: normalPromptTextStyle.copyWith(
                            fontSize: 20.0,
                            color: const Color(0xFF366740)
                          )),
                          SizedBox(height: 5.0),
                          Text(
                            "#GoodKarma", 
                            textAlign: TextAlign.center,
                          style: normalPromptTextStyle.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ))
                          
                          ])
                        ),
                        const SizedBox(height: 50.0),
                        ActionButton(
                          text: "End-User License Agreement", 
                          onPressed: onShowUserAgreement,
                          width: 250,
                          height: 52),
                      ]))));
                } else {
                  return const SizedBox(height: 50.0);
                }
              })
      )
    ]);
  }
}
