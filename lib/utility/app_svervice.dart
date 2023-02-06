import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';

class AppSvervice {
  Future<String?> findDocIdSiteCode({required String content}) async {
    String? docIdSiteCode;

    var result = await FirebaseFirestore.instance
        .collection('sitecode')
        .where('name', isEqualTo: content)
        .get();

    if (result.docs.isNotEmpty) {
      for (var element in result.docs) {
        docIdSiteCode = element.id;
      }
    }

    return docIdSiteCode;
  }

  Future<void> readAssociate(
      {required String associateID, required BuildContext context}) async {
    AppController appController = Get.put(AppController());

    if (appController.assosicateModels.isEmpty) {
      appController.assosicateModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('associate')
        .doc(associateID)
        .get()
        .then((value) async {
      print('value ===> ${value.data()}');

      if (value.data() == null) {
        AppDialog(context: context).normalDialog(
            title: 'Associate ID fale', subTitle: 'Plase try Again');
      } else {
        AsscociateModel asscociateModel =
            AsscociateModel.fromMap(value.data()!);

        if (asscociateModel.docIdSiteCode.trim() ==
            appController.chooseDocIdSiteCodes.last.trim()) {
          await FirebaseFirestore.instance
              .collection('associate')
              .doc(associateID)
              .collection('profile')
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              appController.assosicateModels.add(asscociateModel);
            } else {
              AppDialog(context: context).normalDialog(
                  title: '$associateID นี้ create Account แล้ว',
                  subTitle: 'เปลี่ยน Associate ID ใหม่');
            }
          });
        } else {
          AppDialog(context: context).normalDialog(
              title: 'AssosiciateID ไม่มี ',
              subTitle:
                  'Site ${appController.chooseSiteCode.last} ไม่มี ID นี้');
        }
      }
    });
  }
}