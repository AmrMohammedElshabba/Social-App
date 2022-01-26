import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/icon_broken.dart';
import 'package:social_app/models/chat_model.dart';
import 'package:social_app/models/user_model.dart';

import '../constans.dart';

class ChatScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var messageText = TextEditingController();
  final UserModel anotherUserModel;

  ChatScreen({Key? key, required this.anotherUserModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {

      SocialCubit.get(context)
          .reciveMessages(reciverId: anotherUserModel.userID!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var user = SocialCubit.get(context).userModel;
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("${anotherUserModel.profile}"),
                    radius: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${anotherUserModel.name}"),
                ],
              ),
            ),
            body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages!.isNotEmpty,
                builder: (context) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages![index];
                              if (user!.userID == message.senderId) {
                                return myMessage(user, context, message);
                              }
                              return anotherUserMessage(context, message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 1,
                                ),
                            itemCount: SocialCubit.get(context).messages!.length),
                      ),
                      customFormFieldWithIconButton(context)
                    ],
                  );
                },
                fallback: (context) => Column(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(
                          "Not Message Yet",
                          style: Theme.of(context).textTheme.headline2,
                        ))),
                        customFormFieldWithIconButton(context)
                      ],
                    )),
          );
        },
      );
    });
  }

  Widget anotherUserMessage(context, MessageModel messageModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("${anotherUserModel.profile}"),
              radius: 25,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                ),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text(
                '${messageModel.text}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myMessage(UserModel user, context, MessageModel messageModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  bottomStart: Radius.circular(10.0),
                ),
                color: Colors.blue[200],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text(
                '${messageModel.text}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage("${user.profile}"),
              radius: 25,
            ),
          ],
        ),
      ),
    );
  }
  Widget customFormFieldWithIconButton(context){
    return Form(
      key: formKey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: messageText,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "type your message here..",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                  SocialCubit.get(context).sendMessages(
                  text: messageText.text,
                  dateTime: DateTime.now().toString(),
                  reciverId: anotherUserModel.userID!);
                  }
                },
                child: Icon(
                  IconBroken.Send,
                  color: defaultColor,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
