import 'package:firebase_auth/firebase_auth.dart';
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
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _LoginEmailController = TextEditingController();
  TextEditingController _LoginPasswordController = TextEditingController();
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
                  if(_isRegister)
                    Column(
                      children: [
                        _EmailTextFormField(1, _emailController),
                        SizedBox(height: 20),
                        _PasswordTextFormField(2, _passwordController),
                        SizedBox(height: 20),
                        _ConfirmPasswordTextFormField(),
                      ],
                    ),
                  if(!_isRegister)
                    Column(
                      children: [
                        _EmailTextFormField(3, _LoginEmailController),
                        SizedBox(height: 20),
                        _PasswordTextFormField(4, _LoginPasswordController),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          primary: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (_FormKey.currentState!.validate()) {
                          if (_isRegister) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                _showSnackBar('이미 사용중인 이메일 입니다');
                              } else if (e.code == 'invalid-email') {
                                _showSnackBar('올바르지않은 이메일 입니다');
                              } else if (e.code == 'operation-not-allowed') {
                                _showSnackBar('작업불가');
                              } else if (e.code == 'weak-password') {
                                _showSnackBar('암호가 강력하지 않습니다');
                              }
                            }
                          } else {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: _LoginEmailController.text,
                                  password: _LoginPasswordController.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'invalid-email') {
                                _showSnackBar('이미 사용중인 이메일 입니다');
                              } else if (e.code == 'user-disabled') {
                                'Thrown if the email address is not valid';
                              } else if (e.code == 'user-not-found') {
                                _showSnackBar('회원 정보를 찾을 수 없습니다');
                              } else if (e.code == 'wrong-password') {
                                _showSnackBar('암호가 올바르지 않습니다');
                              }
                            }
                          }
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

  TextFormField _EmailTextFormField(int valueKey,
      TextEditingController controller) {
    return TextFormField(
      key: ValueKey(valueKey),
      controller: controller,
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
    );
  }

  TextFormField _PasswordTextFormField(int valueKey,
      TextEditingController controller) {
    return TextFormField(
      key: ValueKey(valueKey),
      controller: controller,
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
    );
  }

  TextFormField _ConfirmPasswordTextFormField() {
    return TextFormField(
      key: ValueKey(5),
      controller: _cPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '정보를 입력 해 주세요';
        } else if (value != _passwordController.text) {
          return '비밀번호를 재 확인 해 주세요';
        } else if (value == _passwordController.text) {
          return null;
        }
        return null;
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: _inputDecoration('Confirm Password'),
    );
  }

  //Other Account LoginButton
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

  void _showSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title,
        textAlign: TextAlign.center,),
      duration: Duration(seconds: 1),));
  }
}
