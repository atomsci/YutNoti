import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yutnoti/utility/dialog.dart';
import 'package:yutnoti/utility/my_constant.dart';
import 'package:yutnoti/widget/show_image.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double size;
  String email, password;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    print('size = $size');
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildContent(),
          
          ],
        ),
      ),
    );
  }

  Column buildCreateAcc(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Non Account ?'),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/createAcc'),
                      child: Text(' Create New Account')),
                ],
              ),
            ],
          );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
        // scrool
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImage(),
            buildEmail(),
            buildPassword(),
            buildLogin(),
            buildCreateAcc(context),
          ],
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      width: size * 0.6,
      child: ElevatedButton(
        onPressed: () {
          if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'have space ', 'please fill every blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false))
          .catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.6,
      child: TextField(
        onChanged: (value) => email = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined),
          border: OutlineInputBorder(),
          labelText: 'Email : ',
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: size * 0.6,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(),
          labelText: 'Password : ',
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      width: size * 0.8,
      child: ShowImage(MyConstant.account),
    );
  }
}
