import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class EULADialog extends StatelessWidget {
  final VoidCallback onClose;

  const EULADialog({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  Future<String> getEULA(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/text/eula.txt');
  }

  @override
  Widget build(BuildContext context) {
    return   AlertDialog(
                title: const Text("End-User License Agreement"),
                content: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
                  width: 300,
                  height: 500,
                  padding: const EdgeInsets.only(bottom: 50.0),
        child: FutureBuilder<String>(
          future: getEULA(context),
          builder:
              (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    String text = snapshot.data;
                    return Markdown(data: text);
                  }
                  return const SizedBox(height: 10);
              }))),
            actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onClose();
                    },
                    child: const Text("Close")
                  )
                ]);
  }
}