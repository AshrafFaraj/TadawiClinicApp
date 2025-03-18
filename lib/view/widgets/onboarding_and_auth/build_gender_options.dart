import 'package:flutter/material.dart';
import 'package:neurology_clinic/controller/auth/registerController/register_controller.dart';
import 'package:neurology_clinic/view/widgets/onboarding_and_auth/build_selectable_card.dart';

class BuildGenderOptions extends StatelessWidget {
  const BuildGenderOptions({
    super.key,
    required this.controller,
  });
  final AppSignUpControllerImp controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: controller.genders
          .map((gender) => Expanded(
                child: BuildSelectableCard(
                  text: gender,
                  isSelected: controller.selectedGender == gender,
                  onTap: () => controller.selectGender(gender),
                ),
              ))
          .toList(),
    );
  }
}
