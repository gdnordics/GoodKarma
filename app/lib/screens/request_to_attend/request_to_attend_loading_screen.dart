import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_widget.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_loading.dart';


class RequestAttendLoadingScreen extends StatefulWidget {
  const RequestAttendLoadingScreen({Key? key}) : super(key: key);

@override
  _RequestAttendLoadingScreenState createState() =>
      _RequestAttendLoadingScreenState();
}


class _RequestAttendLoadingScreenState extends State <RequestAttendLoadingScreen>{

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
          SizedBox(height: 75),
            ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0 ,horizontal: 30.0),
              width: 300,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0 ,horizontal: 30.0),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0 ,horizontal: 30.0),
              width: 300,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ShimmerLoading(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0 ,horizontal: 30.0),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          // SizedBox(height: 10),
          // ShimmerLoading(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 5.0 ,horizontal: 30.0),
          //     width: 300,
          //     height: 30,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
          // ShimmerLoading(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 5.0 ,horizontal: 30.0),
          //     width: 360,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 10),
          // ShimmerLoading(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 5.0 ,horizontal: 30.0),
          //     width: 300,
          //     height: 30,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
          // ShimmerLoading(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 5.0 ,horizontal: 30.0),
          //     width: 360,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
           SizedBox(height: 65),
          //send request button
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