import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../res/app_colors.dart';
import '../../../utils/shimmer_utils.dart';
import '../../../utils/utils.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerUtils.shimmer(
      child: ShimmerUtils.shimmerContainer(
          decoration: BoxDecoration(
            color: AppColors.gradientEnd.withAlpha(20),
            borderRadius: BorderRadius.circular(defaultRadius * 1.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShimmerUtils.shimmer(
                  baseColor: AppColors.gradientEnd.withCtmOpacity(0.1),
                  highlightColor: AppColors.gradientEnd,
                  child: ShimmerUtils.shimmerContainer(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gradientEnd,
                    ),
                  ),
                ),
                const SizedBox(width: defaultPadding / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerUtils.shimmer(
                        baseColor: AppColors.gradientEnd.withCtmOpacity(0.1),
                        highlightColor: AppColors.gradientEnd,
                        child: ShimmerUtils.shimmerContainer(
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.gradientEnd,
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      ShimmerUtils.shimmer(
                        baseColor: AppColors.gradientEnd.withCtmOpacity(0.1),
                        highlightColor: AppColors.gradientEnd,
                        child: ShimmerUtils.shimmerContainer(
                          height: 20.h,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color:AppColors.gradientEnd,
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: defaultPadding / 2),
                ShimmerUtils.shimmer(
                  baseColor: AppColors.gradientEnd.withCtmOpacity(0.1),
                  highlightColor:AppColors.gradientEnd,
                  child: ShimmerUtils.shimmerContainer(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gradientEnd,
                    ),
                  ),
                ),
                const SizedBox(width: defaultPadding / 2),
                ShimmerUtils.shimmer(
                  baseColor: AppColors.gradientEnd.withCtmOpacity(0.1),
                  highlightColor: AppColors.gradientEnd,
                  child: ShimmerUtils.shimmerContainer(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gradientEnd,
                    ),
                  ),
                )
              ],
            ),
          )),
    ).paddingOnly(bottom: defaultPadding);
  }
}
