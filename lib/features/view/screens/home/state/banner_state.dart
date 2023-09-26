import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/model/banner_list_model.dart';

class BannerSuccessState extends SuccessState {
  final BannerListModel? bannerListModel;

  const BannerSuccessState(this.bannerListModel);
}
