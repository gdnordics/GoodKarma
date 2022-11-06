import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class KarmaBottomNavBar extends StatelessWidget {
  final String selected;
  final VoidCallback onExplorePressed;
  final VoidCallback onMyEventsPressed;
  final VoidCallback onInfoPressed;
  final VoidCallback onProfilePressed;
  final VoidCallback onAddEventPressed;

  const KarmaBottomNavBar(
      {Key? key,
      required this.selected,
      required this.onExplorePressed,
      required this.onMyEventsPressed,
      required this.onInfoPressed,
      required this.onProfilePressed,
      required this.onAddEventPressed})
      : super(key: key);

  buildMenuButton(
      bool isSelected, VoidCallback action, IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: TextButton(
        child: Column(
          children: [
            Icon(icon, color: isSelected ? primaryLightGreenColor : secondaryTextColor),
            Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: boldTextStyle.copyWith(
                    color: isSelected ? primaryLightGreenColor : secondaryTextColor,
                    fontSize: 12.0),
              ),
            )
          ],
        ),
        onPressed: action,
      ),
    );
  }

  buildKarmaButton(VoidCallback action, IconData icon, String text) {
    return TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)
          ),
          onPressed: action,
          child: Column(
            children: [
              Icon(icon, color: primaryLightGreenColor, size: 56),
              Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: normalKarmaTextStyle.copyWith(
                      color: primaryDarkGreenColor, fontSize: 12.0),
                ),
              )
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 88.0,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          buildMenuButton(selected == "explore", onExplorePressed,
              Icons.explore, "Explore"),
          buildMenuButton(selected == "myevents", onMyEventsPressed,
              Icons.calendar_month_rounded, "My Events"),
          buildKarmaButton(
              onAddEventPressed, Icons.add_circle_rounded, "KARMA"),
          buildMenuButton(selected == "profile", onProfilePressed,
              Icons.person_rounded, "Profile"),
          buildMenuButton(
              selected == "info", onInfoPressed, Icons.info, "Info"),
        ]));
  }
}
