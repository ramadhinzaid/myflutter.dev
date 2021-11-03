import 'package:flutter/material.dart';
import 'package:zaid_study/forms/progress_bar.dart';
import 'package:zaid_study/validation.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  double _formProgress = 0;
  bool _passwordHide = true;
  double _passwordStrength = 0;
  String _passwordStrengthStatus = "Weak";
  Color _passwordStrengthColor = Colors.blue;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  //form progress bar
  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [_usernameTextController, _passwordTextController];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  //change password value
  void _onChange(value) {
    double _hasLowerCase = 0, _hasUpperCase = 0, _hasNumber = 0, _hasLength = 0;
    if (Validations.lowerCase(value)) {
      _hasLowerCase = 1;
    } else {
      _hasLowerCase = 0;
    }
    if (Validations.upperCase(value)) {
      _hasUpperCase = 1;
    } else {
      _hasUpperCase = 0;
    }
    if (Validations.hasNumber(value)) {
      _hasNumber = 1;
    } else {
      _hasNumber = 0;
    }
    if (value.length > 8) {
      _hasLength = 1;
    } else {
      _hasLength = 0;
    }
    _passwordStrength =
        (_hasLowerCase + _hasUpperCase + _hasNumber + _hasLength) / 4;
    print({
      _hasLowerCase,
      _hasUpperCase,
      _hasNumber,
      _hasLength,
      _passwordStrength,
      "PASS"
    });
    if (_passwordStrength <= 0.25) {
      setState(() {
        _passwordStrengthStatus = "Weak";
        _passwordStrengthColor = Colors.red;
      });
    } else if (_passwordStrength <= 0.5 && _passwordStrength > 0.25) {
      setState(() {
        _passwordStrengthStatus = "Middle";
        _passwordStrengthColor = Colors.orange;
      });
    } else if (_passwordStrength <= 0.75 && _passwordStrength > 0.5) {
      setState(() {
        _passwordStrengthStatus = "Normal";
        _passwordStrengthColor = Colors.yellow;
      });
    } else {
      setState(() {
        _passwordStrengthStatus = "Strong";
        _passwordStrengthColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: _loginForm(context),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(parentContext) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "Login Here",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFFF2F4FA), width: 1.0),
                  // borderSide: BorderSide.none
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: _onChange,
                  obscureText: _passwordHide,
                  controller: _passwordTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide:
                          BorderSide(color: Color(0xFFF2F4FA), width: 1.0),
                      // borderSide: BorderSide.none
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      // borderSide: BorderSide.none,
                      borderSide:
                          BorderSide(color: _passwordStrengthColor, width: 2.0),
                    ),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _passwordHide = !_passwordHide;
                      }),
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(_passwordStrengthStatus),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: AnimatedProgressIndicator(
                //               value: _passwordStrength)),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 16.0),
                //         child: Text(_passwordStrengthStatus),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                side: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? BorderSide(color: Colors.grey)
                      : BorderSide(color: Colors.blue);
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.blue;
                }),
              ),
              onPressed: _formProgress == 1 &&
                      _passwordStrengthStatus == "Strong"
                  ? () => {
                        setState(() {
                          _isLoading = true;
                        }),
                        Future.delayed(Duration(seconds: 5)).then((value) => {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Login Succes"),
                                ),
                              ),
                              setState(() {
                                _isLoading = false;
                              }),
                            })
                      }
                  : null,
              child: Container(
                height: 42,
                width: double.infinity,
                child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Login',
                          style: TextStyle(fontSize: 21),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
