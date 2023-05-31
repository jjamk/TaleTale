import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/breakpoint.dart';
import 'package:flutter_application_1/responsive/responsive_center.dart';
import 'package:flutter_application_1/signin.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: ResponsiveCenter(
        child: SignIn(),
        maxContentWidth: BreakPoint.deskTop,
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
