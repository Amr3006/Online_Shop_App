import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BloCs and Cubits/LoginCubit/login_cubit.dart';
import '../Shared/Components.dart';
import 'Shop Main Page.dart';

class registerScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  registerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is successRegisterState) {
              snackMessage(
                  context: context, text: state.message.toString());
              if(state.status ==true) {
                navigateToAndErease(context: context, widget: ShopScreen());
              }
            } else if (state is failedLoginState) {
              snackMessage(
                  context: context,
                  text: "Error : Please Check Your Connection");
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
                          "REGISTER",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "REGISTER TO ACCESS ALL OUR OFFERS",
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
                                return "Please Enter Your Name";
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            inputType: TextInputType.text,
                            prefixIcon: const Icon(Icons.person),
                            labelText: "NAME"),
                        const SizedBox(
                          height: 30,
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
                              return "Please Enter Your Phone Number";
                            } else {
                              return null;
                            }
                          },
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          prefixIcon: const Icon(Icons.phone),
                          labelText: "PHONE NUMBER",
                        ),
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
                            condition: state is loadingRegisterState,
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
                                          cubit.register(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              email: emailController.text,
                                              password: passwordController.text);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Text(
                                            "REGISTER",
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
