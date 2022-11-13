import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event.dart';

class EventListItem extends StatelessWidget {
  final Event event;
  final Function(String) onEventPressed;

  const EventListItem({Key? key, required this.event, required this.onEventPressed})
      : super(key: key);

  Widget buildEventText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            DateFormat.yMMMd()
                .add_jm()
                .format(event.eventDateTime!),
            style:
                boldTextStyle.copyWith(color: primaryLightGreenColor, fontSize: 13.0)),
        Text(event.title!,
            style: boldTextStyle.copyWith(color: primaryDarkGreenColor, fontSize: 15.0)),
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(event.creatorName ?? "-",
              style:
                  boldTextStyle.copyWith(color: primaryLightGreenColor, fontSize: 12.0)),
        )
      ],
    );
  }

  Widget buildBannerImage(BuildContext context, String? imageUrl) {
    if (imageUrl == null) {
      return SizedBox(width: MediaQuery.of(context).size.width);
    }
    return Image.network(imageUrl,
                    errorBuilder: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onEventPressed(event.id!);
      },
      child: Container(
        height: 106.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
              child: SizedBox.fromSize(
                size: Size(89.0, 64.0),
                child: buildBannerImage(context, event.imageUrl),
              ),
            ),
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildEventText(),
                        SizedBox(height: 10.0),
                        Row(children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFF747688),
                            size: 14.0,
                          ),
                          SizedBox(width: 5.0),
                          Text(event.location!,
                              style: boldTextStyle.copyWith(
                                  color: Color(0xFF747688), fontSize: 13.0))
                        ])
                      ])))
        ]),
      ),
    );
  }
}
