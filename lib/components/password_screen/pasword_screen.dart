import 'package:flutter/material.dart';
//From Utils
import 'utils/circle.dart';
import 'utils/keyboard.dart';
import 'utils/main_fitur.dart';

class Pin {
  verification(pin,
      {route,
      context,
      verificationNotifier,
      haveFunc = false,
      function}) async {
    Dialogs.stdMenunggu(context, "Mohon Menunggu", "Sedang memproses...");
    //tambahkan pop up menunggu
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = jsonDecode(localStorage.getString('id'));
    var token = jsonDecode(localStorage.getString('token'));
    var data = {'user_id': id, 'pin': pin};
    var res = await Network().authpostPinLogin(data, '/check_pin', token);
    var body = json.decode(res.body);

    bool isValid = '234567' == pin;
    verificationNotifier.add(isValid);
    // if (isValid) {
    //     this.isAuthenticated = isValid;
    // }

    if (body['status'] == true) {
      if (haveFunc) {
        function();
      } else {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('pin', pin);
        Navigator.of(context).push(
          scaleRoute(route),
        );
      }
    } else {
      Navigator.pop(context);
      //kalau ada popup menunggu maka di pop dulu
      Dialogs.popupMessagesStd(
        context,
        "PIN Salah",
        "Silahkan ulangi kembali pin anda ",
      );
    }
  }

  defaulLockScreen(
      {context,
      onPasscodeEntered,
      verificationNotifier,
      digits,
      canCancel = true}) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PasscodeScreen(
                title: ZaidText(
                    text: 'Masukkan PIN Anda',
                    align: TextAlign.center,
                    size: 28),
                circleConfig: CircleConfig(
                  borderColor: Color(0xff343A40),
                  borderWidth: 2.0,
                  fillColor: Color(0xff343A40),
                ),
                keyboardConfig: KeyboardConfig(
                  primaryColor: Color(0xff01FF83),
                  digitTextStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff343A40),
                  ),
                ),
                passwordEnteredCallback: onPasscodeEntered,
                cancelButton: !canCancel
                    ? null
                    : Image.asset(
                        'assets/images/bxstagx1.png',
                        width: 24,
                        height: 24,
                      ),
                deleteButton: Image.asset(
                  'assets/images/bxstagx1.png',
                  width: 24,
                  height: 24,
                ),
                shouldTriggerVerification: verificationNotifier.stream,
                backgroundColor: const Color(0xff01FF83),
                cancelCallback:
                    !canCancel ? null : () => Navigator.maybePop(context),
                digits: digits,
                bottomWidget: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          scaleRoute(
                            LupaPIN(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: ZaidText(text: 'Lupa PIN?', size: 16),
                      ),
                    ),
                    canCancel ? SizedBox.shrink() : SizedBox(height: 16.0),
                    canCancel
                        ? SizedBox.shrink()
                        : GestureDetector(
                            onTap: () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              await pref.clear();
                              await pref.setString('isInstall', 'Installed');

                              Navigator.of(context).pushAndRemoveUntil(
                                  scaleRoute(LoginScreen()),
                                  ModalRoute.withName('/'));
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ZaidText(
                                text: 'Pindah ke akun lain',
                                size: 16,
                              ),
                            ),
                          ),
                  ],
                ),
                // isValidCallback: _onPasscodePinBaru,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
