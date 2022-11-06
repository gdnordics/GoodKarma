import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_widget.dart';
import 'package:good_karma_app/widgets/shimmer/shimmer_loading.dart';

class VolunteerRequestScreen extends StatefulWidget {
  const VolunteerRequestScreen({Key? key}) : super(key: key);

@override
  _VolunteerRequestScreenState createState() =>
      _VolunteerRequestScreenState();
}


class _VolunteerRequestScreenState extends State <VolunteerRequestScreen>{

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
              //margin: const EdgeInsets.only(left: 20.0),
        children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                ShimmerLoading(
                  child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 25.0 ,horizontal: 12.0),
                  width: 93,
                  height: 93,
                  decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle
              ),
            ),
          ),
              ShimmerLoading(
                child: Container(
                margin: const EdgeInsets.symmetric(vertical: 48),
                width: 235,
                height: 40,
                decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
                SizedBox(height: 10),
          ],
        ),
        Column(
          children: [
            ShimmerLoading(
              child: Container(
              margin: const EdgeInsets.symmetric(vertical: 1.0 ,horizontal: 5.0),
              width: 350,
              height: 30,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10), 
            ShimmerLoading(
              child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0 ,horizontal: 20.0),
              width: 350,
              height: 65,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
            ShimmerLoading(
              child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0 ,horizontal: 20.0),
              width: 350,
              height: 65,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
            ShimmerLoading(
              child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0 ,horizontal: 20.0),
              width: 350,
              height: 65,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
            ShimmerLoading(
              child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0 ,horizontal: 20.0),
              width: 350,
              height: 65,
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],)
      ],
      ),
        )
      ),
      )
    );
  }
}