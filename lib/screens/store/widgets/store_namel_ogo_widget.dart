import 'package:flutter/material.dart';
import 'package:foodstorefront/models/business_model.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

class StoreNameLogo extends StatelessWidget {
  const StoreNameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessProvider>(
      builder: (context, businessProvider, child) {
        if (businessProvider.errorMessage != null) {
          return Center(
              child:
                  Text(businessProvider.errorMessage!)); // Show error message
        }

        if (businessProvider.businessModel == null) {
          return Center(
              child: Text(
                  'No data available')); // Show a message if no data is available
        }

        Datum business = businessProvider
            .businessModel!.data.first; // Assuming you want the first business

        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                business.logo ??
                    'https://t3.ftcdn.net/jpg/05/62/05/20/360_F_562052065_yk3KPuruq10oyfeu5jniLTS4I2ky3bYX.jpg', // Handle null logo
                height: 56,
                width: 55,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              business.name,
              style: TextStyle(
                color: MyColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }
}
