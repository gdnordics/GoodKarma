import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/eula_dialog.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    Key? key,
    }) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  onShowUserAgreement() {
    showDialog(
      context: context, 
      builder: (BuildContext ctx) {
        return EULADialog(onClose: () {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 72.0,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Information",
                            style: normalTextStyle.copyWith(fontSize: 24.0)))
                  ]))),
      Expanded(
          child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 50.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        ActionButton(
                          text: "End-User License Agreement", 
                          onPressed: onShowUserAgreement,
                          width: 250,
                          height: 52,)
                      ])
      ))
    ]);
  }
}
