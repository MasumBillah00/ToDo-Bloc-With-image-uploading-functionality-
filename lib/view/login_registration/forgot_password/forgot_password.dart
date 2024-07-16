import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/login_registration/forgot_password/otp_screen.dart';
import '../../../bloc/forgot_password/forgot_password_bloc.dart';
import '../../../bloc/forgot_password/forgot_password_event.dart';
import '../../../bloc/forgot_password/forgot_password_state.dart';


class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordEmailSent) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpScreen(email: _emailController.text),
                ),
              );
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter Your Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<ForgotPasswordBloc>().add(
                      ForgotPasswordEmailSubmitted(_emailController.text.trim()),
                    );
                  },
                  child: Text('Send OTP'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
