

// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/attachment_source_choice_dialog.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AssetService {
  static pickFile(bool allowCrop, FilePickerResult? result) async {
    if (result != null) {
      PlatformFile file = result.files.first;

      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      if (allowCrop) {
        ImageCropper imageCropper =  ImageCropper();
        
         await imageCropper.cropImage(
            sourcePath: file.path!,
            aspectRatio:const CropAspectRatio(ratioX: 1, ratioY: 1),
            compressQuality: 100,
            maxWidth: 700,
            maxHeight: 700,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
                toolbarColor: KColor.blue,
                toolbarTitle: "Crop Image",
                statusBarColor: KColor.blue,
                backgroundColor: KColor.white,
                activeControlsWidgetColor: KColor.primary,
                toolbarWidgetColor: KColor.white));
        return imageCropper;
      }
      return file;
    }
    return null;
  }

  static pickImageVideo(bool allowCrop, context, imageSource,
      {isVideo = false}) async {
    if (imageSource != null) {
      final ImagePicker _picker = ImagePicker();
      XFile? result = isVideo
          ? await _picker.pickVideo(source: imageSource)
          : await _picker.pickImage(source: imageSource);

      if (result != null && !isVideo) {
        XFile image = result;

        print('image name  ${image.name}');
        print('image.mimeType ${image.mimeType}');
        print('image.path - ${image.path}');
        if (allowCrop) {
          ImageCropper imageCropper = ImageCropper();

          await imageCropper.cropImage(
              sourcePath: image.path,
              aspectRatio:const CropAspectRatio(ratioX: 1, ratioY: 1),
              compressQuality: 100,
              maxWidth: 700,
              maxHeight: 700,
              compressFormat: ImageCompressFormat.jpg,
              androidUiSettings: AndroidUiSettings(
                  toolbarColor: KColor.primary,
                  toolbarTitle: "Crop Image",
                  statusBarColor: KColor.primary,
                  backgroundColor: KColor.white,
                  activeControlsWidgetColor: KColor.primary,
                  toolbarWidgetColor: KColor.white));
          print('cropped = $imageCropper');
          return imageCropper;
        }
        return image;
      } else if (result != null && isVideo) {
        return result;
      }
    }
    return null;
  }

   

  static pickMedia(
      bool allowCrop, context, allowFiles, showChoiceDialog) async {
    final mediaSource = showChoiceDialog
        ? await showDialog(
            context: context,
            builder: (context) =>
                AttachmentSourceChoiceDialog(isAllowFiles: allowFiles))
        : 'file';
    print('mediaSource = $mediaSource');
    if (mediaSource != null) {
      if (mediaSource != 'file') {
        return pickImageVideo(allowCrop, context, mediaSource);
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'png', 'jpeg', 'webp', 'doc', 'pdf'],
            allowMultiple: false);
        return pickFile(allowCrop, result!);
      }
    }
  }

  // static uploadMedia(file) async {
  //   String fileName = file.name;
  //   print("File name: $fileName");
  //   String type = (mime(fileName))!.split('/')[0];
  //   print("Type: $type");
  //   String subType = (mime(fileName))!.split('/')[1];
  //   print("Subtype: $subType");

  //   var responseBody = await Network.handleResponse(
  //     await Network.multiPartRequest(
  //       API.uploadFile,
  //       'POST',
  //       files: [File(file.path)],
  //       filedName: 'file',
  //     ),
  //   );

  //   print(responseBody);
  //   return responseBody;
  // }

  // static uploadMediaSingle(file) async {
  //   String fileName = file.name;
  //   print("File name: $fileName");
  //   String type = (mime(fileName))!.split('/')[0];
  //   print("Type: $type");
  //   String subType = (mime(fileName))!.split('/')[1];
  //   print("Subtype: $subType");

  //   var responseBody = await Network.handleResponse(
  //     await Network.multiPartRequestSingle(
  //       API.uploadFile,
  //       'POST',
  //       file: File(file.path),
  //       fileFieldName: file.path,
  //       filename: fileName,
  //       type: type,
  //       subType: subType,
  //     ),
  //   );

  //   print("ResponsBody:$responseBody");
  //   return responseBody;
  // }
}

  // static uploadCroppedMedia(file) async {
  //   String fileName = Path.basename(file.path);
  //   print("File name: $fileName");
  //   String type = (mime(fileName))!.split('/')[0];
  //   print("Type: $type");
  //   String subType = (mime(fileName))!.split('/')[1];
  //   print("Subtype: $subType");

  //   var responseBody = await Network.handleResponse(
  //     await Network.multiPartRequest(API.uploadFile, 'POST'),
  //   );

  //   //print(responseBody);
  //   return responseBody;
  // }

