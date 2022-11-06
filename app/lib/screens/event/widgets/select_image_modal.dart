import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/utils/extension.dart';

class SelectImageModal extends StatelessWidget {
  final void Function(ImageSource) onSourceSelected;
  final double width;

  const SelectImageModal({
    Key? key,
    required this.onSourceSelected,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      width: width,
                      height: 60,
                      alignment: Alignment.center,
                      child: Text("Choose option",
                              style: boldTextStyle.copyWith(
                                  fontSize: 20.0, color: Colors.white))
                          .wrapPaddingAll(16.0),
                      color: primaryColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Column(
                          children: [
                            Container(
                              child: const Icon(Icons.camera_alt_rounded,
                                      color: primaryColor, size: 45)
                                  .wrapPaddingAll(24),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: primaryColor),
                                shape: BoxShape.circle,
                              ),
                              height: 120,
                            ),
                            Text("Camera",
                                style: boldTextStyle.copyWith(
                                    color: primaryColor))
                          ],
                        ),
                        onTap: () {
                          onSourceSelected(ImageSource.camera);
                        },
                      ).wrapPaddingAll(16.0),
                      InkWell(
                        child: Column(
                          children: [
                            Container(
                              child: const Icon(Icons.photo_library_rounded,
                                      color: primaryColor, size: 45)
                                  .wrapPaddingAll(24),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: primaryColor),
                                shape: BoxShape.circle,
                              ),
                              height: 120,
                            ),
                            Text("Gallery",
                                style: boldTextStyle.copyWith(
                                    color: primaryColor))
                          ],
                        ),
                        onTap: () {
                          onSourceSelected(ImageSource.gallery);
                        },
                      ).wrapPaddingAll(16.0)
                    ],
                  )
                ],
              )),
        ));
  }
}
