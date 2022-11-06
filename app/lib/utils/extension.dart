import 'package:flutter/material.dart';

extension WidgetExtension on Widget {

  Widget wrapPadding({EdgeInsets padding = const EdgeInsets.all(0)}) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget addAlignment(Alignment alignment) {
    return Align(
      child: this,
      alignment: alignment,
    );
  }

  Widget wrapPaddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget wrapPaddingHorizontal(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget wrapPaddingVertical(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  Widget clipRectAll(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: this,
    );
  }

  Widget clipRect(BorderRadius radius) {
    return ClipRRect(
      borderRadius: radius,
      child: this,
    );
  }

  addMarginBottom(double margin) {
    return Column(children: [
      this,
      SizedBox(
        height: margin,
      )
    ]);
  }

  addMarginTop(double margin) {
    return Column(children: [
      SizedBox(
        height: margin,
      ),
      this,
    ]);
  }

  addMargin(double margin) {
    return Container(margin: EdgeInsets.all(margin), child: this);
  }

  addMarginRight(double margin) {
    return Padding(
      padding: margin.paddingRight(),
      child: this,
    );
  }

  addMarginLeft(double margin) {
    return Padding(
      padding: margin.paddingLeft(),
      child: this,
    );
  }

  addMarginVertical(double margin) {
    return Padding(
      padding: margin.paddingVertical(),
      child: this,
    );
  }

  addMarginHorizontal(double margin) {
    return Container(
      padding: margin.paddingHorizontal(),
      child: this,
    );
  }
}

extension ContextX on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension DoubleX on double {
  // margin EdgeInsets
  EdgeInsets marginLeft() => EdgeInsets.only(left: this);

  EdgeInsets marginRight() => EdgeInsets.only(right: this);

  EdgeInsets marginTop() => EdgeInsets.only(top: this);

  EdgeInsets marginBottom() => EdgeInsets.only(bottom: this);

  EdgeInsets marginAll() => EdgeInsets.all(this);

  EdgeInsets marginVertical() => EdgeInsets.symmetric(vertical: this);

  EdgeInsets marginHorizontal() => EdgeInsets.symmetric(horizontal: this);

  // padding EdgeInsets
  EdgeInsets paddingLeft() => EdgeInsets.only(left: this);

  EdgeInsets paddingRight() => EdgeInsets.only(right: this);

  EdgeInsets paddingTop() => EdgeInsets.only(top: this);

  EdgeInsets paddingBottom() => EdgeInsets.only(bottom: this);

  EdgeInsets paddingAll() => EdgeInsets.all(this);

  EdgeInsets paddingVertical() => EdgeInsets.symmetric(vertical: this);

  EdgeInsets paddingHorizontal() => EdgeInsets.symmetric(horizontal: this);
}
