import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/bloc/login/login_bloc.dart';
import 'package:todoapptask/repository/todo_repository.dart';
import 'package:todoapptask/utilis/imagepicker_utilis.dart';
import 'package:todoapptask/view/login_registration/login_screen/login_screen.dart';
import 'package:todoapptask/view/note/notetakingapp.dart';
import 'package:todoapptask/view/todo_app_screen/todo_app_screen.dart';
import 'bloc/forgot_password/forgot_password_bloc.dart';
import 'bloc/imagepicker/imagepicker_bloc.dart';
import 'bloc/note_bloc.dart';
import 'bloc/note_event.dart';
import 'bloc/registration/registration_bloc.dart';
import 'bloc/todoappbloc/todoapp_bloc.dart';
import 'database_helper/database_helper.dart';
import 'database_helper/note_database.dart'; // Import your DatabaseProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = TodoDatabaseHelper();

  const defaultEmail = 'm.billahkst@gmail.com';
  const defaultPassword = '12345';
  final existingUser =
  await databaseHelper.getUser(defaultEmail, defaultPassword);
  if (existingUser == null) {
    await databaseHelper.insertUser(defaultEmail, defaultPassword);
  }

  final noteDatabaseProvider = DatabaseProvider(); // Initialize the notes database provider

  runApp(MyApp(databaseHelper, noteDatabaseProvider));
}

class MyApp extends StatelessWidget {
  final TodoDatabaseHelper databaseHelper;
  final DatabaseProvider noteDatabaseProvider;

  const MyApp(this.databaseHelper, this.noteDatabaseProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(
            databaseHelper: TodoDatabaseHelper(),
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(databaseHelper),
        ),
        BlocProvider(
          create: (_) => ToDoAppBloc(ToDoAppRepository(databaseHelper)),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(databaseHelper),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(ImagePickerUtils()),
        ),
        BlocProvider<NoteBloc>(
          create: (_) => NoteBloc(noteDatabaseProvider)..add(LoadNotes()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.white54),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.amber,
              shadowColor: Colors.amberAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/todo': (context) => const ToDoAppScreen(),
          '/notes': (context) => NoteListPage(),
          '/noteDetail': (context) => NoteDetailPage(),
        },
      ),
    );
  }
}
