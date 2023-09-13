import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/model/brand_list_model.dart';

class BrandSuccessState extends SuccessState {
  final BrandListModel? brandListModel;

  const BrandSuccessState(this.brandListModel);
}
