import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/search/controller/search_screen_controller.dart';
import 'package:carlanda_car_buy_sell/features/search/presentation/components/filter_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  final SearchScreenController controller = Get.find<SearchScreenController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.all(8.w),
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: "#FFFFFF".toColor(),
            ),
            child: Center(child: SvgPicture.asset(IconPath.arrowBack)),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            controller: controller.searchTEC,
            hintText: "Search",
            onChanged: (value) => controller.search(queary: value),
            prefixIconPath: IconPath.search,
            suffixIconPath: IconPath.filter,
            onSuffixIconTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: "#E8E8E9".toColor(),
                builder: (_) => FilterBottomSheetWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}
