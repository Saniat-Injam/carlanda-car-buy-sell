import 'package:carlanda_car_buy_sell/core/common/entity/history_entity.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonHistoryCard extends StatelessWidget {
  const CommonHistoryCard({super.key, required this.history});
  final HistoryEntity history;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: context.height < 700
            ? context.height * 0.2
            : context.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),

        child: Row(
          children: [
            Container(
              width: context.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                image: DecorationImage(
                  image: AssetImage(history.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            16.widthSpace(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: history.title,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: '#151B27'.toColor(),
                  ),
                  4.heightSpace(),
                  Row(
                    children: [
                      CustomText(
                        text: "Tracking ID: ",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: '#62666E'.toColor(),
                      ),
                      CustomText(
                        text: history.trackingId,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                        color: '#62666E'.toColor(),
                      ),
                    ],
                  ),

                  4.heightSpace(),
                  Row(
                    children: [
                      CustomText(
                        text: "Date: ",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: '#62666E'.toColor(),
                      ),
                      CustomText(
                        text: history.date,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                        color: '#62666E'.toColor(),
                      ),
                    ],
                  ),
                  10.heightSpace(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 25.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: getColorOnStatus(
                              type: history.historyType,
                            ).withValues(alpha: 0.2),
                          ),
                          child: Center(
                            child: CustomText(
                              text: getStatusOnTyp(type: history.historyType),
                              color: getColorOnStatus(
                                type: history.historyType,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorOnStatus({required HistoryType type}) {
    if (type == HistoryType.inProgress) return "#1744B4".toColor();
    if (type == HistoryType.deliverd) return "#098F36".toColor();
    if (type == HistoryType.cancel) return "#CF0607".toColor();
    return "#1744B4".toColor();
  }

  String getStatusOnTyp({required HistoryType type}) {
    if (type == HistoryType.inProgress) return "In Progress";
    if (type == HistoryType.deliverd) return "Delivered";
    if (type == HistoryType.cancel) return "Cancel";
    return "";
  }
}
