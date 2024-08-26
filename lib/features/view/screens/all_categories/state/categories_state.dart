// ignore_for_file: file_names

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/model/category_list_model.dart';

class CategoryListSuccessState extends SuccessState {
  final CategoryListModel? categoryListModle;

  const CategoryListSuccessState(this.categoryListModle);
}
