import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/utils.dart';

import '../../../res/app_colors.dart';
import '../../../utils/app_text_style.dart';

class KeyValueWidget extends StatelessWidget {
  final String title;
  final dynamic value;
  const KeyValueWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text('$title :', style: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.textGreyDark, fontSize: 16.sp)),
        (defaultPadding / 2).horizontalSpace,
        Expanded(child: Text(value, style: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight, fontSize: 14.sp))),
      ],
    );
  }
}
