import 'package:expense_tracker/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:expense_tracker/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:expense_tracker/features/auth/presentation/view_model/auth_state.dart';
import 'package:expense_tracker/features/home/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Center(child: Text("Logged in successfully")),
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            } else if (state is FailureAuthState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.failMsg),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo.jpeg",
                          height: 150,
                          width: 200,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "قرشين وبنعدهم",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 5, 5, 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) => password = value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility_off),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 34, 9, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().signIn(
                          email: email,
                          password: password,
                        );
                      },
                      child: state is LoadingAuthState
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Don't have an account?  Sign Up",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 45, 0, 248),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
