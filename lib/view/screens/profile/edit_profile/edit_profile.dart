import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/edit_profile/edit_profile_controller.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text("editProfile".tr),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: IconButton(
                onPressed: () {
                  controller.updateProfile(nameController.text,
                      phoneController.text, addressController.text);
                  Get.back();
                  Get.snackbar(
                    'تم', // No title
                    'تم تعديل البيانات بنجاح', // Message
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueAccent,
                    colorText: Colors.white,
                    margin: EdgeInsets.all(10), // Small margin around
                    borderRadius: 30, // Make it bubbly by rounding corners
                    duration: Duration(seconds: 2),
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20), // Less padding for smaller size
                    icon: Icon(Icons.check_circle,
                        color: Colors.white), // Add an icon
                    boxShadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: Offset(0, 4), // Shadow effect
                      ),
                    ],
                  );
                },
                icon: Icon(Icons.check)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: const ProfilePic()),
            const SizedBox(height: 30),
            Text(
              "aboutMe".tr,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
                width: size.width,
                // margin: EdgeInsets.all(15),
                // height: size.height * .2,
                decoration: BoxDecoration(color: Colors.white),
                child: GetBuilder<EditProfileController>(
                  builder: (controller) {
                    nameController.text = controller.name;
                    phoneController.text = controller.mobile;
                    addressController.text = controller.address;
                    return Column(
                      children: [
                        CustomizedTextField(
                          controller: nameController,
                          isNumber: false,
                          onChanged: (p0) {
                            nameController.text = p0;
                          },
                          hintText: "name".tr,
                        ),
                        CustomizedTextField(
                          controller: phoneController,
                          isNumber: true,
                          onChanged: (p0) {
                            phoneController.text = p0;
                          },
                          hintText: "mobile".tr,
                        ),
                        CustomizedTextField(
                          controller: addressController,
                          isNumber: false,
                          onChanged: (p0) {
                            addressController.text = p0;
                          },
                          hintText: "address".tr,
                        ),
                      ],
                    );
                  },
                )),
            SizedBox(
              height: 35,
            ),
            Text(
              "bloodType".tr,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 14,
            ),
            GetBuilder<EditProfileController>(
              builder: (controller) {
                return InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Select Blood Type',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Divider(),
                              ...controller.bloodType.map((type) => ListTile(
                                    title: Text(type),
                                    onTap: () {
                                      controller.changeBloodType(type);
                                      Get.back();
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${controller.selectedBloodType}",
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black45,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              "gender".tr,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 14,
            ),
            GetBuilder<EditProfileController>(
              builder: (controller) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: controller.genders.map((gender) {
                    return ElevatedButton(
                        onPressed: () {
                          controller.changeGender(gender);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(110, 50),
                          // side: BorderSide(
                          //   color: controller.selectedBloodType == gender
                          //       ? Colors.red
                          //       : Colors.grey,
                          // ),
                          side: controller.selectedGender == gender
                              ? BorderSide(color: Colors.red)
                              : BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          gender,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ));
                  }).toList(),
                );
              },
            ),

            // GetBuilder<EditProfileController>(
            //   builder: (controller) {
            //     return Wrap(
            //       spacing: 10,
            //       runSpacing: 10,
            //       children: controller.bloodType.map((bloodType) {
            //         return ElevatedButton(
            //             onPressed: () {
            //               controller.changeBloodType(bloodType);
            //             },
            //             style: ElevatedButton.styleFrom(
            //               fixedSize: Size(101, 15),
            //               side: BorderSide(
            //                 color: controller.selectedBloodType == bloodType
            //                     ? Colors.red
            //                     : Colors.grey,
            //               ),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             ),
            //             child: Text(
            //               bloodType,
            //               style: TextStyle(fontSize: 12, color: Colors.black),
            //             ));
            //       }).toList(),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    required this.isNumber,
  });
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextField(
        keyboardType:
            isNumber == false ? TextInputType.text : TextInputType.phone,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage:
                NetworkImage("https://i.postimg.cc/0jqKB6mS/Profile-Image.png"),
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

const cameraIcon =
    '''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';
