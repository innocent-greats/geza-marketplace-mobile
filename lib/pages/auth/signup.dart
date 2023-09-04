import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/models/locations.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:nft_market_place/utils/dimensions.dart';
import 'package:nft_market_place/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool terms = false;
  bool obsecure = true;
  bool confirmObsecure = true;
  final _mainController = Get.find<MainController>();
  final _authController = Get.find<AuthController>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: blackColor,
                    )),
              ],
            ),
          ),
          getStartedText(),
          heightSpace,
          heightSpace,
          heightSpace,
          firstNameTextField(),
          heightSpace,
          heightSpace,
          lastNameTextField(),
          heightSpace,
          heightSpace,
          phoneTextField(),
          heightSpace,
          heightSpace,
          label('account_type'),
          heightSpace,
          accountTypeField(),
          heightSpace,
          heightSpace,
          label('residential_city'),
          heightSpace,
          cityLocationField(),
          heightSpace,
          heightSpace,
          label('residential_area'),
          heightSpace,
          neighbourhoodLocationField(),
          heightSpace,
          heightSpace,
          termsAndCondition(),
          heightSpace,
          signupButton(),
          alreadyHaveAccountText(),
          heightSpace,
          heightSpace,
          // socialLogin(),
        ],
      ),
    );
  }

  // emailTextField(),
  // heightSpace,
  // heightSpace,
  // passwordTextField(),
  // heightSpace,
  // heightSpace,
  // confirmPasswordTextField(),
  // heightSpace,
  // heightSpace,
  label(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Utils.trimp(text),
            style: black14Bold,
          ),
          const SizedBox(height: Dimensions.heightSize * 0.5),
        ],
      ),
    );
  }

  getStartedText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get Started!',
            style: black22Bold,
          ),
          heightSpace,
          Text(
            'Create an account to continue.',
            style: black14Normal,
          ),
        ],
      ),
    );
  }

  firstNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: TextField(
          controller: firstNameController,
          style: black14Medium,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
            hintText: 'Enter your first name',
            hintStyle: grey14Medium,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.perm_identity,
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }

  lastNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: TextField(
          controller: lastNameController,
          style: black14Medium,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
            hintText: 'Enter your last name',
            hintStyle: grey14Medium,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.perm_identity_rounded,
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }

  accountTypeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: SizedBox(
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize * 0.5,
                right: Dimensions.marginSize * 0.5),
            child: Obx(() => DropdownButton(
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                    _authController.selectedAccontType.value,
                    style: black16Bold,
                  ), // Not necessary for Option 1
                  value: _authController.selectedAccontType.value,
                  onChanged: (newValue) {
                    _authController.onSelectedAccontType(newValue!);
                  },
                  items: _authController.accontTypes.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        Utils.trimp(value),
                        style: black16Bold,
                      ),
                    );
                  }).toList(),
                )),
          ),
        ),
      ),
    );
  }

  cityLocationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CustomSearchableDropDown(
                  items: populatedCities,
                  label: 'Select Residential City e.g Harare',
                  labelStyle: black16Bold,
                  dropDownMenuItems: populatedCities.map((item) {
                    return item;
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _authController.selectedCity.value = '';

                      // _mainController.selectedCity.value =
                      //     value['name'].toString();
                      _authController.onSelectedCity(value.toString());
                    } else {
                      _authController.selectedCity.value = '';
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  neighbourhoodLocationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Obx(() => CustomSearchableDropDown(
                      items: _authController.populatedNeighbourhoods,
                      label: 'Select Residential Area e.g Machipisa',
                      labelStyle: black16Bold,
                      dropDownMenuItems:
                          _authController.populatedNeighbourhoods.map((item) {
                        debugPrint(
                            'matched Area in dropdown data ${item.name}');

                        return item.name.toString().capitalize;
                      }).toList(),
                      onChanged: (value) {
                        debugPrint('onChanged dropdown data $value');
                        value.toString().toLowerCase();
                        if (value != null) {
                          _authController.selectedNeighbourhood.value = '';
                          _authController.onSelectedArea(value.name.toString());
                        } else {
                          _authController.selectedNeighbourhood.value = '';
                        }
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: const TextField(
          style: black14Medium,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
            hintText: 'Enter your email address',
            hintStyle: grey14Medium,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: black14Medium,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obsecure,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
                  hintText: 'Enter password here',
                  hintStyle: grey14Medium,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: blackColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    obsecure = !obsecure;
                  });
                },
                child: Icon(
                  (obsecure) ? Icons.visibility : Icons.visibility_off,
                  color: blackColor,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  confirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: black14Medium,
                keyboardType: TextInputType.visiblePassword,
                obscureText: confirmObsecure,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
                  hintText: 'Confirm password',
                  hintStyle: grey14Medium,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: blackColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    confirmObsecure = !confirmObsecure;
                  });
                },
                child: Icon(
                  (confirmObsecure) ? Icons.visibility : Icons.visibility_off,
                  color: blackColor,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  phoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: TextField(
          controller: phoneController,
          style: black14Medium,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
            hintText: 'Enter your mobile number',
            hintStyle: grey14Medium,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.local_phone_outlined,
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }

  termsAndCondition() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                terms = !terms;
              });
            },
            borderRadius: BorderRadius.circular(2.0),
            child: Container(
              width: 18.0,
              height: 18.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(width: 1.0, color: primaryColor),
                color: (terms) ? primaryColor : Colors.transparent,
              ),
              child: (terms)
                  ? const Icon(
                      Icons.check,
                      size: 15.0,
                      color: blackColor,
                    )
                  : Container(),
            ),
          ),
          widthSpace,
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'By creating an account, you agree to our ',
                style: black14Bold,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms and Condition',
                    style: primaryColor14Bold,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const TermsAndCondition()));
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () {
          _authController.onHandleSignUp(firstNameController.text,
              lastNameController.text, phoneController.text);
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeft,
          //         child: const OtpScreen()));
        },
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(fixPadding * 1.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: primaryColor,
          ),
          child: Obx(() => _mainController.isLoading.value == true
              ? Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(fixPadding),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SpinKitRing(
                            color: whiteColor,
                            size: 20.0,
                            lineWidth: 1,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'Please Wait...',
                            style: white14Medium,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Text(
                  'Sign Up',
                  style: black16Bold,
                )),
        ),
      ),
    );
  }

  socialLogin() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'OR',
          style: black14Medium,
        ),
        heightSpace,
        heightSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
                  width: (width - fixPadding * 5.0) / 2.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        height: 22.0,
                        width: 22.0,
                        fit: BoxFit.fill,
                      ),
                      widthSpace,
                      const Text(
                        'Google',
                        style: black14Medium,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
                  width: (width - fixPadding * 5.0) / 2.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/facebook.png',
                        height: 22.0,
                        width: 22.0,
                        fit: BoxFit.fill,
                      ),
                      widthSpace,
                      const Text(
                        'Facebook',
                        style: black14Medium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  alreadyHaveAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: black14Medium,
        ),
        width5Space,
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Text(
            'Login',
            style: primaryColor14Bold,
          ),
        ),
      ],
    );
  }
}
