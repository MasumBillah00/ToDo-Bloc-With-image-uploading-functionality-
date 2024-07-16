import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendOtpEmail(String email, String otp) async {
  final smtpServer = SmtpServer('smtp.example.com',
      username: 'your_username',
      password: 'your_password',
      port: 587); // Replace with your SMTP server details

  final message = Message()
    ..from = Address('your_email@example.com', 'Your App Name')
    ..recipients.add(email)
    ..subject = 'Your OTP Code'
    ..text = 'Your OTP code is $otp';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n' + e.toString());
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
