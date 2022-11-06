import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/home/widgets/profile_avatar.dart';
import 'package:good_karma_app/screens/home/widgets/profile_description.dart';
import 'package:good_karma_app/screens/home/widgets/profile_event_score.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 72.0,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
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
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Column(children: [
                        ProfileAvatar(
                          imagePath: user.profileImageUrl, 
                          name: user.name ?? ""),
                        SizedBox(height: 20.0),
                        //ProfileEventScore(eventsVolunteered: 200, eventsOrganized: 344, karmaPoints: 50),
                        //SizedBox(height: 30.0),
                        //ProfileDescription(description: 
                        //  user.bio?.isEmpty ?? true ? 
                        //  "" : 
                        //  user.bio.toString() ),
                        SizedBox(height: 50.0),
                        //ProfileEditButton(onEditProfile: onEditProfile, text: "Edit Profile"),
                        SizedBox(height: 10.0),
                      ]))));
                } else {
                  return Text("loading...");
                }
              })
      )
    ]);
  }
}
