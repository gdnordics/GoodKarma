import 'package:flutter/cupertino.dart';
import 'package:good_karma_app/screens/search/widgets/toggle_field_item.dart';

class MultiSelectFields extends StatefulWidget {
  final List<ToggleFieldItem> items;

  const MultiSelectFields({
    Key? key,
    required this.items
  }) : super(key: key);

  @override
  _MultiSelectFieldsState createState() => _MultiSelectFieldsState();

}

class _MultiSelectFieldsState extends State<MultiSelectFields> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 20.0,
      runSpacing: 15.0,
      children: widget.items,
    );
  }
}