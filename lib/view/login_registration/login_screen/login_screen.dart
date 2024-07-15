import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/login_registration/forgot_password/forgot_password.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_event.dart';
import '../../../bloc/login/login_state.dart';

import '../../registration_screen/registration_screen.dart';
import '../../todo_app_screen/todo_app_screen.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ToDoAppScreen()),
            );
          } else if (state.status == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        focusNode: emailFocusNode,
                        onChanged: (value) {
                          _loginBloc.add(EmailChanged(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: passwordFocusNode,
                        obscureText: true,
                        onChanged: (value) {
                          _loginBloc.add(PasswordChanged(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          } else if (value.length < 5) {
                            return 'Password must be at least 5 characters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),

                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _loginBloc.add(LoginSubmitted());
                          }
                        },
                        child: state.status == LoginStatus.loading
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : const Text('Log In',style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,

                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Create New account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