//   static downloadFile(imageUrl) async {
//     Dio dio = Dio();
//     var dir = await getApplicationDocumentsDirectory();
//     print('dir == $dir');
//     String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
//     toast('Download in progress...');
//     dio.download(
//       imageUrl,
//       "${dir.path}/$fileName",
//       onReceiveProgress: (rec, total) {
//         if ((rec / total * 100.0).toStringAsFixed(0) == '100')
//           return toast('Download completed!', bgColor: KColor.green);
//         print('fileName = $fileName');
//         print("Downloading File : " + (rec / total * 100.0).toStringAsFixed(0));
//       },
//     );
//   }
// }

// final assetManagerProvider = ChangeNotifierProvider<AssetManager>((ref) {
//   return AssetManager();
// });

// class AssetManager extends ChangeNotifier {
//   /// Asset List
//   final List<File> _assets = [];
//   List _networkAssets = [];

//   /// Flag
//   bool isVideoSelected = false;
//   bool isDocumentSelected = false;
//   bool isMediaUploading = false;

//   updateMediaUploadFlag(v) {
//     isMediaUploading = v;
//     notifyListeners();
//   }

//   UnmodifiableListView<File> get assets => UnmodifiableListView(_assets);

//   UnmodifiableListView get networkAssets =>
//       UnmodifiableListView(_networkAssets);

//   set setNetworkAssets(networkAssets) {
//     _networkAssets = networkAssets;
//   }

//   void addAssets(File asset) async {
//     if ((mime(asset.path))!.split('/')[0] == "video") {
//       if (_assets.isNotEmpty) {
//         /// If previously image/document were selected need to clear them.
//         /// We have to wait for a brief moment after clearing. Otherwise
//         /// wrong codec exception thrown. That's why used the delayed function.
//         _assets.clear();
//         notifyListeners();
//         await Future.delayed(Duration(milliseconds: 100));
//       }
//       if (_networkAssets.isNotEmpty) {
//         /// If previously image/document existed in the feed post need to clear them.
//         /// We have to wait for a brief moment after clearing. Otherwise
//         /// wrong codec exception thrown. That's why used the delayed function.
//         _networkAssets.clear();
//         notifyListeners();
//         await Future.delayed(Duration(milliseconds: 100));
//       }
//       _assets.add(asset);
//       isVideoSelected = true;
//     } else if ((mime(asset.path))!.split('/')[0] == "application") {
//       if (!isDocumentSelected) {
//         if (_assets.isNotEmpty) {
//           /// If previously image/document were selected need to clear them.
//           /// We have to wait for a brief moment after clearing. Otherwise
//           /// wrong codec exception thrown. That's why used the delayed function.
//           _assets.clear();
//           notifyListeners();
//           await Future.delayed(Duration(milliseconds: 100));
//         }
//       }
//       _assets.add(asset);
//       isDocumentSelected = true;
//     } else {
//       if (isVideoSelected || isDocumentSelected) {
//         /// Since we can only send Images/Video/Document at a
//         /// time need to check if video was already selected. If
//         /// it was we need to clear asset list and add images.
//         /// It seems anything related to video requires some
//         /// time to process hence the delay
//         _assets.clear();
//         isVideoSelected = false;
//         isDocumentSelected = false;
//         notifyListeners();
//         await Future.delayed(Duration(milliseconds: 100));
//       }
//       _assets.add(asset);
//     }
//     notifyListeners();
//   }

//   void removeNetworkAsset(index) {
//     _networkAssets.removeAt(index);
//     if (isVideoSelected = true) isVideoSelected = false;
//     notifyListeners();
//   }

//   void removeAsset(index) {
//     _assets.removeAt(index);
//     if (isVideoSelected = true) isVideoSelected = false;
//     notifyListeners();
//   }

//   void removeAll() {
//     _assets.clear();
//     if (isVideoSelected = true) isVideoSelected = false;
//     if (isDocumentSelected = true) isDocumentSelected = false;
//     notifyListeners();
//   }
// }
