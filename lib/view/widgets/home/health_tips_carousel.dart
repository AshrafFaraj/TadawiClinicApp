import 'package:flutter/material.dart';
import '/demo/models/courses.dart';
import '../../../core/layouts/rive_theme.dart';

class HealthTipsCarousel extends StatelessWidget {
  const HealthTipsCarousel({super.key});
  static List<CourseModel> tips = [
    CourseModel(title: "نصائح لتحسين النوم", color: const Color(0xFF9CC5FF)),
    CourseModel(
        title: "تمارين لتقليل الصداع النصفي", color: const Color(0xFFBBA6FF)),
    CourseModel(title: "كيف تحسن صحتك العقلية", color: const Color(0xFF6E6AE8)),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Text("نصائح صحية",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: RiveAppTheme.shadowDark)),
        ),
        const SizedBox(height: 10),
        Container(
          color: RiveAppTheme.backgroundDark,
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return Container(
                  constraints: const BoxConstraints(maxHeight: 60),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: tips[index].color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    tips[index].title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )));
            },
          ),
        ),
      ],
    );
  }
}
