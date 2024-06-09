import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/BloCs%20and%20Cubits/LoginCubit/login_cubit.dart';
import 'package:shop/Screens/RegisterPage.dart';
import 'package:shop/Screens/Shop Main Page.dart';
import 'package:shop/Shared/Components.dart';

import '../Shared/Constants.dart';

class loginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is successLoginState) {
              if (state.result.status==true) {
                navigateToAndErease(context: context, widget: ShopScreen());
                snackMessage(context: context, text: state.result.message.toString());
              }
              else {
                snackMessage(context: context, text: state.result.message.toString());
              }
            } else if (state is failedLoginState) {
              snackMessage(context: context, text: "Error : Please Check Your Connection");
            }
          },
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "LOGIN TO ACCESS ALL OUR OFFERS",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultTextField(
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please Enter Your Email Address";
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email),
                            labelText: "EMAIL ADDRESS"),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please Enter Your Password";
                              } else {
                                return null;
                              }
                            },
                            obsecured: cubit.obscured,
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: Icons.remove_red_eye,
                            labelText: "PASSWORD",
                            onTapSuffix: () {
                              cubit.changeObscured();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: state is loadingLoginState,
                            builder: (context) => const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                            fallback: (context) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.login(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Text(
                                            "LOGIN",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                          ),
                                        ),
                                      )),
                                )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context: context, widget: registerScreen());},
                                child: Text(
                                  "REGISTER",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.pink),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
