import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';

class ProfileInterests extends StatelessWidget {
  final List<String> interests;

  const ProfileInterests({
    Key? key,
    required this.interests 
  }) : super(key: key);

  Widget buildInterestBlock(String name, Color bgcolor) {
    return 
    UnconstrainedBox(
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.all(Radius.circular(40.0)) 
      ),
      child: Text(
        name,
        style: normalTextStyle.copyWith(
          fontSize: 14.0,
          color: Colors.white
        ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
        Text(
            "Volunteering Interest",
            style: normalTextStyle.copyWith(
                fontSize: 18.0, color: Color(0xFF120D26)),
          ),
          SizedBox(height: 10.0),
        Wrap(
          alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 10,
        children: [
          buildInterestBlock("Environment", Colors.purple),
          buildInterestBlock("Education", Colors.red),
          buildInterestBlock("Health", Colors.green),
          buildInterestBlock("Others", Colors.blue),
        ])])
    );
  }

}