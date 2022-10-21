import 'package:get/get.dart';
import 'package:share_app/app/modules/home/bindings/home_binding.dart';
import 'package:share_app/app/modules/home/views/detail_view.dart';
import 'package:share_app/app/modules/home/views/layout.dart';
import 'package:share_app/app/modules/login/bindings/login_binding.dart';
import 'package:share_app/app/modules/login/views/login_view.dart';
import 'package:share_app/app/modules/personal/controllers/contribute_controller.dart';
import 'package:share_app/app/modules/personal/views/bonus_view.dart';
import 'package:share_app/app/modules/personal/views/contributors_view.dart';
import 'package:share_app/app/modules/personal/views/edit_view.dart';
import 'package:share_app/app/modules/personal/views/exchange_view.dart';
import 'package:share_app/app/modules/personal/views/my_contributors_view.dart';
import 'package:share_app/app/modules/personal/views/personal_view.dart';
import 'package:share_app/app/modules/personal/views/setting_view.dart';
import 'package:share_app/app/modules/search/views/search_view.dart';
import 'package:share_app/app/routes/route_auth_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const Layout(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
    ),
    GetPage(
      name: '/detail',
      page: () => DetailView(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: _Paths.PERSONAL,
      page: () => const PersonalView(),
      children: [
        GetPage(
            name: '/my',
            page: () => const MyContributorsView(),
            middlewares: [RouteAuthMiddleware()],
            binding: BindingsBuilder(() {
              Get.lazyPut(() => ContributeController());
            })),
        GetPage(name: '/contribute', page: () => const ContributorsView()),
        GetPage(
          name: '/edit',
          page: () => const EditView(),
          middlewares: [RouteAuthMiddleware()],
        ),
        GetPage(
          name: '/setting',
          page: () => const SettingView(),
          middlewares: [RouteAuthMiddleware()],
        ),
        GetPage(name: '/bonus', page: () => const BonusView()),
        GetPage(name: '/exchange', page: () => const ExchangeView()),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
