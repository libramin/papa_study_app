import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papa_study_app/provider/page_notifier.dart';
import 'package:provider/provider.dart';

class CheckYourEmail extends Page {
  static final pageName = 'CheckYourEmail';

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return CheckYourEmailWidget();
        });
  }
}

class CheckYourEmailWidget extends StatefulWidget {
  const CheckYourEmailWidget({Key? key}) : super(key: key);

  @override
  _CheckYourEmailWidgetState createState() => _CheckYourEmailWidgetState();
}

class _CheckYourEmailWidgetState extends State<CheckYourEmailWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/image.gif'),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.all(25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [_sendVerification(), _logout(), _emailVerified()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sendVerification() {
    return ElevatedButton(
      onPressed: () async{
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        print('이메일에서 링크를 확인 해 주세요');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이메일에서 링크 확인 해 주세요!'),
            duration: Duration(seconds: 1),));
      },
      child: Text('이메일 검증',
      style: TextStyle(fontWeight: FontWeight.bold,
      fontSize: 20,color: Colors.black.withOpacity(0.7)),),
      style: ElevatedButton.styleFrom(primary: Colors.white54),
    );
  }

  Widget _logout() {
    return ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Text('Logout',
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20, color: Colors.black.withOpacity(0.7)),),
        style: ElevatedButton.styleFrom(primary: Colors.white54));
  }

  Widget _emailVerified() {
    return ElevatedButton(
        onPressed: () {
          Provider.of<PageNotifier>(context, listen: false).refresh();
        },
        child: Text('이메일 검증 완료, Go to main',
        style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20, color: Colors.black.withOpacity(0.7)),),
        style: ElevatedButton.styleFrom(primary: Colors.white54));
  }

}
