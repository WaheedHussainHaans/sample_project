import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class ImageHelper {
  static Future<String> uploadImageLatest(File file, String fireKey) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref("$fireKey/${DateTime.now().millisecondsSinceEpoch}");

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      print('success');
      var url = await taskSnapshot.ref.getDownloadURL();
      return url.toString();
    } catch (e) {
      print('error in uploading image for $fireKey: $e');
      return null;
    }
  }
}
