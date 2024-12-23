import 'package:auto_route/auto_route.dart';
import 'package:products/features/login/presentation/pages/login_page.dart';
import 'package:products/features/home/presentation/pages/home_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
  ];
}