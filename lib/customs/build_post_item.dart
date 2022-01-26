import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/customs/icon_broken.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/show_comments.dart';
import 'package:social_app/screens/write_comment.dart';

Widget buildPostItem(
    PostModel postModel, context, UserModel userModel, int index) {
  return Card(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage("${postModel.profile}"),
                radius: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${postModel.name}",
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
                  Text(
                    "${postModel.dateTime}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Spacer(),
              Icon(
                IconBroken.More_Square,
              )
            ],
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width / 1.1,
          color: Colors.grey[400],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${postModel.postText}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 7,
              ),
//              Wrap(
//                children: [
//                  Container(
//                    height: 25,
//                    child: MaterialButton(
//                      onPressed: () {},
//                      child: Text('#Software_developer',style: Theme.of(context).textTheme.subtitle2,),
//                      minWidth: 1,
//                      padding: EdgeInsets.zero,
//                    ),
//                  ),
//                  Container(
//                    height: 25,
//                    child: MaterialButton(
//                      onPressed: () {},
//                      child: Text('#Software_engineer',style: Theme.of(context).textTheme.subtitle2,),
//                      minWidth: 1,
//                      padding: EdgeInsets.zero,
//                    ),
//                  ),
//                  Container(
//                    height: 25,
//                    child: MaterialButton(
//                      onPressed: () {},
//                      child: Text('#Flutter_developer',style: Theme.of(context).textTheme.subtitle2,),
//                      minWidth: 1,
//                      padding: EdgeInsets.zero,
//                    ),
//                  ),
//                  Container(
//                    height: 25,
//                    child: MaterialButton(
//                      onPressed: () {},
//                      child: Text('#Software',style: Theme.of(context).textTheme.subtitle2,),
//                      minWidth: 1,
//                      padding: EdgeInsets.zero,
//                    ),
//                  ),
//                ],
//              ),
              if (postModel.postImage != "")
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage('${postModel.postImage}'),
                        fit: BoxFit.cover),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  Icon(IconBroken.Chat),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowComments(
                                    postId:
                                        SocialCubit.get(context).postId[index],
                                  )));
                    },
                    child: Text(
                      "comments",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width / 1.1,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("${userModel.profile}"),
                    radius: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WriteComment(
                                    postId: SocialCubit.get(context)
                                        .postId[index])));
                      },
                      child: Text(
                        "Write a comment ...",
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                  Spacer(),
                  ConditionalBuilder(
                    condition: SocialCubit.get(context)
                            .getLike![SocialCubit.get(context).postId[index]] !=
                        null,
                    builder: (context) {
                      return Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).likePost(
                                    SocialCubit.get(context).postId[index]);
                              },
                              icon: SocialCubit.get(context).getLike![
                                          SocialCubit.get(context)
                                              .postId[index]]! ||
                                      SocialCubit.get(context).getLike! == null
                                  ? Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.sentiment_very_satisfied,
                                    )),
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).disLikePost(
                                    SocialCubit.get(context).postId[index]);
                              },
                              icon: Icon(
                                Icons.sentiment_very_dissatisfied,
                              )),
                        ],
                      );
                    },
                    fallback: (context) => Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).likePost(
                                  SocialCubit.get(context).postId[index]);
                            },
                            icon: Icon(
                              Icons.sentiment_very_satisfied,
                            )),
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).disLikePost(
                                  SocialCubit.get(context).postId[index]);
                            },
                            icon: Icon(
                              Icons.sentiment_very_dissatisfied,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
