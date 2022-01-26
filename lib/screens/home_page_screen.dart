import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/build_post_item.dart';
import 'package:social_app/screens/create_post.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return RefreshIndicator(
              onRefresh: () async{
                cubit.getUser();
                cubit.getPosts();
                cubit.getLikes();
              },
              child: ConditionalBuilder(
                condition:  cubit.userModel != null ,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        postCart(cubit.userModel!.profile!, context),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildPostItem(
                                  cubit.posts[index], context, cubit.userModel!, index);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 4,
                                ),
                            itemCount: cubit.posts.length)
                      ],
                    ),
                  ),
                ),
                fallback: (context) => ConditionalBuilder(condition: cubit.userModel != null, builder: (context)=>Column(
                  children: [
                    postCart(cubit.userModel!.profile!, context),
                    SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                    Center(
                      child: Text("Not post yet",style: Theme.of(context).textTheme.headline2,),
                    )
                  ],
                ), fallback: (context)=> Center(child: CircularProgressIndicator())),
              ),
            );
          },
        );
      }
  }

  Widget postCart(String profileImage, context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
              radius: 25,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreatePost()));
                },
                child: Text(
                  "What is in your mind ...",
                  style: Theme.of(context).textTheme.subtitle1,
                ))
          ],
        ),
      ),
    );
  }

