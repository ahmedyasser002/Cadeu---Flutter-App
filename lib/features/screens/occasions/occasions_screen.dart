import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/features/screens/occasions/occasions_view_model.dart';
import 'package:demo_project/features/widgets/occasion_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OccasionsScreen extends ConsumerStatefulWidget {
  OccasionsScreen({super.key});

  @override
  ConsumerState<OccasionsScreen> createState() => _OccasionsScreenState();
}

class _OccasionsScreenState extends ConsumerState<OccasionsScreen> {
  late ScrollController _scrollController;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OccasionsViewModel.resetState(ref);
      OccasionsViewModel.getOccasions(ref, '1');
    });

    _scrollController.addListener(() {
      // Check if the user has scrolled to the bottom of the list
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          // Check if not already loading and if there are more pages to load
          bool isLoading = ref.read(OccasionsViewModel.occasionsNotifier.select(
              (occasionsNotifier) => occasionsNotifier.getOccasionsLoading));
          bool hasMorePages = ref.read(OccasionsViewModel.occasionsNotifier
              .select((occasionsNotifier) => occasionsNotifier.hasMorePages));
          bool isFetchingMoreLoading = ref.read(
              OccasionsViewModel.occasionsNotifier.select((occasionsNotifier) =>
                  occasionsNotifier.fetchMorePagesLoading));
          if (!isLoading && hasMorePages && !isFetchingMoreLoading) {
            OccasionsViewModel.loadNextPage(ref);
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Occasions',
                    style: AppTextStyle.jost700(AppColors.black, 22),
                  ),
                  SvgPicture.asset(AppIcons.notificationIcon)
                ],
              ),
              SizedBox(
                height: 18.h,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    bool isLoading = ref.watch(OccasionsViewModel
                        .occasionsNotifier
                        .select((occasionsNotifier) =>
                            occasionsNotifier.getOccasionsLoading));

                    bool isError = ref.watch(OccasionsViewModel
                        .occasionsNotifier
                        .select((occasionsNotifier) =>
                            occasionsNotifier.errorFetching));

                    isLoadingMore = ref.watch(OccasionsViewModel
                        .occasionsNotifier
                        .select((occasionsNotifier) =>
                            occasionsNotifier.fetchMorePagesLoading));

                    final occasionItems = ref.watch(OccasionsViewModel
                        .occasionsNotifier
                        .select((occasionsNotifier) =>
                            occasionsNotifier.occasionsList));

                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (isError) {
                      return const Center(
                          child: Text('Error fetching occasions'));
                    }

                    if (occasionItems.isEmpty) {
                      return const Center(child: Text('Empty List'));
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return OccasionListItem(
                                occasionId: occasionItems[index].id,
                                occasionsModel: occasionItems[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12.h);
                            },
                            itemCount: occasionItems.length,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
