import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/widgets/appbar/top_karma_logo.dart';

class SearchAppBar extends StatelessWidget {
  final Function() onSearch;

  const SearchAppBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 85,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          color: panelColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x339E9E9E),
              blurRadius: 5,
              spreadRadius: 4
            )
          ]
        ),
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                  Icons.search_outlined,
                  color: primaryColor,
                  size: 32.0,
                ),
                ),
                onTap: onSearch,
              ),
              TopKarmaLogo(),
              SizedBox(height: 32, width: 32)
            ],
          ));
  }
}
