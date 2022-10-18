import '../models/userModel.dart';

abstract class AuthRepositoryInterface {
  Future<UserModel?> logIn(String email, password);
  Future<UserModel?> register(
      String name, email, password, passwordConfirmation);
  Future<bool> logOut();
}
