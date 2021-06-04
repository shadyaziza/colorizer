import 'dart:convert';
import 'dart:io';

import 'package:colorizer/features/onboarding/view/widgets/onboarding_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:http/http.dart' as http;
import 'features/onboarding/view/onboarding.dart';

void main() {
  runApp(ColorizerApp());
}

class ColorizerApp extends StatelessWidget {
  const ColorizerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.pinkAccent[700]),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              Size(250, 75),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
          ),
        ),
      ),
      home: OnBoardingScreen(),
      // theme: AppTheme,
    );
  }
}

final key = '3d82dc8a-2f8e-4d08-a354-3996f2a46437';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Dio dio = Dio();
  final ImagePicker picker = ImagePicker();
  late String? imagePath = '';
  late String? modifiedImage = '';
  late bool isLoading = false;
  late String downloadedImagePath = '';
  uploadImage() async {
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        imagePath!,
        filename: 'image',
      ),
    });

    final response = await dio.post(
      'https://api.deepai.org/api/colorizer',
      data: data,
      // queryParameters: {'image': imagePath},
      options: Options(
        headers: {'api-key': key},
      ),
    );

    print(response.data);
  }

  pickImage() async {
    final PickedFile? pickedImage =
        await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imagePath = pickedImage!.path;
    });
  }

  postImage() async {
    setState(() {
      isLoading = true;
    });
    var request = http.MultipartRequest(
        "POST", Uri.parse('https://api.deepai.org/api/colorizer'));
//add Headers
    request.headers['api-key'] = key;
//create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", imagePath!);

//add multipart to request
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    final responseJson = jsonDecode(responseString);
    setState(() {
      modifiedImage = responseJson['output_url'];
      isLoading = false;
    });
    await downloadImage();
    print(responseString);
  }

  downloadImage() async {
    // setState(() {
    //   isLoading = true;
    // });
    final imageId = await ImageDownloader.downloadImage(modifiedImage!);
    final path = await ImageDownloader.findPath(imageId!);
    setState(() {
      downloadedImagePath = path!;
    });
    // setState(() {
    //   isLoading = false;
    // });
    showSnackBar();
  }

  showSnackBar() {
    Builder(
      builder: (ctx) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text('Image Successfully Downloaded at'),
                Text(downloadedImagePath),
              ],
            ),
            backgroundColor: Colors.pinkAccent[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colorize'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (imagePath != null && imagePath!.isNotEmpty) {
            await postImage();
          }
        },
        child: Icon(Icons.color_lens_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Stack(
                  children: [
                    if (imagePath != null && imagePath!.isNotEmpty)
                      Image.file(
                        File(
                          imagePath!,
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    Center(
                      child: Opacity(
                        opacity: imagePath!.isNotEmpty ? 0.2 : 1,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await pickImage();
                          },
                          icon: Icon(Icons.photo_camera),
                          label: Text('Pick a photo'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (modifiedImage != null && modifiedImage!.isNotEmpty)
              Expanded(
                child: Image.network(
                  modifiedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )

            // Image.file(File(imagePath!)),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton.icon(
            //   onPressed: () async {
            //     await pickImage();
            //   },
            //   icon: Icon(Icons.photo_camera),
            //   label: Text('Pick a photo'),
            // ),
          ],
        ),
      ),
    );
  }

  Image? _buildImage() {
    if (modifiedImage != null && modifiedImage!.isNotEmpty) {
      return Image.network(modifiedImage!);
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.file(
        File(imagePath!),
      );
    }
  }
}
