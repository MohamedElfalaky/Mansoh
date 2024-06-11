import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/utils/extensions.dart';

import '../../../../app/style/icons.dart';
import '../../../../app/utils/exports.dart';

Row imageMessageViewWidget(String image) {
  return Row(
    children: [
      image.isImg
          ? ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          width: 50,
          height: 50,
          placeholder: (context, string) {
            return SvgPicture.asset(photo);
          },
          errorWidget: (context, string, object) {
            return Image.asset(Constants.imagePlaceHolder);
          },
        ),
      )
          : image.isPDF
          ? SvgPicture.asset(pdf)
          : image.isVoice
          ? SvgPicture.asset(mp4Icon)
          : const SizedBox.shrink(),
      const SizedBox(width: 7),
      Text(
        image.isPDF? 'click_to_see_file'.tr :    'click_to_see_full_image'.tr,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
