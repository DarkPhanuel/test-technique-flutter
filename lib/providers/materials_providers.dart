import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_technique_flutter/data/medical_supplies_dto.dart';

import '../domain/medical_supplies_repository.dart';


final currentMaterialProvider =
    StateNotifierProvider<MaterialNotifier, MaterialMedicalSupplyDto?>(
        (ref) => MaterialNotifier());

class MaterialNotifier extends StateNotifier<MaterialMedicalSupplyDto?> {
  MaterialNotifier() : super(null);
  void setMaterial({required MaterialMedicalSupplyDto material}) {
    state = material;
  }
}

final materialsInCartProvider = StateNotifierProvider<MaterialsCartNotifier,
    List<MaterialMedicalSupplyInCart>>((ref) => MaterialsCartNotifier());

class MaterialsCartNotifier
    extends StateNotifier<List<MaterialMedicalSupplyInCart>> {
  MaterialsCartNotifier() : super([]);

  MedicalSuppliesRepository materialsRepo = MedicalSuppliesRepository();

  Future<MaterialMedicalSuppliesDto?> getAllMaterials() async {
    MaterialMedicalSuppliesDto? materials;
    try {
      materials = await materialsRepo.getMedicalSupplies();
    } catch (error) {
      debugPrint('Une erreur s\'est produite : $error');
      throw Exception(
          'Erreur lors de la récupération des fournitures médicales');
    }
    return materials;
  }



  Future<void> initiateCart() async {
    MaterialMedicalSuppliesDto? materials = await getAllMaterials();
    if (materials != null) {
      List<MaterialMedicalSupplyInCart> materialsSuppliesInCart = [];
      for (MaterialMedicalSupplyDto material in materials.medicalSupplies) {
        MaterialMedicalSupplyInCart materialInCart =
            MaterialMedicalSupplyInCart(
                medicalSupplyInCart: material, quantity: 0);
        materialsSuppliesInCart.add(materialInCart);
      }
      state = materialsSuppliesInCart;
    }
  }

  void removeMaterials({required int materialId}) {
    List<MaterialMedicalSupplyInCart> materialMedicalSuppliesInCart = [];

    for (MaterialMedicalSupplyInCart materialMedicalSupplyInCart in state) {
      materialMedicalSuppliesInCart.add(materialMedicalSupplyInCart);
    }
    for (MaterialMedicalSupplyInCart materialMedicalSupplyInCart
        in materialMedicalSuppliesInCart) {
      if (materialMedicalSupplyInCart.medicalSupplyInCart.id == materialId) {
        materialMedicalSupplyInCart.quantity = 0;
      }
    }

    state = materialMedicalSuppliesInCart;
  }
}
