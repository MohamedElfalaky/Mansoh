
extension ImageExtension on String{

     bool get isImg=> endsWith('png') || endsWith('jpg') || endsWith('jpeg');
     bool get isVoice => endsWith('m4a') || endsWith('mp3');
     bool get isPDF => endsWith('pdf');
}