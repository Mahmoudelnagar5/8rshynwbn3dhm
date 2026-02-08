import 'package:expense_tracker/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 247, 247, 247),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo2.jpeg",
                        height: height * .3,
                        width: width * 0.4,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "قرشين وبنعدهم",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: obscurePassword,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 9, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("Success!");
                      }
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 45, 0, 248),
                      fontSize: 18,
                    ),
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
