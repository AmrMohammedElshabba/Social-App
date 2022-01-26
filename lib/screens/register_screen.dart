import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/custom_button.dart';
import 'package:social_app/customs/show_toast.dart';
import 'package:social_app/customs/text_form_field.dart';
import 'package:social_app/network/cache_helper.dart';

import '../constans.dart';
import 'home_layout.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState)
        {
          CacheHelper.saveData(
              key: "uId", value: state.uId)
              .then((value) {

            uId = state.uId;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLayout()),
                    (route) => false);
          });
        }
        if (state is RegisterErrorState){
          ShowToast(state.error.toString());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Register Now',
                                style: Theme.of(context).textTheme.headline1!),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Enter to a beautiful world',
                                style: Theme.of(context).textTheme.headline2!)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultFormField(
                            prefix: Icons.person,
                            lable: "Name",
                            keybordType: TextInputType.name,
                            validateText: "Input name",
                            controller: nameController),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultFormField(
                            prefix: Icons.phone,
                            lable: "Phone",
                            keybordType: TextInputType.phone,
                            validateText: "Input phone",
                            controller: phoneController),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultFormField(
                            prefix: Icons.mail_outline,
                            lable: "Email",
                            keybordType: TextInputType.emailAddress,
                            validateText: "Input email address",
                            controller: emailController),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultFormField(
                            prefix: Icons.lock_outline,
                            lable: "Password",
                            keybordType: TextInputType.visiblePassword,
                            validateText: "Input email address",
                            controller: passwordController,
                            obsecureText: cubit.isPassword,
                            sufix: cubit.suffixIcon,
                            sufixPressed: () {
                              cubit.ShowPassword();
                            }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: State is! LoadingRegisterState,
                        builder: (context) => customButton(context: context,title: 'REGISTER',color: defaultColor, onTap: () {
                          if (formKey.currentState!.validate()) {
                          cubit.UserRegister(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text);
                          }
                        },),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.grey),
                          ),
                          TextButton(
                            child: Text(
                              'login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: defaultColor),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
