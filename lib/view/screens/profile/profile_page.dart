import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurology_clinic/core/constants/app_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      // backgroundColor: color.primaryContainer,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 25.0),
                width: size.width,
                height: size.height * .2,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ahmed Anam",
                          style:
                              text.headlineSmall!.copyWith(color: Colors.white),
                        ),
                        Text(
                          "Male",
                          style: text.labelLarge!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: Colors.indigoAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Add spacing to avoid overlapping
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomizedContainer(
                    size: size,
                    text: text,
                    mainText: "AGE",
                    numberText: "year old",
                    subText: "24 ",
                  ),
                  CustomizedContainer(
                    size: size,
                    text: text,
                    mainText: "BLOOD",
                    numberText: "O+",
                    subText: "",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomizedContainer extends StatelessWidget {
  const CustomizedContainer({
    super.key,
    required this.size,
    required this.text,
    required this.mainText,
    required this.numberText,
    required this.subText,
  });

  final Size size;
  final TextTheme text;
  final String mainText;
  final String numberText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      width: size.width * .45,
      height: size.height * .15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // Spread effect
            blurRadius: 0.5, // Blur intensity
            offset: Offset(4, 4), // Position (x, y)
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  mainText,
                  style: text.headlineSmall,
                ),
              ),
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset(
                    AppSvg.heart,
                    width: 20,
                    fit: BoxFit.none,
                  ))
            ],
          ),
          Row(
            children: [
              Text(
                subText,
                style: text.headlineMedium,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  numberText,
                  style: text.labelLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
