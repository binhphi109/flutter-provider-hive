import 'package:flutter_sample/services/users.dart';
import 'package:flutter_sample/widgets/error_text.dart';
import 'package:flutter_sample/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/helpers/field_errors.dart';
import 'package:flutter_sample/helpers/toast.dart';
import 'package:flutter_sample/widgets/buttons.dart';
import 'package:flutter_sample/widgets/outline_input.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController tfEmail = TextEditingController(),
      tfName = TextEditingController(),
      tfPassword = TextEditingController();

  List<FieldError> errors = [];
  bool loading = false;
  bool isPasswordShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    init();
  }

  @override
  void dispose() {
    tfEmail.dispose();
    tfName.dispose();
    tfPassword.dispose();
    super.dispose();
  }

  init() async {}

  validate(String email, String name, String password) {
    errors.clear();

    if (email.isEmpty) {
      errors.add(new FieldError(field: 'email', message: 'Email is missing.'));
    }

    if (name.isEmpty) {
      errors.add(new FieldError(field: 'name', message: 'Name is missing.'));
    }

    if (password.isEmpty) {
      errors.add(new FieldError(field: 'password', message: 'Password is missing.'));
    }

    this.setState(() {});

    return errors.length == 0;
  }

  handleRegister() async {
    var email = tfEmail.text;
    var name = tfName.text;
    var password = tfPassword.text;

    var isValid = validate(email, name, password);
    if (isValid) {
      setState(() {
        loading = true;
      });

      var response = await UserApi.register(email, name, password);

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "/login");
        showToastSuccess("Register successfully");
      } else if (response.statusCode == 400) {
        errors.add(new FieldError(field: 'register', message: 'Invalid request.'));
      } else {
        showToastError("Register failed");
      }

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 64),
            Image.asset(
              "assets/images/logo.png",
              height: 64,
              width: 64,
            ),
            SizedBox(height: 16),
            Logo(),
            SizedBox(height: 64),
            OutlineInput(
              controller: tfEmail,
              keyboardType: TextInputType.text,
              hintText: 'Email',
              errorText: getFirstError(errors, 'email')?.message,
            ),
            SizedBox(height: 8),
            OutlineInput(
              controller: tfName,
              keyboardType: TextInputType.text,
              hintText: 'Name',
              errorText: getFirstError(errors, 'name')?.message,
            ),
            SizedBox(height: 8),
            OutlineInput(
              controller: tfPassword,
              keyboardType: TextInputType.text,
              obscureText: !isPasswordShow,
              hintText: 'Password',
              errorText: getFirstError(errors, 'password')?.message,
            ),
            SizedBox(height: 8),
            ErrorText(text: getFirstError(errors, 'register')?.message),
            Button(
              disabled: loading,
              title: loading ? 'Registering...' : 'Register',
              action: () {
                handleRegister();
              },
            ),
            SizedBox(height: 8),
            Button(
              title: 'Login',
              action: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
