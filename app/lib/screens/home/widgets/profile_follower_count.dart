import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';

class ProfileFollowerCount extends StatelessWidget {
  final int followers;
  final int following;

  const ProfileFollowerCount({
    Key? key,
    required this.followers,
    required this.following
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10.0),
        width: 76,
        height: 60,
        child: Column(children: [
          Text(
            followers.toString(),
            style:
                normalTextStyle.copyWith(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Flexible(
            child: Text(
              "Followers",
              style: normalTextStyle.copyWith(
                  fontSize: 14.0, color: Color(0xFF747688)),
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
      Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: VerticalDivider(thickness: 1.0, color: Color(0xFFDDDDDD))),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10.0),
        width: 76,
        height: 60,
        child: Column(children: [
          Text(
            following.toString(),
            style:
                normalTextStyle.copyWith(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Flexible(
            child: Text(
              "Following",
              style: normalTextStyle.copyWith(
                  fontSize: 14.0, color: Color(0xFF747688)),
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
    ]);
  }
}