import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/data/models/occasions_model.dart';
import 'package:demo_project/features/screens/occasions/product_details_screen.dart';
import 'package:demo_project/features/screens/occasions/products_view_model.dart';
import 'package:demo_project/features/widgets/product_item.dart';
import 'package:demo_project/features/widgets/sort_filter.dart';
import 'package:demo_project/features/widgets/top_offer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  final OccasionsModel occasionModel;
  const ProductsScreen({super.key, required this.occasionModel});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  late ScrollController _scrollController;
  bool isLoadingMore = false;

  String formatText(String title) {
    List<String> splittedText = title.split(' ');
    if (splittedText.length > 3) {
      splittedText.insert(3, '\n');
    }
    return splittedText.join(' ').replaceAll('\n ', '\n');
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Reset state when a new occasion is opened

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProductsViewModel.getProducts(
          ref: ref, occasionId: [widget.occasionModel.id.toString()], pageNo: '1');
    ProductsViewModel.resetStateForNewOccasion(ref);
    });

    _scrollController.addListener(() {
      // Check if the user has scrolled to the bottom of the list
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          // Check if not already loading and if there are more pages to load
          bool isLoading = ref.read(ProductsViewModel.productsNotifier
              .select((productNotifier) => productNotifier.productsLoading));
          bool hasMorePages = ref.read(ProductsViewModel.productsNotifier
              .select((productsNotifier) => productsNotifier.hasMorePages));

          bool isFetchingMoreLoading = ref.read(ProductsViewModel.productsNotifier.select((productNotifier)=>productNotifier.fetchMorePagesLoading));

          if (!isLoading && hasMorePages && !isFetchingMoreLoading) {
            ProductsViewModel.loadNextPage(ref, [widget.occasionModel.id.toString()]);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(AppIcons.backIcon)),
                      Text(
                        '${widget.occasionModel.name}',
                        style: AppTextStyle.jost500(AppColors.black, 14),
                      ),
                      SvgPicture.asset(AppIcons.searchIcon),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const TopOfferItem(),
                  ),
                  Expanded(child: Consumer(
                    builder: (context, ref, child) {
                      bool isLoading = ref.watch(ProductsViewModel
                          .productsNotifier
                          .select((productsNotifier) =>
                              productsNotifier.productsLoading));

                      bool isError = ref.watch(ProductsViewModel
                          .productsNotifier
                          .select((productsNotifier) =>
                              productsNotifier.errorFetching));

                      isLoadingMore = ref.watch(ProductsViewModel
                          .productsNotifier
                          .select((productNotifier) =>
                              productNotifier.fetchMorePagesLoading));

                      final productItems = ref.watch(ProductsViewModel
                          .productsNotifier
                          .select((productsNotifier) =>
                              productsNotifier.productsList));

                      if (isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (isError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                      else if (productItems.isEmpty) {
                        return const Center(
                          child: Text('Empty List'),
                        );
                      }
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 6.w, // Space between columns
                                mainAxisSpacing: 16.h, // Space between rows
                                childAspectRatio: 0.69, // Aspect ratio of each item
                              ),
                              itemCount: productItems.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsScreen(productID: productItems[index].id!,)));
                                    },
                                    child: ProductItem(
                                      productModel: productItems[index],
                                    ));
                              },
                            ),
                          ),
                          if (isLoadingMore)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const CircularProgressIndicator(),
                            ),
                        ],
                      );
                    },
                  )),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: const SortFilter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
