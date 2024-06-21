import 'package:adhkaar/model/adhkaar_model.dart';
import 'package:adhkaar/helpers/alerts.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class Service {
  static saveAdhkaar(BuildContext context,
      {required Box<AdhkaarModel> box, required AdhkaarModel adhkaarModel}) {
    if (adhkaarModel.title.isEmpty || adhkaarModel.title.trim().isEmpty) {
      Alerts.openStatusDialog(context,
          isSuccess: false,
          description: "Adhkar must have a descriptive title!");
    } else if (box.values
        .toList()
        .where((e) => e.title == adhkaarModel.title)
        .toList()
        .isNotEmpty) {
      Alerts.openStatusDialog(context,
          isSuccess: false,
          description:
              "Adhkaar with title \"${adhkaarModel.title}\" already exist");
    } else {
      Alerts.showLoading(context);
      Future.delayed(const Duration(milliseconds: 1000), () {
        box.add(adhkaarModel);
        BotToast.closeAllLoading();
        Navigator.pop(context);
      });
    }
  }

  static removeAdhkaar(BuildContext context,
      {required Box<AdhkaarModel> box, required int index}) {
    Alerts.showLoading(context);
    Future.delayed(const Duration(milliseconds: 1000), () {
      box.deleteAt(index);
      BotToast.cleanAll();
      //List.generate(2, (index) => Navigator.pop(context));
    });
  }
}
