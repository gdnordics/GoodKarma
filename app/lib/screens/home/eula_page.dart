import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/loading/main_loading_screen.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:provider/provider.dart';

class EULAPage extends StatefulWidget {
  static const String id = 'home_screen';
  final String userId;
  final Function(dynamic) onAccept;

  const EULAPage({
    Key? key,
    required this.userId,
    required this.onAccept
  }) : super(key: key);

  @override
  _EULAPageState createState() => _EULAPageState();
}

class _EULAPageState extends State<EULAPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<String> getEULA(BuildContext context) async {
    return await DefaultAssetBundle.of(context)
        .loadString('assets/text/eula.txt');
  }

  onAcceptEULA() async {
    await Provider.of<DatabaseService>(context, listen: false).setAcceptedEULA(widget.userId);
    widget.onAccept("accepted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          backgroundColor: backgroundColor,
          body: FutureBuilder(
        future: getEULA(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String text = snapshot.data;
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
                                child: Text("End-User License Agreement",
                                    style: normalTextStyle.copyWith(
                                        fontSize: 24.0)))
                          ]))),
              Expanded(
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 200),
                                      height: 700,
                                      child: Markdown(data: text)
                                    ))),
                            const SizedBox(height: 20),
                            ActionButton(
                              text: "Accept",
                              onPressed: onAcceptEULA,
                              width: 250,
                              height: 52,
                            ),
                            const SizedBox(height: 20)
                          ]))
            ]);
          }
          return const MainLoadingScreen();
        })   
    );
  }
}
