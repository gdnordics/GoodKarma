import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_widget.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_loading.dart';

class EventsLoadingScreen extends StatefulWidget {
  const EventsLoadingScreen({Key? key}) : super(key: key);

@override
  _EventsLoadingScreenState createState() =>
      _EventsLoadingScreenState();
}


class _EventsLoadingScreenState extends State <EventsLoadingScreen>{

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      //scroll view 
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
      color: Colors.transparent,
      height: 853,
      child: Shimmer(
        linearGradient: Shimmer.shimmerGradient,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SizedBox(height: 10),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 365,
              height: 101,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        SizedBox(height: 10),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 365,
              height: 101,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        SizedBox(height: 10),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 365,
              height: 101,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        SizedBox(height: 10),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 365,
              height: 101,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      )
    ))));
  }
}