import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobile/product/widget/v1_text_field_container.dart';
import 'package:mobile/product/widget/v1_text_form_field.dart';
import '/core/constant/app_color.dart';
import '/core/constant/app_text.dart';
import '/product/widget/custom_elevated_button.dart';
import '/product/widget/custom_textfield.dart';
import '/view/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  SizedBox _body(BuildContext context) {
    return SizedBox(
      height: context.height * 1,
      width: context.width * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            context.emptySizedHeightBoxNormal,
            topText(context),
            context.emptySizedHeightBoxLow3x,
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
            ),
            context.emptySizedHeightBoxLow,
            midText(context),
            context.emptySizedHeightBoxLow,
            CustomElevatedButton(
              borderRadius: 20,
              color: AppColors.loginColor,
              height: context.height * 0.07,
              width: context.width * 0.6,
              onPressed: null,
              child: Text(
                AppText.login.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            bottomText(context),
          ],
        ),
      ),
    );
  }

  Text topText(BuildContext context) {
    return Text(
      AppText.login.toUpperCase(),
      style: context.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  SizedBox midText(BuildContext context) {
    return SizedBox(
      height: context.height * 0.1,
      width: context.width * 0.85,
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
    );
  }

  SizedBox bottomText(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      height: context.height * 0.08,
      child: Row(
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
                MaterialPageRoute(builder: (context) => const RegisterView()),
              );
            },
          )
        ],
      ),
    );
  }
}
