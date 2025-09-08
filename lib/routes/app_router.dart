import 'package:auto_route/auto_route.dart';
import 'package:task_manager/features/auth/presentation/pages/auth_page.dart';
import 'package:task_manager/features/task_management/presentation/pages/task_list_page.dart';
import 'package:task_manager/injection_container.dart';
import 'package:task_manager/features/auth/presentation/cubit/auth_cubit.dart';

part 'app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final user = sl<AuthCubit>().currentUser;
    if (user != null) {
      resolver.next(true);
    } else {
      router.replace(const AuthRoute());
    }
  }
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthGuard _guard = AuthGuard();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, path: '/auth'),
    AutoRoute(page: TaskListRoute.page, initial: true, guards: [_guard]),
  ];
}
