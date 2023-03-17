import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: LottieBuilder.network(
                  "https://assets5.lottiefiles.com/packages/lf20_j4jnpgqd/.json",
                  fit: BoxFit.fill),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Habbit Tracker',
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
              ],
              totalRepeatCount: 1,
              pause: const Duration(seconds: 3),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
