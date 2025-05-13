import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImageCloudnaryService {
  static const cloudName = 'dngzwobjp';
  static const uploadPreset = 'freshkartImages';

  static Future<String> uploadImageToCloudnary(
    Uint8List imageBytes, [
    String? fileName,
  ]) async {
    var uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request =
        http.MultipartRequest("POST", uri)
          ..fields['upload_preset'] = uploadPreset
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              imageBytes,
              filename: fileName ?? 'image.jpg',
            ),
          );
    var responce = await request.send();
    var responceData = await responce.stream.bytesToString();
    var jsonResponce = jsonDecode(responceData);

    if (responce.statusCode == 200) {
      return jsonResponce['secure_url'];
    } else {
      return '';
    }
  }
}
