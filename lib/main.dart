
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/bloc/login/login_bloc.dart';
import 'package:todoapptask/repository/todo_repository.dart';
import 'package:todoapptask/view/login_screen/login_screen.dart';
import 'bloc/todoappbloc/todoapp_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>LoginBloc()),
      BlocProvider(create: (_)=>ToDoAppBloc((ToDoAppRepository()))),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.dark,


      ),
      home: const NewLoginScreen(),
    ),);

  }
}

