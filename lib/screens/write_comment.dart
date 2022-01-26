import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';

class WriteComment extends StatelessWidget {
  final String postId;

  const WriteComment({Key? key, required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is CommentSuccessState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      var formKey = GlobalKey<FormState>();
      var commentText = TextEditingController();
      return ConditionalBuilder(
        condition: cubit.userModel != null,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.writeComment(postId, commentText.text);
                    },
                    child: Text(
                      "Write a Comment",
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
                          decoration:  InputDecoration(
                            hintText: "Write your comment",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            border: InputBorder.none,
                          ),
                          controller: commentText,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "No post yet";
                            }

                            return null;
                          },
                        ),
                      ),
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
