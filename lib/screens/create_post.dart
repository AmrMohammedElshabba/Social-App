import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';

class CreatePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is PostSuccessState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      var formKey = GlobalKey<FormState>();
      var postText = TextEditingController();
      return ConditionalBuilder(
        condition: cubit.userModel != null,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      var now = DateTime.now();
                      if (cubit.postImage == null) {
                        cubit.createPost(
                          postText: postText.text,
                          dateTime: now.toString(),
                        );
                      } else {
                        cubit.uploadPostImage(
                          postText: postText.text,
                          dateTime: now.toString(),
                        );
                      }
                    },
                    child: Text(
                      "New Post",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.blue),
                    ))
              ],
            ),
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (state is LoadingPostState) LinearProgressIndicator(),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage("${cubit.userModel!.profile!}"),
                            radius: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "${cubit.userModel!.name}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 17,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "What is in your mind",
                            border: InputBorder.none,
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                          ),
                          controller: postText,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "No post yet";
                            }

                            return null;
                          },
                        ),
                      ),
                      if (cubit.postImage != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        image: FileImage(cubit.postImage!))),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.close,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getPostImage();
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Upload Image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        fallback: (context) => Center(child: const CircularProgressIndicator()),
      );
    });
  }
}
