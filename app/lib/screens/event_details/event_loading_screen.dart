import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_widget.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_loading.dart';

class EventLoadingScreen extends StatefulWidget {
  const EventLoadingScreen({Key? key}) : super(key: key);

@override
  _EventLoadingScreenState createState() =>
      _EventLoadingScreenState();
}


class _EventLoadingScreenState extends State <EventLoadingScreen>{

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

      color: Colors.white,
      height: 853,
      child: Shimmer(
        linearGradient: Shimmer.shimmerGradient,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 148.0,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 20.0),
              width: 360,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          //start here
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 20.0),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 20.0),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 20.0),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 20.0),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 20.0),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        //end here
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 60.0),
              width: 272,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )
        ],
      )
    ))));
  }
}