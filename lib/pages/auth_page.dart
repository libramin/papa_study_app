import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papa_study_app/provider/page_notifier.dart';
import 'package:provider/provider.dart';

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
  GlobalKey<FormState> _FormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cPasswordController = TextEditingController();

  bool _isRegister = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/image.gif')),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _FormKey,
              child: ListView(
                reverse: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white38,
                    radius: 36,
                    child: Image.asset('assets/rabbitface_black.png'),
                  ),
                  SizedBox(height: 20),
                  _AuthStateButton(),
                  TextFormField(
                    key: ValueKey(1),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '정보를 입력 해 주세요';
                      } else if (!value.contains('@')) {
                        return '올바른 이메일을 입력 해 주세요';
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration('E-mail'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    key: ValueKey(2),
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '정보를 입력 해 주세요';
                      } else if (value.length < 6) {
                        return '여섯글자 이상 입력 해주세요';
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: _inputDecoration('Password'),
                  ),
                  SizedBox(height: 20),
                  if (_isRegister)
                    TextFormField(
                      key: ValueKey(3),
                      controller: _cPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '정보를 입력 해 주세요';
                        } else if (value == _passwordController.value) {
                          return null;
                        }
                        return null;
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: _inputDecoration('Confirm Password'),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          primary: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        if (_FormKey.currentState!.validate()) {
                          print('모든 입력값이 올바르다');
                          Provider.of<PageNotifier>(context, listen: false)
                              .goToMain();
                        }
                      },
                      child: Text(
                        _isRegister ? 'Register' : 'Login',
                        style: TextStyle(color: Colors.black),
                      )),
                  Divider(color: Colors.white54, thickness: 1, height: 40),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton('assets/glogo.png', () {}),
                      _buildSocialButton('assets/facelogo.png', () {}),
                      _buildSocialButton('assets/apple.jpeg', () {})
                    ],
                  )
                ].reversed.toList(),
              )),
        ),
      ),
    );
  }

  // Choose AuthState Button
  Row _AuthStateButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {
              setState(() {
                _isRegister = false;
              });
            },
            child: Text('Login',
                style: TextStyle(
                  color: _isRegister ? Colors.white70 : Colors.black,
                  fontWeight: _isRegister ? null : FontWeight.bold,
                  fontSize: _isRegister ? 18 : 20,
                ))),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {
              setState(() {
                _isRegister = true;
              });
            },
            child: Text('Register',
                style: TextStyle(
                  color: _isRegister ? Colors.black : Colors.white70,
                  fontWeight: _isRegister ? FontWeight.bold : null,
                  fontSize: _isRegister ? 20 : 18,
                ))),
      ],
    );
  }

  Container _buildSocialButton(String logoImage, VoidCallback _onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white54),
      child: IconButton(
          onPressed: _onPressed, icon: ImageIcon(AssetImage(logoImage))),
    );
  }

  //TextFormField InputDeco
  InputDecoration _inputDecoration(String lableText) {
    return InputDecoration(
        filled: true,
        fillColor: Colors.black26,
        labelText: lableText,
        border: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
        focusColor: Colors.white,
        errorStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        errorBorder: _outlineInputBorder.copyWith(
            borderSide: BorderSide(color: Colors.black, width: 3)),
        labelStyle: TextStyle(color: Colors.white, fontSize: 18));
  }

  //Field Border Deco
  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent, width: 0));
}
