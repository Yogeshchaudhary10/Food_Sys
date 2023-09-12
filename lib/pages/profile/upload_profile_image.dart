// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/resources/color_manager.dart';
// import 'package:food_ordering_app/resources/dimension.dart';
// import 'package:food_ordering_app/resources/routes_manager.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadProfile extends StatefulWidget {
//   const UploadProfile({Key? key}) : super(key: key);

//   @override
//   State<UploadProfile> createState() => _UploadProfileState();
// }

// class _UploadProfileState extends State<UploadProfile> {
//   File? pickedImage;

//   void imagePickerOption() {
//     Get.bottomSheet(
//       SingleChildScrollView(
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(10.0),
//             topRight: Radius.circular(10.0),
//           ),
//           child: Container(
//             color: Colors.white,
//             height: Dimension.height10 * 25,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Text(
//                     "Pic Image From",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: Dimension.height10,
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       pickImage(ImageSource.camera);
//                     },
//                     icon: const Icon(Icons.camera),
//                     label: const Text("CAMERA"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       pickImage(ImageSource.gallery);
//                     },
//                     icon: const Icon(Icons.image),
//                     label: const Text("GALLERY"),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(Icons.close),
//                     label: const Text("CANCEL"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> pickImage(ImageSource imageType) async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? photo = await picker.pickImage(source: imageType);
//       if (photo == null) return;
//       final tempImage = File(photo.path);
//       setState(() {
//         pickedImage = tempImage;
//       });

//       Get.back();
//     } catch (error) {
//       debugPrint(error.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushNamed(context, Routes.profileScreen);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.blackColor,
//           ),
//         ),
//         centerTitle: true,
//         title: const Text('IMAGE PICKER'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             height: Dimension.height10 * 5,
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.blackColor, width: 5),
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(100),
//                     ),
//                   ),
//                   child: ClipOval(
//                     child: pickedImage != null
//                         ? Image.file(pickedImage!)
//                         : Image.network(
//                             'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
//                             width: 170,
//                             height: 170,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 5,
//                   child: IconButton(
//                     onPressed: imagePickerOption,
//                     icon: const Icon(
//                       Icons.add_a_photo_outlined,
//                       color: Colors.blue,
//                       size: 30,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton.icon(
//                 onPressed: imagePickerOption,
//                 icon: const Icon(Icons.add_a_photo_sharp),
//                 label: const Text('UPLOAD IMAGE')),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/profile/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadScreen extends StatefulWidget {
  final String? uploadedImageUrl;

  const ImageUploadScreen({super.key, this.uploadedImageUrl});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final picker = ImagePicker();
  File? _imageFile;
  String? _uploadedImageUrl;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      final storage = FirebaseStorage.instance;
      final Reference storageRef =
          storage.ref().child('images/${DateTime.now()}.png');
      final UploadTask uploadTask = storageRef.putFile(_imageFile!);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _uploadedImageUrl = downloadUrl;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Image uploaded successfully!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uploadedImageUrl: _uploadedImageUrl,
                      ),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to upload image: $error'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, Routes.profileScreen);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : const Icon(Icons.image, size: 10),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: const Text('Pick Image from Gallery'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Text('Take Image from Camera'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 20),
              if (_uploadedImageUrl != null)
                Text(
                  'Uploaded Image URL:\n$_uploadedImageUrl',
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
