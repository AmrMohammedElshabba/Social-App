import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/screens/chat_screen.dart';

class AnotherUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context).anotherUsers;
        return ConditionalBuilder(
            condition: cubit!.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(anotherUserModel: cubit[index],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage("${cubit[index].profile}"),
                          radius: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${cubit[index].name}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ]),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                itemCount: cubit.length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}
