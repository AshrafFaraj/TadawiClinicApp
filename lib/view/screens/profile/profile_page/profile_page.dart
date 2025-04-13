import 'package:flutter/material.dart';
// TODO: add flutter_svg to pubspec.yaml
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/profile_controller/profile_controller.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';
import 'package:neurology_clinic/core/constants/app_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("profile".tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            GetBuilder<ProfileController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      controller.selectedImage != null
                          ? Image.file(controller.selectedImage!, height: 150)
                          : Icon(Icons.account_circle, size: 150),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.pickImage,
                        child: Text("Pick Image"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : controller.uploadImage,
                        child: controller.isLoading
                            ? CircularProgressIndicator()
                            : Text("Upload"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "personalInfo".tr,
              svgSrc: AppSvg.profileSvg,
              press: () {
                Get.toNamed(AppRouteName.editProfile);
              },
            ),
            ProfileMenu(
              text: "notification".tr,
              svgSrc: AppSvg.notifications,
              press: () {
                Get.toNamed(AppRouteName.editProfile);
              },
            ),
            ProfileMenu(
              text: "settings".tr,
              svgSrc: AppSvg.settings,
              press: () {
                Get.toNamed(AppRouteName.settingsPage);
              },
            ),
            ProfileMenu(
              text: "helpCenter".tr,
              svgSrc: AppSvg.helpCenter,
              press: () {
                Get.toNamed(AppRouteName.helpCenter);
              },
            ),
            ProfileMenu(
              text: "logout".tr,
              svgSrc: AppSvg.logOut,
              press: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    this.onPressed,
    this.backgroundImage,
  }) : super(key: key);
  final void Function()? onPressed;
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: backgroundImage,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.string(cameraIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
    this.svgSrc,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;
  final String? svgSrc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              svgSrc!,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                const Color(0xFF010F07).withOpacity(0.64),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}

const cameraIcon =
    '''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';
const profileIconSvg =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M8.66667 7.83333C8.66667 9.67428 10.1591 11.1667 12 11.1667C13.8409 11.1667 15.3333 9.67428 15.3333 7.83333C15.3333 5.99238 13.8409 4.5 12 4.5C10.1591 4.5 8.66667 5.99238 8.66667 7.83333ZM11.9861 12.8333C8.05159 12.8333 4.82355 14.8554 4.50054 18.8327C4.48295 19.0493 4.89726 19.5 5.10625 19.5H18.8722C19.4983 19.5 19.508 18.9962 19.4983 18.8333C19.2541 14.7443 15.976 12.8333 11.9861 12.8333Z" fill="#010F07"/>
</svg>
''';
