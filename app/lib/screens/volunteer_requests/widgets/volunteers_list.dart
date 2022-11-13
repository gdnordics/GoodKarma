import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/screens/volunteer_requests/models/volunteer_request.dart';
import 'package:good_karma_app/screens/volunteer_requests/models/volunteer_requests.dart';
import 'package:good_karma_app/screens/volunteer_requests/widgets/volunteer_tile.dart';

class VolunteersList extends StatefulWidget {
  final VolunteerRequests requests;
  final Function(String) onVolunteerPressed;

  const VolunteersList({
    required this.requests,
    required this.onVolunteerPressed,
  });

  _VolunteersListState createState() => _VolunteersListState();
}

class _VolunteersListState extends State<VolunteersList> {
  List<Widget> buildRequests(List<VolunteerRequest> requests) {
    List<VolunteerTile> tiles = [];
    for (var r in requests) {
      tiles.add(VolunteerTile(
        request: r,
        onPressed: widget.onVolunteerPressed,
      ));
    }
    return tiles;
  }

  Widget buildList(String text, List<VolunteerRequest> requests) {
    if (requests.isNotEmpty) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
                child:
                    Text(text, style: boldTextStyle.copyWith(fontSize: 20.0))),
            Column(children: buildRequests(requests)),
          ]);
    }
    return SizedBox(height: 5);
  }

  Widget buildRequestLists(VolunteerRequests requests) {
    if (requests.isNotEmpty()) {
      return Column(children: [
        buildList("Pending", requests.awaitingApproval),
        buildList("Approved", requests.approved),
        buildList("Reject", requests.rejected)
      ]);
    }
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
              alignment: Alignment.center,
              width: 250.0,
              child: Text(
                "Don't worry, soon people will join",
                style: normalKarmaTextStyle.copyWith(fontSize: 24.0),
                textAlign: TextAlign.center,
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: buildRequestLists(widget.requests)));
  }
}
