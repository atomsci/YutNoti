import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yutnoti/utility/dialog.dart';
import 'package:yutnoti/utility/my_constant.dart';
import 'package:yutnoti/widget/show_image.dart';

class CreatAcc extends StatefulWidget {
  @override
  _CreatAccState createState() => _CreatAccState();
}

class _CreatAccState extends State<CreatAcc> {
  double size;
  String name, email, password;

  Container buildName() {
    return Container(
      width: size * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(),
          labelText: 'Name : ',
        ),
      ),
    );
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
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(),
          labelText: 'Password : ',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      appBar: AppBar(
        title: Text('Create new Account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildImage(),
              buildName(),
              buildEmail(),
              buildPassword(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        if ((name == null || name.isEmpty) ||
            (email?.isEmpty ?? true) ||
            (password?.isEmpty ?? true)) {
          print('have Space');
          normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
        } else {
          print('no Space');
          processCreateAccout();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> processCreateAccout() async {
    await Firebase.initializeApp().then((value) async {
      print('### InitializeApp Success ##');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('Create Account Success');
        String api =
            '${MyConstant.domain}/aic/addUserYut.php?isAdd=true&name=$name&user=$email&password=$password';
        await Dio().get(api).then((value) {
          print('### Response value => $value');
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            normalDialog(context, 'cannot create account', 'Please try again');
          }
        });
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }

  Container buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.8,
      child: ShowImage(MyConstant.account),
    );
  }
}
