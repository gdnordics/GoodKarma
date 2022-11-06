import 'package:flutter/cupertino.dart';
import 'package:good_karma_app/helpers/style.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imagePath;
  final String name;

  const ProfileAvatar({
    Key? key,
    required this.imagePath,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.center,
            child: Column(children: [
              ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(48.0)),
                  child: SizedBox.fromSize(
                      size: Size(96.0, 96.0),
                      child: (imagePath != null && imagePath!.isNotEmpty) ? 
                      Image.network(
                        imagePath!,
                        fit: BoxFit.cover) :
                      Image.asset(
                        "assets/icon.png",
                        fit: BoxFit.cover,
                      ))),
              SizedBox(height: 10.0),
              Text(name,
                  style: boldTextStyle.copyWith(fontSize: 24.0))
            ]));
  }
}