import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/provider/country_provider.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomPhoneTextField extends StatefulWidget {
  const CustomPhoneTextField({
    super.key,
    required this.phoneController,
    required this.phoneFocusNode,
    this.isReadOnly = false, // Add isReadOnly to control editing
  });

  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final bool isReadOnly; // Control whether the field is read-only

  @override
  _CustomPhoneTextFieldState createState() => _CustomPhoneTextFieldState();
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  @override
  Widget build(BuildContext context) {
    final countryCodeProvider = Provider.of<CountryCodeProvider>(context);

    return Row(
      children: [
        GestureDetector(
          onTap: widget.isReadOnly
              ? null
              : () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      countryCodeProvider.setCountryCode(
                          country.phoneCode, country.flagEmoji);
                    },
                    countryFilter: [
                      'SA', // Saudi Arabia
                      'PK', // Pakistan
                    ],
                  );
                },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColors.GreyWithOp,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: (widget.phoneController.text.isNotEmpty ||
                        widget.phoneFocusNode.hasFocus)
                    ? MyColors.GreyWithDarkOpacity
                    : MyColors.GreyWithDarkOpacity,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Text(
                    countryCodeProvider.countryFlag,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 3),
                  if (!widget
                      .isReadOnly) // Show the dropdown icon only if not read-only
                    Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      size: 14,
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 7),
        Expanded(
          child: PhoneTextfield(
            keyboardType: TextInputType.number,
            controller: widget.phoneController,
            focusNode: widget.phoneFocusNode,
            hintText: "Your Phone Number",
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors.GreyWithDarkOpacity, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabled: !widget
                .isReadOnly, // Make text field editable based on isReadOnly
          ),
        ),
      ],
    );
  }
}

class PhoneTextfield extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final InputBorder border;
  final Color? fillColor;
  final Color? iconColor;
  final int? maxLength;
  final TextInputType keyboardType;
  final bool enabled;

  const PhoneTextfield({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.border,
    this.fillColor,
    this.iconColor,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.enabled = true, // Default to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: MyColors.black,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: maxLength != null
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(maxLength),
            ]
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.GreyWithOp,
        hintText: hintText,
        hintStyle: TextStyle(color: MyColors.GreyWithDarkOpacity, fontSize: 13),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
      ),
      enabled: enabled,
    );
  }
}
