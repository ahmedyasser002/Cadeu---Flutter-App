import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final ProductsModel productModel;

  const ProductItem({
    super.key,
    required this.productModel
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              productModel.image!,
              fit: BoxFit.cover,
              )),
        ),
        SizedBox(height: 16.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productModel.name!,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  '${productModel.currency} ${productModel.priceAfter!.toInt().toString()}',
                  style: AppTextStyle.jost500(AppColors.black, 18),
                ),
                SizedBox(width: 10.w),
                Text(
                  '${productModel.currency} ${productModel.price.toString()}',
                  style: AppTextStyle.oldPriceStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
