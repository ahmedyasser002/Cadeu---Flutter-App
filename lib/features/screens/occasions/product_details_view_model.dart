import 'package:demo_project/data/repos/occasions/product_details_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsViewModel {
  static final ProductDetailsRepository _productDetailsRepository =
      ProductDetailsRepository();
  static final productDetailsNotifier =
      ChangeNotifierProvider((ref) => ProductDetailsNotifier());

  static Future getProductDetails(
      {required WidgetRef ref, required int productID}) async {
    final response = await _productDetailsRepository.getProductDetails(productID: productID);
    ref.read(productDetailsNotifier).toggleLoading(false);
    if (response != 'error') {
      return response;
    }
  }

  static void resetState(WidgetRef ref) {
    ref.read(productDetailsNotifier).resetState();
  }
}

class ProductDetailsNotifier extends ChangeNotifier {
  bool isLoading = true;
  int currentPage = 0;

  void toggleLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void resetState() {
    isLoading = true;
    notifyListeners();
  }

  void updateCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  int getCurrentPage() => currentPage;
}
