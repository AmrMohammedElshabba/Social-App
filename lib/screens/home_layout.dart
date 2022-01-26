import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/icon_broken.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/screens/setting_screen.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: cubit.bottomNavItems,
                onTap: (index) {
                  cubit.ChangeBottomNav(index);
                },
                currentIndex: cubit.currentIndex,
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                        child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage("${cubit.userModel!.profile}"),
                          radius: 30,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "${cubit.userModel!.name}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${cubit.userModel!.email}",
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    )),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(IconBroken.Profile),
                          SizedBox(width: 5,),
                          Text("profile", style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                      },
                    ),
                    ListTile(
                      title: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.dark_mode_outlined),
                            SizedBox(width: 5,),
                            Text("Dark Mode",
                                style: Theme.of(context).textTheme.bodyText1),
                            Spacer(),
                            Switch(activeColor: Colors.blue,value: cubit.darkMode, onChanged: (v){
                              cubit.changeAppMode();
                            })
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title:  Row(
                        children: [
                          Icon(IconBroken.Logout),
                          SizedBox(width: 5,),
                          Text("Log out", style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                      onTap: () {
                        cubit.SignOut();
                      },
                    )
                  ],
                ),
              ),
              appBar: AppBar(
                title: Text(cubit.title[cubit.currentIndex]),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
