
import '../../../../app/style/icons.dart';
import '../../../../app/utils/exports.dart';

Row audioStoppedWidget() {
  return Row(
    children: [
      SizedBox(
        height: 40,
        width: 210,
        child: SvgPicture.asset(voiceShape, fit: BoxFit.fill),
      ),
      const SizedBox(width: 10),
      CircleAvatar(
          backgroundColor: Constants.primaryAppColor,
          child: SvgPicture.asset(voice)),
    ],
  );
}

Row audioPlayingWidget() {
  return Row(mainAxisSize: MainAxisSize.min, children: [
    SizedBox(
      height: 40,
      width: 210,
      child: Image.asset('assets/images/gifnasoh.gif', fit: BoxFit.fill),
    ),
    const SizedBox(width: 10),
    const CircleAvatar(
        backgroundColor: Constants.primaryAppColor,
        child: Icon(Icons.pause, color: Colors.white)),
  ]);
}
