import '../../../../app/utils/exports.dart';

class CustomRoundedWidget extends StatelessWidget {
  const CustomRoundedWidget({super.key, required this.child,this.width,this.color});

  final Widget child;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        width:width??300,
        decoration: BoxDecoration(
            color: color??Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: child);
  }
}
