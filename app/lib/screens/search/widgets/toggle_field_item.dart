import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class ToggleFieldItem extends StatefulWidget {
  final String label;
  final String value;
  final bool selected;
  final Function(String) onToggle;

  const ToggleFieldItem({
    Key? key,
    required this.label,
    required this.value,
    required this.selected,
    required this.onToggle
  }) : super(key: key);

  @override
  _ToggleFieldItemState createState() => _ToggleFieldItemState();

}

class _ToggleFieldItemState extends State<ToggleFieldItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: widget.selected ? primaryLightGreenColor : toggleFieldColor
        ),
        child: Text(
          widget.label,
          style: boldTextStyle.copyWith(
            fontSize: 16.0,
            color: widget.selected ? toggleFieldActiveTextColor : toggleFieldTextColor
          ),
        ),
      ),
      onTap: () => widget.onToggle(widget.value),
    );
  }
}