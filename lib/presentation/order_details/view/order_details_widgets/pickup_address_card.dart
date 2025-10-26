import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flowery_driver/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/const/custom_cached_network_image.dart';
import '../../../../domain/entity/pending_orders/Store.dart';

class PickupAddressCard extends StatelessWidget {
  const PickupAddressCard({super.key, required this.store});
  final Store? store;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(color: AppColors.kLighterGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.sp),
              child: CustomCachedNetworkImage(
                imageUrl: store?.image,
                width: 55.w,
                height: 55.h,
                shimmerRadiusValue: 0,
                fit: BoxFit.cover,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    store?.name ?? "Unknown Store",
                    style: AppFonts.font16GreyWeight400,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      Image.asset(AppImages.locationIcon,
                          width: 15.w, height: 15.h),
                      5.horizontalSpace,
                      Expanded(
                        child: Text(
                          store?.address ?? "No address",
                          style: AppFonts.font13BlackWeight400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => callPhone(store?.phoneNumber ?? ""),
                    child: Icon(Icons.phone, color: AppColors.kPink, size: 22),
                  ),
                  15.horizontalSpace,
                  IconButton(
                    icon: Icon(Icons.message, color: AppColors.kPink, size: 22),
                    onPressed: () => openWhatsApp((store?.phoneNumber ?? ""),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> callPhone(String phoneNumber) async {
  final Uri phoneUri = Uri.parse("tel:$phoneNumber");

  if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
    print("Could not launch $phoneUri");
  }
}
Future<void> openWhatsApp(String phoneNumber) async {
  final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
  if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
    print("Could not launch WhatsApp for $phoneNumber");
  }
}