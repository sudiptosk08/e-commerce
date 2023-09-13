

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/model/user_model.dart';

class LoginSuccessState extends SuccessState {
  final UserModel? userModel;

  const LoginSuccessState(this.userModel);
}
