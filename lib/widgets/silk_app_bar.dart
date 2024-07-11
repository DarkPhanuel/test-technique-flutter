import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_technique_flutter/themes/silk_theme_manager.dart';
import '../providers/materials_providers.dart';

class SilkAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const SilkAppBarWidget({
    required this.fillColor,
    required this.scaffoldKey,
    required this.title,
    this.isHomePage = true,
    super.key,
  });

  final Color fillColor;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final bool isHomePage;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsInCart = ref.watch(materialsInCartProvider);
    return Container(
      padding: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: fillColor,
        boxShadow: [
          SilkThemeManager.of(context).shadows.topBar,
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 40,
                child: !isHomePage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white))
                    : null,
              ),
              Text(
                title,
                style: SilkThemeManager.of(context).fonts.cabin20Bold(
                      color: SilkThemeManager.of(context).colors.neutral_1,
                    ),
              ),
              isHomePage ?
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: SizedBox(
                      width: 40,
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          if (materialsInCart
                              .where((element) => element.quantity != 0)
                              .toList()
                              .isNotEmpty)
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            )
                        ],
                      )),
                ):const SizedBox(width: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
