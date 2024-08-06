import 'package:flutter/material.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/utils/colors.dart';

import 'widgets/textfield_for_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();

  bool allFieldsFilled = false;

  @override
  void initState() {
    super.initState();
    firstNameFocusNode.addListener(() => handleFocusChange());
    lastNameFocusNode.addListener(() => handleFocusChange());
    emailFocusNode.addListener(() => handleFocusChange());
    phoneNumberFocusNode.addListener(() => handleFocusChange());

    firstNameController.addListener(() => handleTextChange());
    lastNameController.addListener(() => handleTextChange());
    emailController.addListener(() => handleTextChange());
    phoneNumberController.addListener(() => handleTextChange());
  }

  void handleFocusChange() {
    setState(() {});
  }

  void handleTextChange() {
    setState(() {
      allFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.GreyWithDarkOpacity),
      borderRadius: BorderRadius.circular(10),
    );

    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 18,
                  right: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customArrowBackButton(),
                    const SizedBox(height: 50),
                    const Text(
                      "Tell us about \nyourself",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "We need some basic info to proceed",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SignUpTextfield(
                      maxLength: 12,
                      controller: firstNameController,
                      focusNode: firstNameFocusNode,
                      prefixIcon: Icons.person,
                      hintText: "Your First Name",
                      border: (firstNameController.text.isNotEmpty ||
                              firstNameFocusNode.hasFocus)
                          ? focusedBorder
                          : defaultBorder,
                      fillColor: firstNameController.text.isEmpty
                          ? MyColors.GreyWithOp
                          : Colors.transparent,
                      iconColor: firstNameController.text.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                    const SizedBox(height: 18),
                    SignUpTextfield(
                      maxLength: 12,
                      controller: lastNameController,
                      focusNode: lastNameFocusNode,
                      prefixIcon: Icons.person,
                      hintText: "Your Last Name",
                      border: (lastNameController.text.isNotEmpty ||
                              lastNameFocusNode.hasFocus)
                          ? focusedBorder
                          : defaultBorder,
                      fillColor: lastNameController.text.isEmpty
                          ? MyColors.GreyWithOp
                          : Colors.transparent,
                      iconColor: lastNameController.text.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: MyColors.GreyWithOp,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: (phoneNumberController.text.isNotEmpty ||
                                      phoneNumberFocusNode.hasFocus)
                                  ? MyColors.GreyWithDarkOpacity
                                  : Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/flag.png",
                                  height: 35,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.arrow_drop_down_circle_rounded,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: SignUpTextfield(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: phoneNumberController,
                            focusNode: phoneNumberFocusNode,
                            prefixIcon: Icons.phone,
                            hintText: "Your Phone Number",
                            border: (phoneNumberController.text.isNotEmpty ||
                                    phoneNumberFocusNode.hasFocus)
                                ? focusedBorder
                                : defaultBorder,
                            iconColor: phoneNumberController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SignUpTextfield(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      prefixIcon: Icons.email,
                      hintText: "Your Email Address",
                      border: (emailController.text.isNotEmpty ||
                              emailFocusNode.hasFocus)
                          ? focusedBorder
                          : defaultBorder,
                      fillColor: emailController.text.isEmpty
                          ? MyColors.GreyWithOp
                          : Colors.transparent,
                      iconColor: emailController.text.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomButton(
                onPressed:
                    allFieldsFilled ? () => _proceedToNext(context) : () {},
                text: "Proceed to next",
                color: allFieldsFilled ? MyColors.primary : MyColors.GreyWithOp,
                clrtext: allFieldsFilled
                    ? MyColors.white
                    : MyColors.GreyWithDarkOpacity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToNext(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    provider.signUp(
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      "customer",
      phoneNumberController.text,
      context,
    );
  }
}
