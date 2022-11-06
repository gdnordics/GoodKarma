

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class CoverImage extends StatelessWidget {
  final VoidCallback onEditImage;
  final String? imagePath;
  final bool isNetworkImage;

  const CoverImage({
    Key? key,
    required this.onEditImage,
    required this.isNetworkImage,
    this.imagePath
  }) : super(key: key);

  displayImage(String imagePath) {
    if (isNetworkImage) {
      return Image.network(imagePath,
         errorBuilder: (context, url, error) => const Icon(Icons.error),
         fit: BoxFit.cover,
          width: double.infinity);
    }

    return Image.file(File(imagePath),
            errorBuilder: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Column(children: [
        Container(
            height: 150.0,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xFFd4d4d4)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: (imagePath == null || imagePath!.isEmpty)
                ? Center(
                    child: Text("ADD COVER IMAGE",
                        style: boldTextStyle.copyWith(
                            fontSize: 16.0, color: Color(0xFFC4C4C4))))
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: displayImage(imagePath!))),
        SizedBox(
          height: 20.0,
        )
      ]),
      Positioned(
          bottom: 0.0,
          child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: onEditImage,
              mini: true,
              child: Icon(Icons.edit)))
    ]);
  }
}