import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/icon_broken.dart';

import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: NetworkImage("${userModel!.cover}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${userModel.profile}"),
                        radius: 60,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${userModel.name}",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 25),
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
              SizedBox(
                height: 7,
              ),
              Text(
                "${userModel.bio}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 25,
              ),
//            Padding(
//              padding: const EdgeInsets.symmetric(vertical: 30),
//              child: Row(
//                children: [
//                  Expanded(
//                    child: Column(
//                      children: [
//                        Text(
//                          "100",
//                          style: Theme.of(context).textTheme.bodyText1,
//                        ),
//                        SizedBox(
//                          height: 5,
//                        ),
//                        Text(
//                          "post",
//                          style: Theme.of(context).textTheme.subtitle1,
//                        )
//                      ],
//                    ),
//                  ),
//                  Expanded(
//                      child: Column(
//                    children: [
//                      Text(
//                        "100",
//                        style: Theme.of(context).textTheme.bodyText1,
//                      ),
//                      SizedBox(
//                        height: 5,
//                      ),
//                      Text(
//                        "post",
//                        style: Theme.of(context).textTheme.subtitle1,
//                      )
//                    ],
//                  )),
//                  Expanded(
//                      child: Column(
//                    children: [
//                      Text(
//                        "100",
//                        style: Theme.of(context).textTheme.bodyText1,
//                      ),
//                      SizedBox(
//                        height: 5,
//                      ),
//                      Text(
//                        "post",
//                        style: Theme.of(context).textTheme.subtitle1,
//                      )
//                    ],
//                  )),
//                  Expanded(
//                      child: Column(
//                    children: [
//                      Text(
//                        "100",
//                        style: Theme.of(context).textTheme.bodyText1,
//                      ),
//                      SizedBox(
//                        height: 5,
//                      ),
//                      Text(
//                        "post",
//                        style: Theme.of(context).textTheme.subtitle1,
//                      )
//                    ],
//                  ))
//                ],
//              ),
//            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Edit,color: Colors.blue,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Edit Your Profile",style: Theme.of(context).textTheme.subtitle2,),
                              ],
                            ))),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
