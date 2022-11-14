import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '/core/constant/app_color.dart';
import '/core/constant/app_text.dart';
import '/product/widget/custom_elevated_button.dart';
import '/product/widget/custom_textfield.dart';

import 'package:http/http.dart' as http;
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  SizedBox _body(BuildContext context) {
    Map<String, dynamic> _credentials = [
      ''
    ];
    return SizedBox(
      height: context.height * 1,
      width: context.width * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            context.emptySizedHeightBoxLow3x,
            topText(context),
            context.emptySizedHeightBoxLow3x,
            CustomTextField(
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.firstName,
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.loginColor,
              ),
              onChanged: (newText) { _credentials['first_name'] = newText },
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.lastName,
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.loginColor,
              ),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.email,
              prefixIcon: const Icon(
                Icons.email,
                color: AppColors.loginColor,
              ),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.password,
              prefixIcon: const Icon(
                Icons.lock,
                color: AppColors.loginColor,
              ),
              suffixIcon: const Icon(Icons.remove_red_eye),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.confirm,
              prefixIcon: const Icon(
                Icons.lock,
                color: AppColors.loginColor,
              ),
              suffixIcon: const Icon(Icons.remove_red_eye),
            ),
            context.emptySizedHeightBoxLow3x,
            CustomElevatedButton(
              borderRadius: 20,
              color: AppColors.loginColor,
              height: context.height * 0.07,
              width: context.width * 0.6,
              child: Text(
                AppText.signUp.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () => ,
            ),
            context.emptySizedHeightBoxLow3x,
            bottomText(context),
          ],
        ),
      ),
    );
  }

  Text topText(BuildContext context) {
    return Text(
      AppText.signUp.toUpperCase(),
      style: context.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  SizedBox bottomText(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      height: context.height * 0.08,
      child: Row(
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
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          )
        ],
      ),
    );
  }
}
