import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sp_pontos/core/components/text_app.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            enableFeedback: false,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamed('/home');
                  break;
                case 1:
                  Navigator.of(context).pushNamed('/explorer');
                  break;
                case 2:
                  // Ação do botão central
                  break;
                case 3:
                  Navigator.of(context).pushNamed('/cupons');
                  break;
                case 4:
                  Navigator.of(context).pushNamed('/perfil');
                  break;
              }
            },
            items: [
              buildBottomNavItem(
                icon: Icons.home_outlined,
                label: 'Início',
                context: context,
                currentRoute: currentRoute,
                routeName: '/home',
                padding: const EdgeInsets.only(left: 5),
              ),
              buildBottomNavItem(
                icon: Icons.search,
                label: 'Explorar',
                context: context,
                currentRoute: currentRoute,
                routeName: '/explorer',
              ),
              buildBottomNavItem(
                  label: '', context: context, currentRoute: '', routeName: ''),
              buildBottomNavItem(
                icon: Icons.local_offer_outlined,
                label: 'Cupons',
                context: context,
                currentRoute: currentRoute,
                routeName: '/cupons',
              ),
              buildBottomNavItem(
                icon: Icons.person_outline,
                label: 'Perfil',
                context: context,
                currentRoute: currentRoute,
                routeName: '/perfil',
                padding: const EdgeInsets.only(right: 5),
              ),
            ],
          ),
        ),
        Positioned.fill(
          bottom: 12,
          top: 12,
          child: Align(
            alignment: Alignment.center,
            child: FloatingActionButton(
              enableFeedback: false,
              elevation: 0,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.of(context).pushNamed('/upload');
              },
              backgroundColor: AppColors.blue,
              child: Icon(
                Icons.camera_alt,
                size: 24,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavItem({
    IconData? icon,
    required String label,
    required BuildContext context,
    required String? currentRoute,
    required String routeName,
    EdgeInsets? padding,
  }) {
    bool isActive = currentRoute == routeName;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.home,
              size: 24,
              color: isActive ? AppColors.blue : AppColors.gray,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.blue : AppColors.gray,
                fontWeight: FontWeight.w800,
              ).copyWith(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
