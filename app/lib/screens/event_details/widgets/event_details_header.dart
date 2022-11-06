import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/utils/extension.dart';

class EventDetailsHeader extends StatelessWidget {
  final VoidCallback onBackward;
  final VoidCallback onDelete;
  final bool enableDelete;

  const EventDetailsHeader({
      Key? key,
      required this.onBackward,
      required this.onDelete,
      required this.enableDelete
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    InkWell(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.arrow_back,
                                size: 32.0, color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text('Event Details',
                            style: boldTextStyle.copyWith(
                                fontSize: 24.0, color: Colors.white),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis)
                        .addMarginLeft(16.0),
                  ]),
                  enableDelete
                      ? InkWell(
                          child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(136, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              child: Center(
                                child: Icon(
                                  Icons.delete_rounded,
                                    size: 26.0, 
                                    color: deleteEventIconColor))),
                          onTap: onDelete)
                      : SizedBox(width: 34, height: 34),
                ]));
  }
}
