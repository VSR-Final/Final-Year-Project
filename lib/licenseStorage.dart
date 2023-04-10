import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class LicenseStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadFile(
    Uint8List filePath,
    String fileName,
  ) async {
    try {
      await storage.ref('images/licenses/$fileName').putData(filePath);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
