import 'package:flutter/material.dart';

class CustomAnimatedPosition extends StatelessWidget {
  const CustomAnimatedPosition(
      {super.key,
      required this.height,
      required this.width,
      this.isSignInDialogShown = false});
  final bool isSignInDialogShown;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      top: isSignInDialogShown ? -50 : 0,
      height: height,
      width: width,
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(),
            SizedBox(
              width: 260,
              child: Column(children: [
                Text(
                  "احجز موعدك مع الطبيب بلمسة زر",
                  style: TextStyle(fontSize: 50, height: 1.2),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    " يمكنك  الآن ومن حيثما كنت بإمكانك اختيار افضل الأطباء كفاءتاً وفي افضل المراكز الطبية والعيادات بإمكانك الحجز عن بعد وفي الوقت الملائم")
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
