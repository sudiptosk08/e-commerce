import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/model/category_list_model.dart';

class CategorySuccessState extends SuccessState {
  final CategoryListModel? categoryModel;

  const CategorySuccessState(this.categoryModel);
}
