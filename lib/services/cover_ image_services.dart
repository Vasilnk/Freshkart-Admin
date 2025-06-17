import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/services/api_services/image_cloudnary_service.dart';

class CoverImageServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getCoverImages() async {
    final snapshot =
        await firestore
            .collection('coverImages')
            .doc('J4j2Inec09JTydHf2wkO')
            .get();

    final imageList = List<String>.from(snapshot.data()?['images']);
    return imageList;
  }

  Future<void> updateCoverImages(List<dynamic> coverImages) async {
    final List<String> imageUris = [];
    String? uploadedUri;
    for (var image in coverImages) {
      if (image is! String) {
        uploadedUri = await ImageCloudnaryService.uploadImageToCloudnary(image);
      } else {
        uploadedUri = image;
      }

      imageUris.add(uploadedUri);
    }

    await FirebaseFirestore.instance
        .collection('coverImages')
        .doc('J4j2Inec09JTydHf2wkO')
        .set({'images': imageUris});
  }
}
