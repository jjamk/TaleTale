import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page/app.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _userIdWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
      ),
      validator: (String? value) {
        if (value!.isEmpty) return '이메일을 입력해주세요';
        return null;
      },
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: (String? value) {
        if (value!.isEmpty) return '비밀번호를 입력해주세요';
        return null;
      },
    );
  }

  void authPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  signUpWithEmail(String email, String pw) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Get.offAll(() => const App());
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = '비밀번호를 더 길게 입력하세요';
        //logger.w('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        message = '이미 사용중인 이메일입니다.';
        // logger.w('The account already exists for that email.');
      }
      authPersistence(); // 인증 영속

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ),
      );
    }
  }

  Widget logo() {
    return CircleAvatar(
      backgroundImage: AssetImage(
        'assets/images/logo.png',
      ),
      radius: 70,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("회원가입"),
          leading: const BackButton(color: Color.fromARGB(255, 138, 43, 43)),
          centerTitle: true,
        ),
        body: Form(
          key: _scaffoldKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              logo(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 0.0),
                child: _userIdWidget(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 0.0),
                child: _passwordWidget(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 0.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 138, 43, 43)),
                  onPressed: () => signUpWithEmail(
                      _emailController.text, _passwordController.text),
                  child: Text("계정 생성"),
                ),
              ),
            ],
          ),
        ));
  }
}
