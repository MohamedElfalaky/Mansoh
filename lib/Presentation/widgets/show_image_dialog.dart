import '../../app/utils/exports.dart';

void showImageDialogWidget(BuildContext context, String image) {
  showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(image)),
        );
      });
}
