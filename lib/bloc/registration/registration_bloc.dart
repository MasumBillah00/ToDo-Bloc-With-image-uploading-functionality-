import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database_helper/database_helper.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final TodoDatabaseHelper databaseHelper;

  RegistrationBloc({required this.databaseHelper}) : super(const RegistrationState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onRegistrationSubmitted(
      RegistrationSubmitted event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(status: RegistrationStatus.loading));
    try {
      await databaseHelper.insertUser(state.email, state.password);
      emit(state.copyWith(status: RegistrationStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RegistrationStatus.error, message: e.toString()));
    }
  }
}
