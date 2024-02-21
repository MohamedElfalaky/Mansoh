import '../../../app/utils/exports.dart';

class CustomRoundedWidget extends StatelessWidget {
  const CustomRoundedWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        // width: ,
        decoration: BoxDecoration(
            color: Colors.white,
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
        child:child);
  }
}
