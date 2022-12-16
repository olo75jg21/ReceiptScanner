import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/core/utility/validator.dart';
import 'package:mobile/product/widget/v1_container.dart';
import 'package:mobile/product/widget/v1_elevated_button.dart';
import 'package:mobile/product/widget/v1_text_form_field.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/core/utility/http_client.dart';
import 'package:mobile/service/storage_service.dart';
import 'package:mobile/view/authentication/register_view.dart';
import 'package:mobile/view/profile/main_profile_view.dart';
import 'package:mobile/view/test_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() {
    return LoginViewState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class LoginViewState extends State<LoginView> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LoginViewState>.
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late bool _passwordVisible;
  late bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
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
        'login',
        body: jsonEncode(
            <String, String>{'email': _email, 'password': _password}),
      ).then((response) {
        final body = jsonDecode(response.body);

        if (response.statusCode == 200) {
          AnimatedSnackBar.material(
            body['message'],
            type: AnimatedSnackBarType.success,
            duration: const Duration(seconds: 3),
          ).show(context);
          StorageService.writeSecureData(StorageItem('jwt', body['token']));
          StorageService.writeSecureData(StorageItem('user', body['id']));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainProfileView()),
          );
        } else {
          AnimatedSnackBar.material(
            body['message'],
            type: AnimatedSnackBarType.error,
            duration: const Duration(seconds: 3),
            // mobileSnackBarPosition: MobileSnackBarPosition.top,
          ).show(context);
          // showAlert(
          //     AppColors.error,
          //     Text(
          //       body['message'],
          //     ));
        }
      }).catchError((_) {
        AnimatedSnackBar.material(
          AppText.serverConnectionError,
          type: AnimatedSnackBarType.error,
          duration: const Duration(seconds: 3),
        ).show(context);
      });
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
                  // validator: (value) => Valaidator.email(value),
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
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          submitForm();
                        },
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
      ),
    );
  }
}
