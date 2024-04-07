import '../../../../app/utils/exports.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(Icons.delete), onPressed: onPressed,color: Colors.red,);
  }
}
