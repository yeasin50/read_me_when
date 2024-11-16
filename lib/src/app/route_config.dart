import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/presentation/home/home_page.dart';

class AppRoute {
  static String home = "/";

  static GoRouter router() {
    return GoRouter(
      routes: [
        GoRoute(
          path: home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        )
      ],
    );
  }
}
