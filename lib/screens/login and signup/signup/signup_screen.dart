import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_phone_textfield.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'widgets/textfield_for_signup.dart';

class SignUpScreen extends StatefulWidget {
  final String phoneNumber;

  const SignUpScreen({super.key, required this.phoneNumber});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  bool allFieldsFilled = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _addListeners();
  }

  void _initializeControllers() {
    // Initialize phone number controller with the passed phone number
    phoneNumberController.text = widget.phoneNumber;

    // Initialize other controllers if needed
  }

  void _addListeners() {
    final nodes = [
      firstNameFocusNode,
      lastNameFocusNode,
      emailFocusNode,
      phoneNumberFocusNode
    ];
    final controllers = [
      firstNameController,
      lastNameController,
      emailController,
      phoneNumberController
    ];

    for (var node in nodes) {
      node.addListener(_updateState);
    }

    for (var controller in controllers) {
      controller.addListener(_updateState);
    }
  }

  void _updateState() {
    setState(() {
      allFieldsFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty;
    });

    // Print statements for debugging
    print("First Name: ${firstNameController.text}");
    print("Last Name: ${lastNameController.text}");
    print("Email: ${emailController.text}");
    print("Phone Number: ${phoneNumberController.text}");
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
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 50, left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customArrowBackButton(),
                    const SizedBox(height: 50),
                    _buildHeaderText(),
                    const SizedBox(height: 40),
                    _buildTextField(
                      controller: firstNameController,
                      focusNode: firstNameFocusNode,
                      hintText: "Your First Name",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 18),
                    _buildTextField(
                      controller: lastNameController,
                      focusNode: lastNameFocusNode,
                      hintText: "Your Last Name",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 18),
                    CustomPhoneTextField(
                      phoneController: phoneNumberController,
                      phoneFocusNode: phoneNumberFocusNode,
                      isReadOnly: true, // Make the phone field read-only
                    ),
                    const SizedBox(height: 18),
                    _buildTextField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      hintText: "Your Email Address",
                      icon: Icons.email,
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

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Tell us about \nyourself",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "We need some basic info to proceed",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData icon,
  }) {
    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.GreyWithDarkOpacity),
      borderRadius: BorderRadius.circular(10),
    );

    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    );

    return SignUpTextfield(
      controller: controller,
      focusNode: focusNode,
      prefixIcon: icon,
      hintText: hintText,
      border: (controller.text.isNotEmpty || focusNode.hasFocus)
          ? focusedBorder
          : defaultBorder,
      fillColor:
          controller.text.isEmpty ? MyColors.GreyWithOp : Colors.transparent,
      iconColor: controller.text.isEmpty ? Colors.grey : Colors.black,
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
