import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/profile/model/profile_model.dart';

class ProfileSuccessState extends SuccessState {
  final ProfileModel? profileModel;

  const ProfileSuccessState(
    this.profileModel,
  );
}
