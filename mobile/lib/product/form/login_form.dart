import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/core/utility/secure_storage.dart';
import 'package:mobile/core/utility/validator.dart';
import 'package:mobile/product/widget/v1_container.dart';
import 'package:mobile/product/widget/v1_elevated_button.dart';
import 'package:mobile/product/widget/v1_text_form_field.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/core/utility/http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/view/register_view.dart';
import 'package:mobile/view/test_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LoginFormState>.
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

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
        'login',
        jsonEncode(<String, String>{'username': _email, 'password': _password}),
      ).then((response) {
        dynamic body = jsonDecode(response.body);
        showAlert(
            response.statusCode == 200 ? AppColors.success : AppColors.error,
            Text(
              body['message'],
            ));
        secureStorage.write(key: 'jwt', value: body['token']);
        secureStorage.write(key: 'usr', value: body['id']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TestView()),
        );
      }).catchError((_) {
        showAlert(
          AppColors.error,
          const Text(AppText.serverConnectionError),
        );
        return null;
      });
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
              AppText.login.toUpperCase(),
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
                // validator: (value) => Validator.password(value),
                onSaved: (value) => _password = value,
              ),
            ),
            SizedBox(
              height: 1.45 * height,
              width: 1.0625 * width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.loginColor,
                      ),
                      const Text(AppText.rememberMe),
                    ],
                  ),
                  const Text(
                    AppText.already,
                  ),
                ],
              ),
            ),
            context.emptySizedHeightBoxLow,
            V1Container(
              height: height,
              width: width * 0.75,
              child: V1ElevatedButton(
                borderRadius: 20,
                color: AppColors.loginColor,
                onPressed: () => submitForm(),
                child: Text(
                  AppText.login.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            context.emptySizedHeightBoxLow,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppText.account,
                ),
                TextButton(
                  child: const Text(
                    AppText.registernow,
                    style: TextStyle(color: AppColors.loginColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterView()),
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
