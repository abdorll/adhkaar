import 'dart:async';

import 'package:adhkaar/model/adhkaar_model.dart';
import 'package:adhkaar/service/save_adhkaar.dart';
import 'package:adhkaar/utils/app_consts.dart';
import 'package:adhkaar/widget/input_field.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:adhkaar/widget/iconss.dart';
import 'package:adhkaar/widget/spacing.dart';
import 'package:adhkaar/widget/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import '../themes/app_color.dart';

class Alerts {
  static openStatusDialog(BuildContext context,
      {String? title,
      Widget? subtitle,
      String? description,
      bool isSuccess = true,
      String? actionText,
      String? canceleText,
      VoidCallback? actionTextAction,
      bool isDismissible = true,
      bool isFull = true,
      bool hasCancel = true}) {
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (context) => Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 15.sp),
              backgroundColor: AppColors.white,
              elevation: 0,
              surfaceTintColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Padding(
                padding: EdgeInsets.all(15.sp)
                    .add(EdgeInsets.symmetric(horizontal: 2.sp)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      isFull == false
                          ? const SizedBox.shrink()
                          : IconOf(
                              switch (isSuccess) {
                                true => Icons.check_circle,
                                false => Icons.cancel
                              },
                              color: switch (isSuccess) {
                                true => AppColors.green,
                                false => AppColors.red
                              },
                              size: 60.sp,
                            ),
                      isFull == false
                          ? const SizedBox.shrink()
                          : XMargin(10.sp),
                      Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            isFull == false
                                ? const SizedBox.shrink()
                                : TextOf(
                                    (isSuccess && title == null)
                                        ? "Successful"
                                        : (!isSuccess && title == null)
                                            ? "Failed"
                                            : title!,
                                    16.sp,
                                    6),
                            isFull == false
                                ? const SizedBox.shrink()
                                : YMargin(8.sp),
                            switch (description == null) {
                              true => subtitle!,
                              false => TextOf(
                                  description!,
                                  14.sp,
                                  4,
                                  align: TextAlign.left,
                                )
                            }
                          ]))
                    ]),
                    actionText != null
                        ? Column(
                            children: [
                              YMargin(8.sp),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    hasCancel == true
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: TextOf(
                                              canceleText ?? "Cancel",
                                              16,
                                              5,
                                              color: AppColors.red,
                                              align: TextAlign.left,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    XMargin(30.sp),
                                    InkWell(
                                      onTap: () {
                                        actionTextAction == null
                                            ? Navigator.pop(context)
                                            : actionTextAction();
                                      },
                                      child: TextOf(
                                        actionText,
                                        16,
                                        5,
                                        align: TextAlign.left,
                                      ),
                                    ),
                                  ]),
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ));
  }

  static optionalDialog(BuildContext context,
      {required String text,
      String? left,
      String? right,
      String? title,
      Color? leftColor,
      rightColor,
      VoidCallback? onTapRight,
      VoidCallback? onTapLeft}) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 15.sp),
              backgroundColor: AppColors.white,
              elevation: 0,
              surfaceTintColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 20.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title == null
                        ? const SizedBox.shrink()
                        : Column(children: [
                            Row(
                              children: [
                                Expanded(
                                    child: TextOf(
                                  title,
                                  24.sp,
                                  6,
                                  align: TextAlign.left,
                                ))
                              ],
                            ),
                            YMargin(24.sp),
                          ]),
                    Row(
                      children: [
                        Expanded(
                            child: TextOf(
                          text,
                          16.sp,
                          5,
                          align: TextAlign.left,
                        ))
                      ],
                    ),
                    YMargin(24.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            onTapLeft == null
                                ? Navigator.pop(context)
                                : onTapLeft();
                          },
                          child: TextOf(
                            left ?? "Delete",
                            16,
                            5,
                            color: leftColor ?? AppColors.red,
                            align: TextAlign.left,
                          ),
                        ),
                        XMargin(30.sp),
                        InkWell(
                          onTap: () {
                            onTapRight ?? Navigator.pop(context);
                          },
                          child: TextOf(
                            right ?? "Cancel",
                            16,
                            5,
                            color: rightColor ?? AppColors.black,
                            align: TextAlign.left,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  static showLoading(BuildContext context) {
    BotToast.showLoading();
  }

  static addAdhkaar(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: const AddAdhkarContents()));
  }

  static void actOnAdhkaar(
    BuildContext context, {
    required AdhkaarModel adhkaarModel,
    required int index,
  }) {
    showDialog(
        barrierColor: AppColors.black.withOpacity(0.925),
        context: context,
        builder: (context) => ActOnAdhkaarBody(
              adhkaarModel: adhkaarModel,
              index: index,
            ));
  }
}

