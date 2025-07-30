part of '../../core.dart';

class AppControllerX extends GetxController {
  //============================================================================
  // Variables

  late Rx<UserX> user;

  RxBool isLogin = LocalDataX.token.isNotEmpty.obs;

  //============================================================================
  // Functions

  init() async {
    /// Profile
    if (isLogin.value) {
      user = (await DatabaseX.getProfile()).obs;
    }
    update();
  }

  logOut() async {
    try {
      isLogin.value = false;
      LocalDataX.remove(LocalKeyX.token);
      LocalDataX.put(LocalKeyX.route, RouteNameX.login);
      if (Get.currentRoute != RouteNameX.login) {
        await Future.wait([
          DatabaseX.logout(),
          Future.microtask(() => Get.offAllNamed(RouteNameX.login)),
        ]);
      } else {
        await DatabaseX.logout();
      }
    } catch (_) {}
  }
}
