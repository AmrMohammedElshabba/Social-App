import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';

class ShowComments extends StatelessWidget {
  final String postId;

  const ShowComments({Key? key, required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialCubit.get(context).getComment;
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: cubit![postId] != null,
            builder: (context)=> ListView.separated(itemBuilder: (context,index){
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${cubit[postId]![index]['user']},",style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),),
                            Text("${cubit[postId]![index]['comment']},",style: Theme.of(context).textTheme.bodyText1,),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }, separatorBuilder: (context, index){
              return SizedBox(height: 20 ,);
            }, itemCount: cubit[postId]!.length),
            fallback: (context)=> Center(
              child: Text("Not comment yet",style: Theme.of(context).textTheme.headline2,),
            ),
          ),
        );
      },
    );
  }
}
