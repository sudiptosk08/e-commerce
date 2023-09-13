

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/model/user_model.dart';

class SignupSuccessState extends SuccessState {
  final UserModel? userModel;

  SignupSuccessState(this.userModel);
}
