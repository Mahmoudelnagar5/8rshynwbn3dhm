import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/auth/presentation/view_model/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitAuthState());
  void signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      emit(LoadingAuthState());
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection("user")
          .doc(credential.user!.uid)
          .set({"User Name": userName, "Email": email, "Password": password});

      await credential.user!.sendEmailVerification();
      emit(EmailVerificationSentState());
    } catch (e) {
      print(e.toString());
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        emit(EmailVerificationSentState());
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      emit(LoadingAuthState());
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        var box = await Hive.openBox('auth');
        box.put('isLoggedIn', true);
        box.put('userId', user.uid);
        emit(EmailVerifiedState());
      } else {
        emit(EmailNotVerifiedState());
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(LoadingAuthState());
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null && !credential.user!.emailVerified) {
        emit(EmailNotVerifiedState());
        return;
      }

      emit(AuthSuccessState());
      var box = await Hive.openBox('auth');
      box.put('isLoggedIn', true);
      box.put('userId', credential.user!.uid);
    } catch (e) {
      print(e.toString());
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(LoadingAuthState());
      // await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      var box = await Hive.openBox('auth');
      await box.put('isLoggedIn', false);
      await box.clear();

      emit(SignOutState());
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }
}
