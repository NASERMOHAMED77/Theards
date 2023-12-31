import 'package:firebase_core/firebase_core.dart';
import 'package:firee/constant.dart';
import 'package:firee/core/utils/local_shared_pref.dart';
import 'package:firee/core/utils/service_locator.dart';
import 'package:firee/features/home/data/repos/home_screen_repo/home_repo_imp.dart';
import 'package:firee/features/home/data/repos/search_screen_repo/search_repo_imp.dart';
import 'package:firee/features/home/persentation/manager/home_cubit/home_cubit.dart';
import 'package:firee/features/home/persentation/manager/post_screen_cubit/post_screen_cubit.dart';
import 'package:firee/features/home/persentation/manager/search_cubit/search_cubit.dart';
import 'package:firee/features/login_screen/persentation/manger/login_screen_cubit/login_screen_cubit.dart';
import 'package:firee/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'features/login_screen/data/repo/login_repo_imp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheLocal.sharedPrefInt();
  token = CacheLocal.getDataFromCache(key: 'token');
  get_locator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LoginCubit(get_it.get<X>())),
    BlocProvider(create: (context) => PostCubit()),
    BlocProvider(create: (context) => HomeCubit(get_it.get<HomeRepoImpe>())),
    BlocProvider(create: (context) => SearchCubit(get_it.get<SearchRepoImp>())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
