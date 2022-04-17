import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/page_notifier.dart';

class AuthPage extends Page {
  static final pageName = 'AuthPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings: this, builder: (_) => AuthPageWidget());
  }
}

class AuthPageWidget extends StatefulWidget {
  const AuthPageWidget({Key? key}) : super(key: key);

  @override
  _AuthPageWidgetState createState() => _AuthPageWidgetState();
}

class _AuthPageWidgetState extends State<AuthPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('authpage'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<PageNotifier>(context, listen: false).goToMain();
              },
              icon: Icon(Icons.login))
        ],
      ),
    );
  }
}
