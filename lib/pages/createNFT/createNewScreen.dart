// ignore_for_file: file_names

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/file_service_controller.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/controllers/sales_controller.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:nft_market_place/utils/dimensions.dart';
import 'package:nft_market_place/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

class CreateNewScreen extends StatefulWidget {
  const CreateNewScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewScreen> createState() => _CreateNewScreenState();
}

class _CreateNewScreenState extends State<CreateNewScreen> {
  final MainController _mainController = Get.put(MainController());
  final FileServiceController fileServiceController =
      Get.put(FileServiceController());
  final SalesController salesController = Get.put(SalesController());
  TextEditingController itemNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: false,
        title: const Text(
          'Add New Service Offer',
          style: black18Bold,
        ),
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: blackColor,
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
          child: InkWell(
            onTap: () {
              salesController.createNewOfferItem(
                itemNameController.text,
                priceController.text,
                itemDescriptionController.text,
              );
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft,
              //         child: const SetPrice()));
            },
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 40.0,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryColor,
              ),
              child: const Text(
                'Continue',
                style: black16Bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                uploadFile(),
                heightSpace,
                offerItemImages(),
                heightSpace,
                heightSpace,
                textFields(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  uploadFile() {
    return InkWell(
      onTap: () {
        fileServiceController.pickOfferItemImagesFromLocalStorage();
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10.0),
        color: blackColor,
        strokeWidth: 1.0,
        strokeCap: StrokeCap.round,
        dashPattern: const [4, 4],
        child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(vertical: fixPadding * 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(
                  File(fileServiceController.selectedOfferItemImagePath.value
                      .toString()),
                )),
                borderRadius: BorderRadius.circular(10.0),
                color: whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150.0,
                    height: 100.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: primary2Color.withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.cloud_upload,
                          color: whiteColor,
                        ),
                        heightSpace,
                        const Text(
                          'Upload your file',
                          style: white14Medium,
                        ),
                        heightSpace,
                        Text(
                          '(jpeg, png, webp)'.toUpperCase(),
                          style: white14Medium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  offerItemImages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height5Space,
        Obx(() => fileServiceController.isImageAdded.value == true
            ? SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fileServiceController.xImageFiles.length,
                  itemBuilder: (context, index) {
                    XFile image = fileServiceController.xImageFiles[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          fileServiceController
                              .onChangeImage(image.path.toString());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(image.path.toString()),
                            height: 80, width: 80,
                            // width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Column()),
      ],
    );
  }

  textFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: Dimensions.heightSize),
              child: Text(
                'Specialization',
                style: black14Bold,
              ),
            ),
            const SizedBox(height: Dimensions.heightSize * 0.5),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.radius)),
                  border: Border.all(color: Colors.black.withOpacity(0.1))),
              child: Obx(() => Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.marginSize * 0.5,
                        right: Dimensions.marginSize * 0.5),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: Container(),
                      hint: Text(
                        salesController.selectedOfferCategory.value,
                        style: black16Bold,
                      ), // Not necessary for Option 1
                      value: salesController.selectedOfferCategory.value,
                      onChanged: (newValue) {
                        salesController.onSelectedOfferCategory(newValue!);
                      },
                      items: salesController.offerCategories.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            Utils.trimp(value),
                            style: black16Bold,
                          ),
                        );
                      }).toList(),
                    ),
                  )),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        const Text(
          'Offer Name',
          style: black14Bold,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimensions.radius)),
              border: Border.all(color: Colors.black.withOpacity(0.1))),
          child: TextField(
            controller: itemNameController,
            style: black14Medium,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Title of your offer',
              hintStyle: grey14Medium,
              border: InputBorder.none,
            ),
          ),
        ),
        heightSpace,
        heightSpace,
        const Text(
          'Price',
          style: black14Bold,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimensions.radius)),
              border: Border.all(color: Colors.black.withOpacity(0.1))),
          child: TextField(
            controller: priceController,
            style: black14Medium,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Price of your offer',
              hintStyle: grey14Medium,
              border: InputBorder.none,
            ),
          ),
        ),
        heightSpace,
        heightSpace,
        const Text(
          'Description',
          style: black14Bold,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimensions.radius)),
              border: Border.all(color: Colors.black.withOpacity(0.1))),
          child: TextField(
            controller: itemDescriptionController,
            style: black14Medium,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Description of your offer',
              hintStyle: grey14Medium,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
