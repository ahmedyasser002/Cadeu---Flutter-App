import 'package:demo_project/data/models/occasions_model.dart';
import 'package:demo_project/data/repos/occasions/occasions_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OccasionsViewModel {
  static final OccasionsRepository _occasionsRepository = OccasionsRepository();
  static final occasionsNotifier =
      ChangeNotifierProvider((ref) => OccasionsNotifier());

  static Future getOccasions(WidgetRef ref, String pageNo) async {
    if (pageNo!='1') {
      ref.read(occasionsNotifier).toggleFetchMoreLoading(true);
    }
    final response = await _occasionsRepository.getOcassions(pageNo);
    pageNo == '1'
        ? ref.read(occasionsNotifier).toggleOccasionsLoading(false)
        : ref.read(occasionsNotifier).toggleFetchMoreLoading(false);
    if (response != null) {
      ref.read(occasionsNotifier).setOccasionsList(response);
      ref.read(occasionsNotifier).toggleErrorFetching(false);
    } else {
      ref.read(occasionsNotifier).toggleErrorFetching(true);
    }
  }

  static Future loadNextPage(WidgetRef ref) async {
    int currentPage = ref.read(occasionsNotifier).currentPage;
    ref.read(occasionsNotifier).currentPage = currentPage + 1;
    await getOccasions(ref, ref.read(occasionsNotifier).currentPage.toString());
    
  }
   static void resetState(WidgetRef ref) {
    ref.read(occasionsNotifier).resetState();
  }
}

class OccasionsNotifier extends ChangeNotifier {
  bool getOccasionsLoading = true;
  bool errorFetching = false;
  List<OccasionsModel> occasionsList = [];
  int currentPage = 1;
  bool hasMorePages = true;
  bool fetchMorePagesLoading = false;


  void toggleOccasionsLoading(bool val) {
    getOccasionsLoading = val;
    notifyListeners();
  }

  void toggleFetchMoreLoading(bool val) {
    fetchMorePagesLoading = val;
    notifyListeners();
  }

  void toggleErrorFetching(bool val) {
    errorFetching = val;
    notifyListeners();
  }

  void setOccasionsList(List<OccasionsModel> response) {
    if (response.isEmpty) {
      hasMorePages = false;
    } else {
      occasionsList.addAll(response);
    }
    notifyListeners();
  }
  void resetState() {
    getOccasionsLoading = true;
    notifyListeners();
  }
}
