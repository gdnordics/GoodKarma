import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/screens/volunteer_requests/models/volunteer_request.dart';

class VolunteerTile extends StatelessWidget {
  final VolunteerRequest request;
  final Function(String) onPressed;

  const VolunteerTile({
    required this.request,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(26.0)),
                  child: SizedBox.fromSize(
                      size: Size(52.0, 52.0),
                      child: Image.asset(
                        "assets/icon.png",
                        fit: BoxFit.cover,
                      ))),
      title: Text(request.user.name ?? "-"),
      subtitle: Text("${request.user.attendedEvents} Events volunteered"),
      trailing: InkWell(
        child: Icon(
          Icons.arrow_forward_ios,
          color: primaryTextColor
        ),
      ),
      onTap: () => onPressed(request.request.requesterId),
    );
  }
}