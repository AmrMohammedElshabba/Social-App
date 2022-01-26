import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/icon_broken.dart';
import 'package:social_app/customs/text_form_field.dart';

import '../constans.dart';

class EditProfile extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context);
        userNameController.text = userModel.userModel!.name!;
        bioController.text = userModel.userModel!.bio!;
        phoneController.text = userModel.userModel!.phone!;
        return Scaffold(
          appBar: AppBar(title: Text("Edit Profile")),
          body: SingleChildScrollView(
            child: Form(
               key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ConditionalBuilder(
                          condition: state is! CoverImageLoadingUpdateState,
                          builder: (context) => Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${userModel.userModel!.cover}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    userModel.getCoverImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                          fallback: (context) => Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://static.wikia.nocookie.net/animal-jam-clans-1/images/c/ce/Giphyloadingggggggggggggggggg.gif/revision/latest?cb=20171230161115"),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! ProfileImageLoadingUpdateState,
                          builder: (context) => Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${userModel.userModel!.profile}"),
                                  radius: 60,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  userModel.getProfileImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                          fallback: (context) => const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://blog.teamtreehouse.com/wp-content/uploads/2015/05/InternetSlowdown_Day.gif"),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        if (state is LoadingUpdateUserDataState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            prefix: Icons.person,
                            lable: "User Name",
                            keybordType: TextInputType.emailAddress,
                            validateText: "Input user name address",
                            controller: userNameController),
                        SizedBox(
                          height: 35,
                        ),
                        defaultFormField(
                            prefix: Icons.edit,
                            lable: "bio",
                            keybordType: TextInputType.text,
                            validateText: "Input email address",
                            controller: bioController),
                        SizedBox(
                          height: 35,
                        ),
                        defaultFormField(
                            prefix: Icons.phone,
                            lable: "Phone",
                            keybordType: TextInputType.phone,
                            validateText: "Input your phone",
                            controller: phoneController),
                        SizedBox(
                          height: 70,
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              userModel.UpdateUserData(
                                  userName: userNameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: defaultColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Update",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
