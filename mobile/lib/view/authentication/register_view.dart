import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/core/utility/validator.dart';
import 'package:mobile/product/widget/v1_container.dart';
import 'package:mobile/product/widget/v1_elevated_button.dart';
import 'package:mobile/product/widget/v1_text_form_field.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/core/utility/http_client.dart';
import 'package:mobile/view/authentication/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() {
    return RegisterViewState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class RegisterViewState extends State<RegisterView> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<RegisterViewState>.
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _confirmPassword;
  late bool _confirmPasswordVisible;
  late bool _passwordVisible;
  late bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    _confirmPasswordVisible = false;
    _passwordVisible = false;
    _isButtonDisabled = false;
  }

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
        body: jsonEncode(
            <String, String>{'email': _email, 'password': _password}),
      ).then((response) {
        final body = jsonDecode(response.body);

        if (response.statusCode == 201) {
          AnimatedSnackBar.material(
            body['message'],
            type: AnimatedSnackBarType.success,
            duration: const Duration(seconds: 3),
          ).show(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        } else {
          AnimatedSnackBar.material(
            body['message'],
            type: AnimatedSnackBarType.error,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }).catchError(
        (_) {
          AnimatedSnackBar.material(
            AppText.serverConnectionError,
            type: AnimatedSnackBarType.error,
            duration: const Duration(seconds: 3),
          ).show(context);
        },
      );
    }
    setState(() {
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = context.height * 0.07;
    final double width = context.width * 0.8;

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
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
                  obscureText: !_passwordVisible,
                  hinttext: AppText.password,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.loginColor,
                  ),
                  suffixIcon: IconButton(
                    icon: FaIcon(_passwordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    _confirmPassword = value;
                    return Validator.password(value);
                  },
                  onSaved: (value) => _password = value,
                ),
              ),
              context.emptySizedHeightBoxLow,
              SizedBox(
                height: height,
                width: width,
                child: V1TextFormField(
                  obscureText: !_confirmPasswordVisible,
                  hinttext: AppText.confirm,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.loginColor,
                  ),
                  suffixIcon: IconButton(
                    icon: FaIcon(_confirmPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
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
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          submitForm();
                        },
                  child: Text(
                    AppText.registernow.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
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
      ),
    );
  }
}
