import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/product/widget/v1_text_field_container.dart';
import 'package:mobile/product/widget/v1_text_form_field.dart';

import '../../core/constant/app_color.dart';

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
  late final String _email;
  late final String _password;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          V1TextFieldContainer(
            height: context.height * 0.07,
            width: context.width * 0.8,
            child: const V1TextFormField(
              hinttext: AppText.email,
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.loginColor,
              ),
            ),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Please enter some text';
            //     }
            //     return null;
            //   },
            // onSaved:
          ),
          V1TextFieldContainer(
            height: context.height * 0.07,
            width: context.width * 0.8,
            child: const V1TextFormField(
              hinttext: AppText.password,
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.loginColor,
              ),
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Validate returns true if the form is valid, or false otherwise.
          //     if (_formKey.currentState!.validate()) {
          //       // If the form is valid, display a snackbar. In the real world,
          //       // you'd often call a server or save the information in a database.
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Processing Data')),
          //       );
          //     }
          //   },
          //   child: const Text('Submit'),
          // ),
        ],
      ),
    );
  }
}
