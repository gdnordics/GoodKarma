import 'package:flutter/material.dart';

class BackAppBar extends StatelessWidget {
  final VoidCallback onBackwards;

  const BackAppBar({
    Key? key,
    required this.onBackwards
  }) : super(key: key);

  static PreferredSize createAppBar(VoidCallback onBackwards) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: BackAppBar(onBackwards: onBackwards));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      InkWell(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                              child: Icon(Icons.arrow_back,
                                  size: 32.0, color: Colors.black)),
                        ),
                        onTap: onBackwards,
                      )
                    ])
                  ]));
  }
}