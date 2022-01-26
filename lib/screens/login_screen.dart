import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/custom_button.dart';
import 'package:social_app/customs/show_toast.dart';
import 'package:social_app/customs/text_form_field.dart';
import 'package:social_app/network/cache_helper.dart';
import 'package:social_app/screens/register_screen.dart';

import '../constans.dart';
import 'home_layout.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is LoginSuccessState)
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
          if (state is LoginErrorState){
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
                            Text('Login Now',
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
                        condition: State is! LoadingLoginState,
                        builder: (context) => customButton(title: "LOGIN",color: defaultColor,context: context,onTap: (){
                          if (formKey.currentState!.validate()) {
                          cubit.UserLogin(
                          email: emailController.text,
                          password: passwordController.text);
                          }
                        }),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'don\'t have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          TextButton(
                            child: Text(
                              'create a new account',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: defaultColor),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
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
