import 'package:flutter/cupertino.dart';
import 'package:neurology_clinic/core/layouts/app_color_theme.dart';

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
                  fontSize: 52,
                  letterSpacing: -1,
                  height: 1.2,
                  color: AppColorTheme.background2),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              " يمكنك  الآن وحيثما كنت اختيار أفضل الأطباء كفاءتاً وفي افضل العيادات بإمكانك الحجز عن بعد وسيتم إشعارك بحلول موعدك مع الطبيب ومن ثم مراجعة أدويتك حيث سيتم تذكيرك دائماً بأوقات استعمالها",
              style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -1,
                  color: AppColorTheme.background2),
            )
          ]),
        ),
      ],
    );
  }
}
