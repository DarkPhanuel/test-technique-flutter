import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_technique_flutter/providers/materials_providers.dart';
import '../themes/colors/silk_colors_light.dart';
import '../themes/fonts/silk_fonts.dart';
import '../widgets/silk_app_bar.dart';
import '../widgets/silk_numeric_up_down.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(materialsInCartProvider.notifier).initiateCart();
    });
  }

  //int xValue = 0;

  @override
  Widget build(BuildContext context) {
    final materialsInCart = ref.watch(materialsInCartProvider);
    return Scaffold(
      appBar: SilkAppBarWidget(
        fillColor: SilkColorsLight.instance.materialOrder,
        scaffoldKey: _scaffoldKey,
        title: 'Liste des matériels',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tous les produits",
                style: SilkFonts(SilkColorsLight.instance).cabin20Bold(),
              ),
              ...materialsInCart.map((materialInCart) {
                return GestureDetector(
                  onTap: () async {
                    ref.read(currentMaterialProvider.notifier).setMaterial(
                        material: materialInCart.medicalSupplyInCart);
                    Navigator.pushNamed(context, "/detailPage");
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  materialInCart.medicalSupplyInCart.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  materialInCart.medicalSupplyInCart.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SilkNumericUpDown<int>(
                            enabled: materialInCart
                                    .medicalSupplyInCart.availability.name ==
                                "available",
                            minValue: 0,
                            value: materialInCart.quantity,
                            step: 1,
                            activeColor: Colors.black,
                            onChanged: (int value) {
                              setState(() {
                                materialInCart.quantity = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
/*
() {
              switch (myColor) {
                case MyColors.red:
                  return 'The state is RED';
                case MyColors.blue:
                  return 'The state is blue';
                default:
                  return 'THERES NO STATE!';
              }
 */
