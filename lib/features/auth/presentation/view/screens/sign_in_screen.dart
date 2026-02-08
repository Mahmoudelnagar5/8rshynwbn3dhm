import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.jpeg",
                    height: 300,
                    width: 200,
                  ),
                  SizedBox(height: 10),
                  Text("قرشين وبنعدهم")و
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
