// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/breakpoint.dart';

class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    Key? key,
    this.maxContentWidth = BreakPoint.tablet,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: maxContentWidth,
      child: Padding(
        padding: padding,
        child: child,
      ),
    ));
  }
}
