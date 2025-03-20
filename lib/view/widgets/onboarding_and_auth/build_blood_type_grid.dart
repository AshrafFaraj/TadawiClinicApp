import 'package:flutter/material.dart';
import 'package:neurology_clinic/controller/auth/registerController/register_controller.dart';
import 'package:neurology_clinic/view/widgets/onboarding_and_auth/build_selectable_card.dart';

class BuildBloodTypeGrid extends StatelessWidget {
  const BuildBloodTypeGrid({super.key, required this.controller});
  final AppSignUpControllerImp controller;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      childAspectRatio: 1.5,
      children: controller.bloodTypes
          .map((type) => BuildSelectableCard(
                text: type,
                isSelected: controller.selectedBloodType == type,
                onTap: () => controller.selectBloodType(type),
              ))
          .toList(),
    );
  }
}
