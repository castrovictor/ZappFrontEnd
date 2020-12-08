// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// File  _image;
// final pickerIm = ImagePicker();
// // This funcion will helps you to pick and Image from Gallery
// _pickImageFromGallery() async {
//     PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

//     File image = File(pickedFile.path);

//     setState(() {
//         _image = image;
//     });
// }

// File _cameraImage;
// final pickerImCam = ImagePicker();
// // This funcion will helps you to pick and Image from Camera
// _pickImageFromCamera() async {
//     PickedFile pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 50);

//     File image = File(pickedFile.path);

//     setState(() {
//       _cameraImage = image;
//     });
// }

// File _video;
// final pickerVid = ImagePicker();

// // This funcion will helps you to pick a Video File
// _pickVideo() async {
//     PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
//      _video = File(pickedFile.path);
//     _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
//       setState(() { });
//       _videoPlayerController.play();
//     });
// }

// File _cameraVideo;
// final pickerVidCam = ImagePicker();

// // This funcion will helps you to pick a Video File from Camera
// _pickVideoFromCamera() async {
//     PickedFile pickedFile = await picker.pickVideo(source: ImageSource.camera);
//      _cameraVideo = File(pickedFile.path);
//     _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
//       setState(() { });
//       _cameraVideoPlayerController.play();
//     });
// }
