import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_widget.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_loading.dart';

class VolunteerListLoadingScreen extends StatefulWidget {
  const VolunteerListLoadingScreen({Key? key}) : super(key: key);

@override
  _VolunteerListLoadingScreenState createState() =>
      _VolunteerListLoadingScreenState();
}


class _VolunteerListLoadingScreenState extends State <VolunteerListLoadingScreen>{

  Widget buildUserTile() {
    return 
    ShimmerLoading(child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 0.0 ,horizontal: 12.0),
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
                margin: const EdgeInsets.only(top: 2),
                height: 20,
                decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
            ),
             Container(
                margin: const EdgeInsets.only(top: 6),
                height: 20,
                decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
            )
        ])),
        SizedBox(width: 70)
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
        child: Container(
      color: Colors.white,
      child: Shimmer(
        linearGradient: Shimmer.shimmerGradient,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          buildUserTile(),
          SizedBox(height: 20),
          buildUserTile(),
          SizedBox(height: 20),
          buildUserTile(),
          SizedBox(height: 20),
          buildUserTile()
          // ShimmerLoading(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 20.0),
          //     width: 360,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
          // ShimmerLoading(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 20.0),
          //     width: 360,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // )
        ],
      )
    ))));
  }
}