import 'package:demo_project/data/models/products_model.dart';
import 'package:demo_project/data/repos/occasions/products_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsViewModel {
  static final ProductsRepository _productsRepository = ProductsRepository();
  static final productsNotifier =
      ChangeNotifierProvider((ref) => ProductsNotifier());

  static Future getProducts({
    required WidgetRef ref,
    required List occasionId,
    required String pageNo,
  }) async {

    if (pageNo != '1') {
      ref.read(productsNotifier).toggleFetchMoreLoading(true);
    }

    final response = await _productsRepository.getProducts(
      pageNo: pageNo,
      occasionId: occasionId,
    );

    if (pageNo == '1') {
      ref.read(productsNotifier).toggleProductsLoading(false);
    } else {
      ref.read(productsNotifier).toggleFetchMoreLoading(false);
    }

    if (response != 'error') {
      ref.read(productsNotifier).setProductsList(
          response, ref.read(productsNotifier).currentPage.toString());
      ref.read(productsNotifier).toggleErrorFetching(false);
    } else {
      ref.read(productsNotifier).toggleErrorFetching(true);
    }
  }

  static Future loadNextPage(WidgetRef ref, List occasionId) async {
    int currentPage = ref.read(productsNotifier).currentPage;
    ref.read(productsNotifier).currentPage = currentPage + 1;
    await getProducts(
      ref: ref,
      pageNo: ref.read(productsNotifier).currentPage.toString(),
      occasionId: occasionId,
    );
   
  }

  static void resetStateForNewOccasion(WidgetRef ref) {
    ref.read(productsNotifier).resetState();
  }
}

class ProductsNotifier extends ChangeNotifier {
  bool productsLoading = true;
  int currentPage = 1;
  bool hasMorePages = true;
  bool fetchMorePagesLoading = false;
  bool errorFetching = false;
  List<ProductsModel> productsList = [];

  void toggleProductsLoading(bool val) {
    productsLoading = val;
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

  void setProductsList(List<ProductsModel> response, String pageNo) {
    if (response.isEmpty) {
      hasMorePages = false;
    } else {
      if (pageNo == '1') {
        productsList = response;
      } else {
        productsList.addAll(response);
      }
      notifyListeners();
    }
  }

  void resetState() {
    productsLoading = true;
    currentPage = 1;
    hasMorePages = true;
    fetchMorePagesLoading = false;
    errorFetching = false;
    productsList = [];
    notifyListeners();
  }
}
