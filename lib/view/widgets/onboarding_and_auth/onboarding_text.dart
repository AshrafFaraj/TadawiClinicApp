import 'package:flutter/cupertino.dart';
import 'package:neurology_clinic/core/layouts/rive_theme.dart';

class OnBoardingText extends StatelessWidget {
  const OnBoardingText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: 260,
          child: Column(children: [
            Text(
              "احجز موعدك مع الطبيب بلمسة زر",
              style: TextStyle(
                  fontSize: 50, height: 1.2, color: RiveAppTheme.background2),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              " يمكنك  الآن ومن حيثما كنت بإمكانك اختيار افضل الأطباء كفاءتاً وفي افضل المراكز الطبية والعيادات بإمكانك الحجز عن بعد وفي الوقت الملائم",
              style: TextStyle(color: RiveAppTheme.background2),
            )
          ]),
        ),
      ],
    );
  }
}
