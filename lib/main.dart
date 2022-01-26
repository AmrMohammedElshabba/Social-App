import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/screens/home_layout.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/themes.dart';

import 'constans.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubit/cubit_observer.dart';
import 'cubit/social_cubit.dart';
import 'network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Widget startWidget = LoginScreen();
  uId = CacheHelper.getData(key: "uId");
  bool? darkMode = CacheHelper.getData(key: "lightMode");
  if (darkMode == null) {
    darkMode = false;
  }
  if (uId != null) {
    startWidget = HomeLayout();
  } else {
    startWidget = LoginScreen();
  }
  runApp(MyApp(
    darkMode: darkMode,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool darkMode;

  MyApp({required this.startWidget, required this.darkMode});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SocialCubit()
                ..getUser()
                ..getPosts()
                ..getLikes()
                ..getAllUser()
                ..changeAppMode(fromShare: darkMode)
                ..getComments()),
        ],
        child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: cubit.darkMode ? ThemeMode.dark : ThemeMode.light,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              home: startWidget,
            );
          },
        ),);
  }
}
