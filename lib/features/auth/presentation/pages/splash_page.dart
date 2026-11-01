import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_saver/core/theme/app_colors.dart';

import '../../../../app/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
String subTitle = ".....Save Energy";
late Timer time ;
class _SplashPageState extends State<SplashPage> {

  void navtoscreen () {
    Timer(Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          subTitle = "Better Life.";
        });
      }
    });

    time = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
    });
  }
  void initState() {
    navtoscreen();
    super.initState();

  }
  @override
  void dispose() {
    time.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:
          Center(
            child: Column( mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/img.png',width: 200,height: 200,),
                SizedBox(height: 5),
                Text(
                  "Power Saver",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: AppColors.textHint, fontSize: 14),
                ),
              ],
            ),
          ),
        )
    );
  }
}