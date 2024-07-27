import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomRadio extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadio({
    Key? key,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: isSelected ? MyColors.primary : MyColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: MyColors.primary, width: 2),
        ),
        child: isSelected
            ? Icon(Icons.circle, size: 10, color: MyColors.white)
            : null,
      ),
    );
  }
}
