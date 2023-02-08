import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phrankstar/constants.dart';
import 'package:http/http.dart' as http;
import 'package:phrankstar/responsive.dart';
import '../models/http_exception.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class BasicLogin extends StatefulWidget {
  // const BasicLogin({Key? key}) : super(key: key);

  static const routeName = '/basic-login';

  @override
  State<BasicLogin> createState() => _BasicLoginState();
}

class _BasicLoginState extends State<BasicLogin> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: oxblood),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Basic Login',
            style: TextStyle(color: oxblood),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/images/phrankstars.png'),
                height: Responsive.isDesktop(context)
                    ? size.height * 0.20
                    : size.height * 0.15,
                width: Responsive.isDesktop(context)
                    ? size.height * 0.20
                    : size.height * 0.15,
              ),
              SingleChildScrollView(
                child: AuthCard(),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<Size> _heightAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    // _controller.addListener(() => setState(() {}));
    opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'OK',
                      style: TextStyle(color: oxblood),
                    ))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }
      final url = ''; // connect to database to fetch login id

      try {
        final response = await http.get(Uri.parse(url));
        final AdminLogin = json.decode(response.body)['-NMd_Tdf6QcALAfl2pEO']
            as Map<String, dynamic>;
        // print(json.decode(response.body)['-NMd_Tdf6QcALAfl2pEO']);
        if (AdminLogin['email'].toString() == _authData['email'] &&
            AdminLogin['password'].toString() == _authData['password']) {
          Navigator.of(context).pushNamed('/basic-school-staff');
        } else {
          Navigator.of(context).pushNamed('/basic-user');
        }
      } catch (e) {
        HttpException(e.toString());
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed.';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address.';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could Not Authenticate You.\nCheck Your Network Connection And Try Again.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool _hideRow = true;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        _hideRow = false;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _hideRow = true;
      });
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  // bool _showSitch = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child:
          // AnimatedBuilder(
          //   animation: _heightAnimation,
          //   builder: ((context, ch) =>
          AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: Responsive.isDesktop(context)
            ? _authMode == AuthMode.Signup
                ? 290
                : 200
            : _authMode == AuthMode.Signup
                ? 290
                : 260
        // _heightAnimation.value.height
        ,
        constraints: BoxConstraints(
            minHeight: Responsive.isDesktop(context)
                ? _authMode == AuthMode.Signup
                    ? 300
                    : 260
                : _authMode == AuthMode.Signup
                    ? 260
                    : 250),
        width: Responsive.isDesktop(context)
            ? deviceSize.width * 0.5
            : deviceSize.width,
        padding: EdgeInsets.all(10.0),
        child:
            //  ch)),
            Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: 'E-Mail',
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Enter email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: oxblood))),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required!';
                    } else if (!value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                  ],
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      iconColor: oxblood,
                      labelText: 'Password',
                      suffixIcon:
                          IconButton(icon: Icon(Icons.lock), onPressed: () {}),
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field can\'t be empty!';
                    } else if (value.length < 4) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                // SizedBox(
                //   height: 12,
                // ),
                // _hideRow
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Row(
                //           children: [
                //             Text(
                //               'ADMIN',
                //               style: TextStyle(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold),
                //               textAlign: TextAlign.start,
                //             ),
                //             Switch(
                //               activeColor: oxblood,
                //               value: _showSitch,
                //               onChanged: (val) {
                //                 setState(() {
                //                   _showSitch = val;
                //                 });
                //               },
                //             ),
                //             Text(
                //               'BOSS',
                //               style: TextStyle(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold),
                //               textAlign: TextAlign.start,
                //             ),
                //             Spacer(),
                //             _showSitch
                //                 ? SizedBox(
                //                     width: 40,
                //                     height: 50,
                //                     child: TextFormField(
                //                       inputFormatters: [
                //                         FilteringTextInputFormatter.allow(
                //                             RegExp('[0-9]'))
                //                       ],
                //                       maxLength: 3,
                //                       decoration: InputDecoration(
                //                         hintText: 'OTP',
                //                         hintStyle: TextStyle(
                //                             color:
                //                                 Theme.of(context).primaryColor),
                //                       ),
                //                       validator: (val) {},
                //                       keyboardType: TextInputType.number,
                //                     ),
                //                   )
                //                 : SizedBox()
                //           ],
                //         ),
                //       )
                //     :
                SizedBox(
                  height: 8,
                ),
                // if (_authMode == AuthMode.Signup)
                AnimatedContainer(
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 50 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 125 : 0),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: opacityAnimation,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]'))
                      ],
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    color: oxblood,
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: oxblood,
                    ),
                    child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _submit,
                  ),
                if (Platform.isWindows)
                  SizedBox(
                    height: 10,
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: oxblood,
                  ),
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                      style: TextStyle(color: Colors.white)),

                  onPressed: _switchAuthMode,
                  // padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
