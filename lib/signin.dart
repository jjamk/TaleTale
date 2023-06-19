import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'signup.dart';
import 'package:flutter/cupertino.dart';

class currentuser {
  static String currentUserEmail = "";
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      keyboardType: TextInputType.visiblePassword,
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

  Widget logo() {
    return CircleAvatar(
      backgroundImage: AssetImage(
        'assets/images/logo.png',
      ),
      radius: 90,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("로그인"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
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
                  onPressed: () => _login(),
                  child: Text("로그인"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 0.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 138, 43, 43)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("회원가입"),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    //키보드 숨기기
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      // Firebase 사용자 인증, 사용자 등록
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        currentuser.currentUserEmail = _emailController.text;
        print(_emailController.text);
        Get.offAll(() => const App());
      } on FirebaseAuthException catch (e) {
        //logger.e(e);
        String message = '';

        if (e.code == 'user-not-found') {
          message = '사용자가 존재하지 않습니다.';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호를 확인하세요';
        } else if (e.code == 'invalid-email') {
          message = '이메일을 확인하세요.';
        }

        /*final snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      */

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Color.fromARGB(255, 138, 43, 43),
          ),
        );
      }
    }
  }
}

// //  @override
//   Widget build(BuildContext context) {
//     final double currentWidth = MediaQuery.of(context).size.width;
//     return Center(
//         child: Column(
//       children: [
//         const Text(
//           'Sign in to continue',
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.red,
//           ),
//         ),
//         Text(
//           currentWidth.toString(),
//           style: const TextStyle(fontSize: 15),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         TextField(
//           decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.person),
//               labelText: 'Email',
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 3, color: Colors.blue),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 3, color: Colors.red),
//                 borderRadius: BorderRadius.circular(15),
//               )),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         TextField(
//           obscureText: true,
//           decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.lock),
//               labelText: 'password',
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 3, color: Colors.blue),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 3, color: Colors.red),
//                 borderRadius: BorderRadius.circular(15),
//               )),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const App()),
//             );
//           },
//           child: const Text('로그인하기'),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: const Text('회원가입'),
//         ),
//       ],
//     ));
//   }
