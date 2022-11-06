import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:good_karma_app/services/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<File?> _compressImage(String imageId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File? compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.path,
      '$path/img_$imageId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }

  static Future<String> _uploadImage(String path, File image) async {
    UploadTask uploadTask = storageRef.child(path).putFile(image);
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadEventImage(String? url, File? imageFile) async {
    String? imageId = const Uuid().v4();
    File? image = await _compressImage(imageId, imageFile!);

    if (url != null) {
      RegExp exp = RegExp(r'event_(.*).jpg');
      imageId = exp.firstMatch(url)![1];
    }
    String downloadUrl = await _uploadImage(
      'images/events/events_$imageId.jpg',
      image!,
    );
    return downloadUrl;
  }

  static Future<String> uploadUserProfileImage(
      String url, File imageFile) async {
    String? photoId = const Uuid().v4();
    File? image = await _compressImage(photoId, imageFile);

    if (url.isNotEmpty) {
      // Updating user profile image
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)![1];
    }

    String downloadUrl = await _uploadImage(
      'images/users/userProfile_$photoId.jpg',
      image!,
    );
    return downloadUrl;
  }

  Future<String> uploadMessageImage(File imageFile) async {
    String imageId = const Uuid().v4();
    File? image = await _compressImage(imageId, imageFile);
    String downloadUrl = await _uploadImage(
      'images/messages/message_$imageId.jpg',
      image!,
    );
    return downloadUrl;
  }
}
