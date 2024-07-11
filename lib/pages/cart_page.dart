import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/materials_providers.dart';
import '../themes/colors/silk_colors_light.dart';
import '../themes/fonts/silk_fonts.dart';
import '../themes/silk_theme_manager.dart';
import '../widgets/silk_app_bar.dart';
import '../widgets/silk_button.dart';

class CartPage extends ConsumerWidget {
  CartPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsInCart = ref.watch(materialsInCartProvider);
    bool containMaterials = (materialsInCart
        .where((element) => element.quantity != 0)
        .toList()
        .isNotEmpty);
    return Scaffold(
        appBar: SilkAppBarWidget(
            fillColor: SilkColorsLight.instance.materialOrder,
            scaffoldKey: _scaffoldKey,
            title: 'Votre panier',
            isHomePage: false),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SilkButton(
            color: containMaterials
                ? SilkColorsLight.instance.materialOrder
                : SilkColorsLight.instance.materialOrder.withOpacity(0.5),
            text: "Valider",
          ),
        ),
        body: !containMaterials
            ? Center(
                child: Text(
                  "Votre panier est vide !!!",
                  style: SilkFonts(SilkColorsLight.instance).cabin20Bold(),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...materialsInCart
                              .where((element) => element.quantity != 0)
                              .toList()
                              .map((materialInCart) => GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(
                                              currentMaterialProvider.notifier)
                                          .setMaterial(
                                              material: materialInCart
                                                  .medicalSupplyInCart);
                                      Navigator.pushNamed(
                                          context, "/detailPage");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Card(
                                          shadowColor: Colors.black,
                                          elevation: 5,

                                          surfaceTintColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Image.network(
                                                    materialInCart
                                                        .medicalSupplyInCart
                                                        .imageUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    materialInCart
                                                        .medicalSupplyInCart.name,

                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 56),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4),
                                                        border: const Border
                                                            .fromBorderSide(
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                        color:
                                                            SilkThemeManager.of(
                                                                    context)
                                                                .colors
                                                                .neutral_2,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          materialInCart.quantity
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    SilkButton.icon(
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                      fontColor: Colors.white,
                                                      isFromData: true,
                                                      iconFromData:
                                                          Icons.delete_outline,
                                                      onPressed: () {
                                                        ref
                                                            .read(
                                                                materialsInCartProvider
                                                                    .notifier)
                                                            .removeMaterials(
                                                                materialId:
                                                                    materialInCart
                                                                        .medicalSupplyInCart
                                                                        .id);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ))
                        ]))));
  }
}
