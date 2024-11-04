import 'dart:developer';
import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/data/models/product_details_model.dart';
import 'package:demo_project/features/screens/occasions/product_details_view_model.dart';
import 'package:demo_project/features/widgets/custom_btn.dart';
import 'package:demo_project/features/widgets/product_details_title.dart';
import 'package:demo_project/features/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final int productID;
  const ProductDetailsScreen({super.key, required this.productID});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetailsScreen> {
  ProductDetailsModel? productDetails;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ProductDetailsViewModel.resetState(ref);
      productDetails = await ProductDetailsViewModel.getProductDetails(
          ref: ref, productID: widget.productID);
      log('......................................\n ${productDetails!.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ref.watch(ProductDetailsViewModel.productDetailsNotifier
                .select((notifier) => notifier.isLoading))
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetailsTitle(
                        imageList: productDetails?.images! ?? [],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16.h, bottom: 12.h, left: 18.w, right: 18.w),
                        child: Row(
                          children: [
                            Text(
                              'More from ',
                              style: AppTextStyle.jost12_400(AppColors.gray),
                            ),
                            Text(
                              productDetails?.storeName ?? '',
                              style: AppTextStyle.jost12_400(
                                  AppColors.activeBtnColor,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18.w),
                        child: Text(
                          productDetails?.name ?? '',
                          style: AppTextStyle.jost500(AppColors.black, 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Row(
                          children: [
                            StarRating(rating: (productDetails?.avgRate!.toInt()) ?? 0 ),
                            SizedBox(width: 8.w,),
                            Text(
                              productDetails?.avgRate.toString() ?? '',
                              style: AppTextStyle.jost700(AppColors.black, 12),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '( ',
                                    style: AppTextStyle.jost400(
                                        AppColors.ratingsColor, 8,
                                        decoration: TextDecoration.none),
                                  ),
                                  TextSpan(
                                    text:
                                        '${productDetails?.reviewsCount.toString() ?? ''} ratings',
                                    style: AppTextStyle.jost400(
                                        AppColors.ratingsColor, 8,
                                        decoration: TextDecoration.underline),
                                  ),
                                  TextSpan(
                                    text: ' )',
                                    style: AppTextStyle.jost400(
                                        AppColors.ratingsColor, 8,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 18.w, top: 12.h, bottom: 12.h),
                        child: Row(
                          children: [
                            Text(
                              '${productDetails?.currency ?? ''} ${productDetails?.priceAfterDiscount!.toInt().toString() ?? ''}',
                              style: AppTextStyle.jost500(AppColors.black, 20),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              '${productDetails?.currency ?? ''} ${productDetails?.price!.toInt().toString() ?? ''}',
                              style: AppTextStyle.oldPriceStyle,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                        ),
                        child: const Divider(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 18.w, top: 16.h, bottom: 8.h),
                        child: Text(
                          'Description',
                          style: AppTextStyle.jost500(AppColors.black, 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Text(
                          productDetails?.description ?? '',
                          style: AppTextStyle.jost14_400(
                              AppColors.descriptonTextColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 8.h),
                        child: const Divider(),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1.sp, color: AppColors.black)),
                            child: Text(
                              '${productDetails?.currency ?? ''} ${productDetails?.priceAfterDiscount!.toInt().toString() ?? ''}',
                              style: AppTextStyle.jost700(AppColors.black, 16),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            child: CustomBtn(
                                btnText: 'Add To Cart',
                                btnColor: AppColors.activeBtnColor,
                                onTap: () {}),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
