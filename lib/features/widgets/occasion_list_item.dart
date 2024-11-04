import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/data/models/occasions_model.dart';
import 'package:demo_project/features/screens/occasions/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OccasionListItem extends StatelessWidget {
  final OccasionsModel occasionsModel;
  final occasionId;
  const OccasionListItem({super.key, required this.occasionsModel , required this.occasionId});

  String formatText(String title) {
    List<String> splittedText = title.split(' ');
    if (splittedText.length > 3) {
      splittedText.insert(3, '\n');
    }
    return splittedText.join(' ').replaceAll('\n ', '\n');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 230.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.01),
              Colors.black.withOpacity(0.8)
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            image: DecorationImage(
                image: NetworkImage(
                  occasionsModel.banner ?? '',
                ),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.h, left: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.lovelyIcon),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      occasionsModel.name ?? '',
                      style: AppTextStyle.jost22_400(Colors.white),
                    ),
                  ],
                ),
                Text(
                  occasionsModel.description?.replaceFirst(', ', ',\n') ??
                      ''.replaceAll(', ', ',\n'),
                  style: AppTextStyle.jost14_400(Colors.white),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsScreen(
                        occasionModel: occasionsModel,
                      )));
            },
            child: Container(
              width: 105.w,
              height: 30.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  color: AppColors.orange),
              child: Center(
                  child: Text(
                'View',
                style: AppTextStyle.jost500(Colors.white, 12),
              )),
            ),
          ),
        )
      ],
    );
  }
}
