import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';

class ProfileDescription extends StatelessWidget {
  final String description;

  const ProfileDescription({
    Key? key,
    required this.description
  }) : super(key: key);

  void onReadMore() {
    debugPrint("Pressed Read More");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "",
            style: normalTextStyle.copyWith(
                fontSize: 18.0, color: Color(0xFF120D26)),
          ),
          SizedBox(height: 10.0),
          Text(
              description,
              style: normalTextStyle.copyWith(
                  fontSize: 16.0, color: Color(0xFF3C3E56)),
              maxLines: 3),
           SizedBox(height: 5.0),
          // InkWell(
          //   child: Text("Read More",
          //       style: normalTextStyle.copyWith(
          //           fontSize: 16.0, color: Color(0xFF6B7AED))),
          //   onTap: onReadMore,
          // )
        ]));
  }
}