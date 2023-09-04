// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = 'Joseph Reese';
    userNameController.text = '@reesejoseph';
    emailController.text = 'peter@test.com';
    phoneController.text = '123456789';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        titleSpacing: 0.0,
        centerTitle: false,
        title: const Text(
          'Edit Profile',
          style: white18Bold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
          ),
        ),
      ),
      body: ListView(
        children: [
          userImage(),
          heightSpace,
          heightSpace,
          fullName(),
          heightSpace,
          heightSpace,
          userName(),
          heightSpace,
          heightSpace,
          emailAddress(),
          heightSpace,
          heightSpace,
          phoneNumber(),
          heightSpace,
          heightSpace,
          updateButton(),
        ],
      ),
    );
  }

  userImage() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        width: 80.0,
        height: 80.0,
        child: Stack(
          children: [
            Hero(
              tag: 'userImage',
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  image: const DecorationImage(
                      image: AssetImage('assets/user.png'), fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: InkWell(
                onTap: () => chooseOptionBottomsheet(),
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: primaryColor,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18.0,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fullName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Full Name',
            style: grey14Medium,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: TextField(
              controller: nameController,
              style: white14Medium,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Enter your full name',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  userName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Username',
            style: grey14Medium,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: TextField(
              controller: userNameController,
              style: white14Medium,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Enter your username',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  emailAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email Address',
            style: grey14Medium,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: TextField(
              controller: emailController,
              style: white14Medium,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Enter your email address',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  phoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone Number',
            style: grey14Medium,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: TextField(
              controller: phoneController,
              style: white14Medium,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Enter your phone number',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateButton() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(fixPadding * 1.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: primaryColor,
          ),
          child: const Text(
            'Update',
            style: white16Bold,
          ),
        ),
      ),
    );
  }

  chooseOptionBottomsheet() {
    optionTile(icon, color, title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: color,
            ),
            child: Icon(
              icon,
              color: whiteColor,
              size: 18.0,
            ),
          ),
          widthSpace,
          Text(
            title,
            style: white14Bold,
          ),
        ],
      );
    }

    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose Option',
                    style: white16Bold,
                  ),
                  heightSpace,
                  heightSpace,
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: optionTile(Icons.camera_alt, Colors.teal, 'Camera'),
                  ),
                  heightSpace,
                  heightSpace,
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child:
                        optionTile(Icons.photo_album, Colors.blue, 'Gallery'),
                  ),
                  heightSpace,
                  heightSpace,
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: optionTile(
                        Icons.delete_forever, Colors.red, 'Remove Photo'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