class ActOnAdhkaarBody extends StatefulWidget {
  final AdhkaarModel adhkaarModel;
  final int index;
  ActOnAdhkaarBody({
    required this.adhkaarModel,
    required this.index,
    super.key,
  });

  @override
  State<ActOnAdhkaarBody> createState() => _ActOnAdhkaarBodyState();
}

class _ActOnAdhkaarBodyState extends State<ActOnAdhkaarBody> {
  @override
  Widget build(BuildContext context) {
    AdhkaarModel adhkaarModel = widget.adhkaarModel;
    double countTextSize = 70.sp;
    if (adhkaarModel.countMade.toString().length >= 7) {
      countTextSize = 50.sp;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable:
                Hive.box<AdhkaarModel>(AppConst.ADHKAAR_DRAFT_KEY).listenable(),
            builder: (context, Box<AdhkaarModel> box, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  YMargin(0.025.sh),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.sp),
                    // decoration: BoxDecoration(
                    //     //color: AppColors.secondaryColor.withOpacity(0.4),
                    //     border: Border.all(color: AppColors.primaryColor, width: 3),
                    //     borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15.sp)
                        .add(EdgeInsets.only(top: 35.sp)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextOf(
                          "Title",
                          17.sp,
                          4,
                          color: AppColors.white,
                        ),
                        TextOf(adhkaarModel.title, 25.sp, 5,
                            color: AppColors.white),
                        YMargin(16.sp),
                        TextOf("Subtitle", 17.sp, 4, color: AppColors.white),
                        TextOf(adhkaarModel.subtitle, 25.sp, 5,
                            color: AppColors.white),
                        YMargin(16.sp),
                        SizedBox(
                          width: 0.8.sw,
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(color: AppColors.white)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextOf("Count", 17.sp, 4,
                                        maxLines: 1, color: AppColors.white),
                                    TextOf(adhkaarModel.countMade.toString(),
                                        countTextSize, 8,
                                        color: AppColors.white),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.25.sh,
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.white)),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox.square(
                                          dimension: 70.sp,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: AppColors.green)),
                                            child: IconOf(
                                              Icons.done,
                                              size: 50.sp,
                                              color: AppColors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      YMargin(10.sp),
                                      TextOf(
                                        "Done",
                                        15.sp,
                                        4,
                                        color: AppColors.white,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.sp)
                                  .add(EdgeInsets.only(bottom: 20.sp)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          2,
                                          (index) => InkWell(
                                                onTap: () {
                                                  (index == 0 &&
                                                          adhkaarModel
                                                                  .countMade ==
                                                              0)
                                                      ? () {}
                                                      : setState(() {
                                                          index == 0
                                                              ? adhkaarModel
                                                                      .setCount =
                                                                  adhkaarModel
                                                                          .countMade -
                                                                      1
                                                              : adhkaarModel
                                                                      .setCount =
                                                                  adhkaarModel
                                                                          .countMade +
                                                                      1;
                                                          box.putAt(
                                                              widget.index,
                                                              adhkaarModel);
                                                        });
                                                },
                                                child: CircleAvatar(
                                                  radius: 40.sp,
                                                  backgroundColor: (index == 0 &&
                                                          adhkaarModel
                                                                  .countMade ==
                                                              0)
                                                      ? AppColors.secondaryColor
                                                          .withOpacity(0.3)
                                                      : AppColors.primaryColor,
                                                  child: IconOf(
                                                    index == 0
                                                        ? Icons.remove
                                                        : Icons.add,
                                                    color: AppColors.white,
                                                    size: 25.sp,
                                                  ),
                                                ),
                                              )))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Alerts.optionalDialog(context,
                                              text:
                                                  "Are you sure you want to delete this Adhkar count?",
                                              left: "Yes",
                                              right: "No", onTapLeft: () {
                                            box.deleteAt(widget.index);
                                            List.generate(
                                                2,
                                                (index) =>
                                                    Navigator.pop(context));
                                          });
                                          // Navigator.pop(context);
                                        },
                                        child: SizedBox.square(
                                          dimension: 70.sp,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: AppColors.red)),
                                            child: IconOf(
                                              Icons.delete_outline_outlined,
                                              size: 50.sp,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      YMargin(10.sp),
                                      TextOf(
                                        "Delete",
                                        15.sp,
                                        4,
                                        color: AppColors.white,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (adhkaarModel.countMade > 0) {
                                            Alerts.optionalDialog(context,
                                                text:
                                                    "Are you sure you want to reset this Adhkar count?",
                                                left: "Yes",
                                                right: "No", onTapLeft: () {
                                              setState(() {
                                                adhkaarModel.setCount = 0;
                                                box.putAt(
                                                    widget.index, adhkaarModel);
                                              });
                                              Navigator.pop(context);
                                            });
                                          }
                                        },
                                        child: SizedBox.square(
                                          dimension: 70.sp,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: AppColors.blue)),
                                            child: IconOf(
                                              Icons.refresh_outlined,
                                              size: 50.sp,
                                              color: AppColors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                      YMargin(10.sp),
                                      TextOf(
                                        "Reset",
                                        15.sp,
                                        4,
                                        color: AppColors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class AddAdhkarContents extends StatefulWidget {
  const AddAdhkarContents({
    super.key,
  });

  @override
  State<AddAdhkarContents> createState() => _AddAdhkarContentsState();
}

class _AddAdhkarContentsState extends State<AddAdhkarContents> {
  late TextEditingController titleController,
      subtitleController,
      presetController;
  @override
  void initState() {
    setState(() {
      titleController = TextEditingController();
      subtitleController = TextEditingController();
      presetController = TextEditingController();
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    presetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        width: 0.9.sw,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
              ),
              child: TextOf(
                "Add an Adhkaar",
                15.sp,
                4,
                color: AppColors.primaryColor,
              ),
            ),
            YMargin(20.sp),
            InputField(
              fieldTitle: "Title",
              hintText: "eg: Alhamdulillah",
              fieldController: titleController,
            ),
            YMargin(16.sp),
            InputField(
              fieldTitle: "Subtitle",
              hintText: "eg: Thank Allahh for the gift of life",
              isOptional: true,
              fieldController: subtitleController,
            ),
            YMargin(16.sp),
            InputField(
              fieldTitle: "Starting count",
              hintText: "eg: 0",
              fieldController: presetController,
            ),
            YMargin(32.sp),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<AdhkaarModel>(AppConst.ADHKAAR_DRAFT_KEY)
                        .listenable(),
                builder: (context, Box<AdhkaarModel> box, _) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(0.4.sw, 50.sp),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          backgroundColor: AppColors.primaryColor),
                      onPressed: () {
                        Service.saveAdhkaar(context,
                            box: box,
                            adhkaarModel: AdhkaarModel(
                                title: titleController.text,
                                subtitle: subtitleController.text.isEmpty
                                    ? titleController.text
                                    : subtitleController.text,
                                countMade:
                                    int.tryParse(presetController.text) ?? 0));
                      },
                      child: TextOf(
                        "Add",
                        20.sp,
                        5,
                        color: AppColors.white,
                      ));
                })
          ],
        ),
      );
    });
  }
}
