import '../../../app/utils/exports.dart';

class VoiceShaped extends StatelessWidget {
  const VoiceShaped({super.key, this.onPressed, required this.showClose});

  final void Function()? onPressed;
  final bool showClose;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SvgPicture.asset(voiceShape),
            if (showClose)
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    // borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.blue,
                    ),
                    onPressed: onPressed,
                    padding: EdgeInsets.zero,
                  )),
          ],
        ));
  }
}
