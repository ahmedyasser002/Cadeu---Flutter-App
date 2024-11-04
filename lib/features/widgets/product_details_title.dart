import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/features/screens/occasions/product_details_view_model.dart';
import 'package:demo_project/features/widgets/side_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsTitle extends ConsumerStatefulWidget {
  final List<String> imageList;

  const ProductDetailsTitle({super.key, required this.imageList});

  @override
  ConsumerState createState() => _ProductDetailsTitleState();
}

class _ProductDetailsTitleState extends ConsumerState<ProductDetailsTitle> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 294.h,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: widget.imageList.length,
                      onPageChanged: (int page) {
                        ref
                            .read(
                                ProductDetailsViewModel.productDetailsNotifier)
                            .updateCurrentPage(page);
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.imageList[index],
                          fit: BoxFit.fill,
                          width: double.infinity,
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 24.h, 18.w, 24.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SideIcons(iconName: AppIcons.backIcon)),
                      const SideIcons(iconName: AppIcons.shareIcon),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Consumer(
            builder: (context, ref, child) {
              int currentPage = ref.watch(ProductDetailsViewModel
                  .productDetailsNotifier
                  .select((notifier) => notifier.currentPage));
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 14.w,
                    height: 4.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: currentPage == index ? AppColors.orange : AppColors.nonActiveCarousel,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
