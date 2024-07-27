import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class SpecialInstructionSection extends StatefulWidget {
  const SpecialInstructionSection({
    super.key,
  });

  @override
  _SpecialInstructionSectionState createState() =>
      _SpecialInstructionSectionState();
}

class _SpecialInstructionSectionState extends State<SpecialInstructionSection> {
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 500;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Instructions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        Text(
          "Please let us know if you are allergic to anything or if we need to avoid anything",
          style: TextStyle(
              fontSize: 13,
              color: MyColors.greyText,
              overflow: TextOverflow.clip),
        ),
        SizedBox(height: 20),
        Container(
          height: 90,
          child: TextFormField(
            controller: _controller,
            maxLines: 3, // Allows the field to expand up to 5 lines
            textAlignVertical: TextAlignVertical.top, // Aligns text to the top
            decoration: InputDecoration(
              labelText: "e.g. no mayo",
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: MyColors.greyText, fontSize: 16),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: MyColors.grey2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: MyColors.lightGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: MyColors.black,
                ),
              ),
            ),
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_controller.text.length}/$maxLength',
              style: TextStyle(fontSize: 12, color: MyColors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
