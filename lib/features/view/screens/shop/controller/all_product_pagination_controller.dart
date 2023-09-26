import 'package:ecommerce_app/features/view/screens/product_details/state/pagination_scroll_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allProductScrollProvider =
    StateNotifierProvider<AllProductScrollController, ScrollState>(
        (ref) => AllProductScrollController(ref: ref));

class AllProductScrollController extends StateNotifier<ScrollState> {
  final Ref? ref;

  AllProductScrollController({this.ref}) : super(const ScrollInitialState());

  ScrollController _scrollController = ScrollController();

  get controller {
    _scrollController.addListener(scrollListener);
    return _scrollController;
  }

  set setController(ScrollController scrollController) {
    _scrollController = scrollController;
  }

  get scrollNotifierState => state;

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref!.read(productListProvider.notifier).fetchMoreProductList();
      state = const ScrollReachedBottomState();
    }
  }

  resetState() {
    state = const ScrollInitialState();
  }
}
