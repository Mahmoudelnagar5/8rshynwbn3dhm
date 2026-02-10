import 'package:expense_tracker/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:expense_tracker/features/auth/presentation/view_model/auth_state.dart';
import 'package:expense_tracker/features/home/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/snackbar_utils.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is EmailVerifiedState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
            showSuccessSnackBar(context, "Email verified successfully!");
          } else if (state is FailureAuthState) {
            showErrorSnackBar(context, state.failMsg);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mark_email_unread_outlined,
                  size: 100,
                  color: Color.fromARGB(255, 34, 9, 255),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Verify Your Email',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'We\'ve sent a verification link to your email address. Please check your inbox and click the link to verify.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF717182),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            34,
                            9,
                            255,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: state is LoadingAuthState
                            ? null
                            : () {
                                context.read<AuthCubit>().checkEmailVerified();
                              },
                        child: state is LoadingAuthState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "I've Verified My Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back to Sign In",
                    style: TextStyle(color: Color(0xFF717182), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
