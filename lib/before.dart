import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/signin.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'page/app.dart';

class Before extends StatefulWidget {
  const Before({Key? key}) : super(key: key);

  @override
  State<Before> createState() => _BeforeState();
}

class _BeforeState extends State<Before> {
  @override
  Widget build(BuildContext context) {
    //_permission();
    //_logout();
    //_auth();
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_permission();
    //_logout();
    _auth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _permission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  _auth() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(() => const SignIn());
      } else {
        Get.off(() => const App());
      }
    });
  }
}
