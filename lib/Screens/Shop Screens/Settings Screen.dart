import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/BloCs%20and%20Cubits/ShopCubit/shop_cubit.dart';
import 'package:shop/Screens/loginPage.dart';
import 'package:shop/Shared/CacheHelper.dart';
import 'package:shop/Shared/Components.dart';

class settingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  settingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is SuccessUpdateState) {
          snackMessage(context: context, text: state.message);
        }
      },
      builder: (context, state) {
        ShopCubit cubit=ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.profile_data!=null,
            builder: (context) {
              var model = cubit.profile_data;
              nameController.text=model!.data.name;
              emailController.text=model.data.email;
              phoneController.text=model.data.phone;
              return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                              "https://wallpapers-clan.com/wp-content/uploads/2023/01/anime-aesthetic-boy-pfp-1.jpg"),
                        ),
                        const SizedBox(height: 30,),

                        defaultTextField(
                            controller: nameController,
                            inputType: TextInputType.text,
                            labelText: "Name",
                            prefixIcon: const Icon(Icons.person)),
                        const SizedBox(height: 30,),
                        defaultTextField(
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email_rounded)),
                        const SizedBox(height: 30,),
                        defaultTextField(
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            labelText: "Phone Number",
                            prefixIcon: const Icon(Icons.phone)),
                        const SizedBox(height: 20,),
                        if (state is LoadingUpdateState)
                          const LinearProgressIndicator(),
                          const SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: TextButton(
                              onPressed: (){
                                cubit.updateProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              },
                              child: Text(
                                "UPDATE",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                              )),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: TextButton(
                              onPressed: (){
                                cacheHelper.removeData(key: "token").then((value) {
                                  value==true ? navigateToAndErease(context: context,widget: loginScreen()) : snackMessage(context: context, text: 'Failed to Logout',);
                                });
                              },
                              child: Text(
                                "LOGOUT",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            },
            fallback: (context) => const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
