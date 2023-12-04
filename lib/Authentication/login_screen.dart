import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gps_tracker/gpstracker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const users = {'admin@gmail.com': '12345'};

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 1500);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User doesn\'t exist';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "TrackMyBike\n",
      additionalSignupFields: [
        const UserFormField(
          keyName: 'Username',
          icon: Icon(Icons.donut_large),
        ),
        const UserFormField(keyName: 'Name'),
        const UserFormField(keyName: 'Surname'),
        UserFormField(
          keyName: 'phone_number',
          displayName: 'Phone Number',
          userType: LoginUserType.phone,
          fieldValidator: (value) {
            final phoneRegExp = RegExp(
              '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
            );
            if (value != null &&
                value.length < 7 &&
                !phoneRegExp.hasMatch(value)) {
              return "This isn't a valid phone number";
            }
            return null;
          },
        ),
      ],
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GPSTracker()));
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
          primaryColor: const Color.fromRGBO(58, 66, 86, 1.0),
          accentColor: const Color.fromRGBO(64, 75, 96, .9),
          errorColor: const Color.fromRGBO(64, 75, 96, .9),
          titleStyle: const TextStyle(
              color: Colors.white,
              letterSpacing: 4,
              fontWeight: FontWeight.bold),
          bodyStyle: const TextStyle(fontStyle: FontStyle.italic),
          buttonTheme: const LoginButtonTheme(
              splashColor: Colors.transparent,
              backgroundColor: Color.fromRGBO(64, 75, 96, 1),
              elevation: 9,
              highlightElevation: 6)),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: const Text("Wrong email/password"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
