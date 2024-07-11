import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_technique_flutter/providers/materials_providers.dart';
import '../themes/colors/silk_colors_light.dart';
import '../themes/fonts/silk_fonts.dart';
import '../widgets/silk_app_bar.dart';

class DetailPage extends ConsumerWidget {
  DetailPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final material = ref.watch(currentMaterialProvider);
    return Scaffold(
      appBar: SilkAppBarWidget(
          fillColor: SilkColorsLight.instance.materialOrder,
          scaffoldKey: _scaffoldKey,
          title: material!.name,
          isHomePage: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: MediaQuery.sizeOf(context).width - 24,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(material.imageUrl),
                        fit: BoxFit.contain,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description:",
                    style: SilkFonts(SilkColorsLight.instance).cabin16Bold(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(material.description),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Disponible:",
                    style: SilkFonts(SilkColorsLight.instance).cabin16Bold(),
                  ),
                  material.availability.name == "available"
                      ? Row(
                          children: [
                            const Text("Oui"),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            const Text("Non"),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            )
                          ],
                        )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Disponible pour:"  ,
                        style: SilkFonts(SilkColorsLight.instance).cabin16Bold(),
                      ),
                      Text("  ${material.availableTo.length}"  " unités",)
                    ],
                  ),
                  ...material.availableTo.map((availableTo) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Card(
                        shadowColor: Colors.black,
                        elevation: 2,

                        surfaceTintColor: Colors.white,
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 24,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(availableTo.name
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  availableTo.name
                                      .substring(1, availableTo.name.length)),
                            )),
                      ),
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
