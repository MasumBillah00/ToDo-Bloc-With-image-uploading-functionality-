
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/bloc/login/login_bloc.dart';
import 'package:todoapptask/repository/todo_repository.dart';
import 'package:todoapptask/view/login_screen/login_screen.dart';
import 'package:todoapptask/view/todo_app_screen/todo_app_screen.dart';
import 'bloc/todoappbloc/todoapp_bloc.dart';
import 'database_helper/database_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = TodoDatabaseHelper();
  runApp(MyApp(databaseHelper));
}

class MyApp extends StatelessWidget {
  final TodoDatabaseHelper databaseHelper;

  MyApp(this.databaseHelper);

  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>LoginBloc()),
      BlocProvider(create: (_)=>ToDoAppBloc((ToDoAppRepository(databaseHelper)))),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.dark,


      ),
      home:  const ToDoAppScreen(),
    ),);

  }
}