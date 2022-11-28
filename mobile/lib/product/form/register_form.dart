import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/core/utility/validator.dart';
import 'package:mobile/product/widget/v1_container.dart';
import 'package:mobile/product/widget/v1_elevated_button.dart';
import 'package:mobile/product/widget/v1_text_form_field.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/core/utility/http_client.dart';
import 'package:mobile/view/login_view.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class RegisterFormState extends State<RegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<RegisterFormState>.
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _confirmPassword;

  // @override
  // void initState() {}
  void showAlert(Color backgroundColor, Widget content) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          content: content,
        ),
      );
    }
  }

  Future<void> submitForm() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // Save current form data
      _formKey.currentState!.save();
      // Send login request.
      await HttpClient.post(
        'register',
        jsonEncode(<String, String>{'email': _email, 'password': _password}),
      )
          .then((response) => showAlert(
              response.statusCode == 200 ? AppColors.success : AppColors.error,
              Text(
                jsonDecode(response.body)['message'],
              )))
          .catchError(
            (e) => showAlert(
                AppColors.error, const Text(AppText.serverConnectionError)),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = context.height * 0.07;
    final double width = context.width * 0.8;

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // context.emptySizedHeightBoxHigh,
            context.emptySizedHeightBoxLow3x,
            context.emptySizedHeightBoxLow3x,
            Text(
              AppText.signUp.toUpperCase(),
              style: context.textTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            context.emptySizedHeightBoxLow3x,

            SizedBox(
              height: height,
              width: width,
              child: V1TextFormField(
                hinttext: AppText.email,
                prefixIcon: const Icon(
                  Icons.email,
                  color: AppColors.loginColor,
                ),
                validator: (value) => Validator.email(value),
                onSaved: (value) => _email = value,
              ),
            ),
            context.emptySizedHeightBoxLow,
            SizedBox(
              height: height,
              width: width,
              child: V1TextFormField(
                hinttext: AppText.password,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColors.loginColor,
                ),
                suffixIcon: const Icon(Icons.remove_red_eye),
                validator: (value) {
                  _confirmPassword = value;
                  Validator.password(value);
                },
                onSaved: (value) => _password = value,
              ),
            ),
            context.emptySizedHeightBoxLow,
            SizedBox(
              height: height,
              width: width,
              child: V1TextFormField(
                hinttext: AppText.confirm,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColors.loginColor,
                ),
                suffixIcon: const Icon(Icons.remove_red_eye),
                validator: (value) =>
                    Validator.passwordConfirm(value, _confirmPassword),
                onSaved: (value) => _password = value,
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            V1Container(
              height: height,
              width: width * 0.75,
              child: V1ElevatedButton(
                borderRadius: 20,
                color: AppColors.loginColor,
                onPressed: () => submitForm(),
                child: const Text(
                  AppText.registernow,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            context.emptySizedHeightBoxLow,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  AppText.already,
                ),
                TextButton(
                  child: const Text(
                    AppText.login,
                    style: TextStyle(color: AppColors.loginColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
