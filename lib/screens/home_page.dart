import 'package:adhkaar/helpers/alerts.dart';
import 'package:adhkaar/model/adhkaar_model.dart';
import 'package:adhkaar/service/save_adhkaar.dart';
import 'package:adhkaar/themes/app_color.dart';
import 'package:adhkaar/utils/app_consts.dart';
import 'package:adhkaar/utils/images.dart';
import 'package:adhkaar/widget/iconss.dart';
import 'package:adhkaar/widget/spacing.dart';
import 'package:adhkaar/widget/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<AdhkaarModel>(AppConst.ADHKAAR_DRAFT_KEY).listenable(),
        builder: (context, Box<AdhkaarModel> box, _) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                centerTitle: true,
                title: TextOf(
                  widget.title,
                  20.sp,
                  5,
                  color: AppColors.white,
                ),
              ),
              body: switch (box.isNotEmpty) {
                true => ListView.separated(
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (context, index) {
                      AdhkaarModel adhkar = box.values.toList()[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: InkWell(
                          onTap: () {
                            Alerts.actOnAdhkaar(context,
                                adhkaarModel: adhkar, index: index);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 3,
                                child: CircleAvatar(
                                  radius: 35,
                                  child: IconOf(
                                    FlutterIslamicIcons.tasbih3,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox.shrink()),
                              Expanded(
                                flex: 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextOf(
                                            adhkar.title,
                                            17.sp.sp,
                                            5,
                                            textOverflow: TextOverflow.ellipsis,
                                            align: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextOf(
                                            adhkar.subtitle,
                                            12.sp,
                                            5,
                                            textOverflow: TextOverflow.ellipsis,
                                            align: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: TextOf(
                                        adhkar.countMade.toString(),
                                        15.sp,
                                        4,
                                        textOverflow: TextOverflow.ellipsis,
                                      ))
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: box.length),
                false => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(ImageOf.empty),
                        YMargin(10.sp),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: TextOf(
                            "You currently dont have any Adhkaar running\nClick the button below to start",
                            15.sp,
                            4,
                            color: AppColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
              },
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: AppColors.primaryColor,
                elevation: 10,
                onPressed: () {
                  Alerts.addAdhkaar(context);
                },
                label: TextOf(
                  "Add Adhkaar",
                  15.sp,
                  5,
                  color: AppColors.white,
                ),
                icon: IconOf(
                  Icons.add,
                  color: AppColors.white,
                ),
              ));
        });
  }
}
