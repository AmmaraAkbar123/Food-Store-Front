import 'package:flutter/material.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_textfield.dart';
import 'package:foodstorefront/utils/colors.dart';

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

  bool showAdditionalFields = false;
  bool isFocused = false;
  bool isPhoneNumberFocused = false;
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
    setState(() {
      isFocused = firstNameFocusNode.hasFocus ||
          lastNameFocusNode.hasFocus ||
          emailFocusNode.hasFocus ||
          phoneNumberFocusNode.hasFocus;
      isPhoneNumberFocused = phoneNumberFocusNode.hasFocus;
      if (firstNameFocusNode.hasFocus) {
        showAdditionalFields = true;
      }
    });
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
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    );

    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const customArrowBackButton(),
                  const SizedBox(height: 40),
                  const Text(
                    "Tell us about \nyourself",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "We need some basic info to proceed",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    controller: firstNameController,
                    focusNode: firstNameFocusNode,
                    prefixIcon: Icons.person,
                    hintText: "Your First Name",
                    border: isFocused ? focusedBorder : defaultBorder,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: lastNameController,
                    focusNode: lastNameFocusNode,
                    prefixIcon: Icons.person,
                    hintText: "Your Last Name",
                    border: isFocused ? focusedBorder : defaultBorder,
                  ),
                  if (showAdditionalFields) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: MyColors.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                            border: isPhoneNumberFocused
                                ? Border.all(color: Colors.black)
                                : null,
                          ),
                          height: 46,
                          width: 65,
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
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: phoneNumberController,
                            focusNode: phoneNumberFocusNode,
                            prefixIcon: Icons.phone,
                            hintText: "Your Phone Number",
                            border: isPhoneNumberFocused
                                ? focusedBorder
                                : defaultBorder,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      prefixIcon: Icons.email,
                      hintText: "Your Email Address",
                      border: isFocused ? focusedBorder : defaultBorder,
                    ),
                  ],
                  showAdditionalFields
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 4.5,
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 2.5,
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onPressed: allFieldsFilled
                          ? () => _proceedToNext(context)
                          : () {},
                      text: "Proceed to next",
                      color: allFieldsFilled
                          ? MyColors.primary
                          : MyColors.lightGrey,
                    ),
                  ),
                ],
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
      "customer", // replace with actual user type if applicable
      phoneNumberController.text,
      context,
    );
  }
}
