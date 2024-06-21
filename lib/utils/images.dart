/// ============================[BASICALLY DEFINES PATHS TO IMAGE FOLDER]
enum ImagePath { usual, svg, icon, gif }

/// ============================[IMAGE COOCKER]
String image(
  String imageName, {
  ImagePath imagePath = ImagePath.usual,
}) {
  /// ============================[DETERMINES PATH TO IMAGE FOLDER]
  String folderName = switch (imagePath) {
    ImagePath.svg => "svgs",
    ImagePath.icon => "icons",
    ImagePath.gif => "gifs",
    _ => "images"
  };
  return 'assets/$folderName/$imageName.${folderName.contains("svg") ? "svg" : folderName.contains("gif") ? "gif" : "png"}';
}

class ImageOf {
  static String empty = image("empty");
  static String logo = image("logo");
}
