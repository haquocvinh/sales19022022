import 'package:flutter/material.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/data/local/share_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        String tokenCode = await SharePre.instance.get(AppConstant.tokenCode);
        if (tokenCode.isNotEmpty) {
          Navigator.pushReplacementNamed(context, AppConstant.productRouteName);
        } else {
          Navigator.pushReplacementNamed(context, AppConstant.loginRouteName);
        }
      } catch (e) {
        Navigator.pushReplacementNamed(context, AppConstant.loginRouteName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset(
          AppConstant.imgSlash,
          width: MediaQuery.of(context).size.width / 1.0,
        ),
        const Center(
            //child: LoadingWidget(),
            ),
        const Text("PHA NAM",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.blue,
            )),
      ]),
    ));
  }
}
