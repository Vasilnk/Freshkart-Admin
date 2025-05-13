// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freshkart_admin/bloc/coverImage/image_bloc.dart';
// import 'package:freshkart_admin/bloc/coverImage/image_event.dart';
// import 'package:freshkart_admin/bloc/coverImage/image_state.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:freshkart_admin/utils/colors.dart';
// import 'package:freshkart_admin/utils/styles.dart';
// import 'package:freshkart_admin/widgets/appbar.dart';

// class CoverImagesScreen extends StatefulWidget {
//   const CoverImagesScreen({super.key});

//   @override
//   State<CoverImagesScreen> createState() => _CoverImagesScreenState();
// }

// class _CoverImagesScreenState extends State<CoverImagesScreen> {
//   List<dynamic> coverImages = [];

//   Future<void> pickImage({int? index}) async {
//     final picker = ImagePicker();
//     final file = await picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       final imageFile = File(file.path);
//       setState(() {
//         if (index != null && index < coverImages.length) {
//           coverImages[index] = imageFile;
//         } else {
//           coverImages.add(imageFile);
//         }
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     context.read<CoverImageBloc>().add(LoadCoverImagesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(title: 'Cover Images'),
//       body: BlocBuilder<CoverImageBloc, CoverImageState>(
//         builder: (context, state) {
//           if (state is CoverImagesLoaded) {
//             // Only update once to prevent rebuilding issue
//             if (coverImages.isEmpty && state.coverImages.isNotEmpty) {
//               coverImages = List.from(state.coverImages);
//             }

//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 1.5,
//                 ),
//                 itemCount: coverImages.length,
//                 itemBuilder: (context, index) {
//                   final image = coverImages[index];

//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Stack(
//                       children: [
//                         InkWell(
//                           onTap: () => pickImage(index: index),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child:
//                                   image is File
//                                       ? Image.file(
//                                         image,
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                       )
//                                       : Image.network(
//                                         image,
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                       ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           right: 0,
//                           child: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (coverImages.length > 1) {
//                                   coverImages.removeAt(index);
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       backgroundColor: Colors.red,
//                                       content: Text('Need atleast 1 image'),
//                                     ),
//                                   );
//                                 }
//                               });
//                             },
//                             icon: const Icon(Icons.close, color: Colors.red),
//                             splashRadius: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           }

//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton.extended(
//             onPressed: () => pickImage(),
//             heroTag: 'Add',
//             label: const Text(
//               'Add cover Image',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             backgroundColor: const Color.fromARGB(255, 49, 47, 160),
//           ),
//           const SizedBox(width: 10),
//           FloatingActionButton.extended(
//             backgroundColor: AppColors.greenColor,
//             heroTag: 'Update',
//             onPressed: () {
//               context.read<CoverImageBloc>().add(
//                 UpdateCoverImagesEvent(coverImages),
//               );
//               context.pop();
//             },
//             label: Text('Update', style: AppStyles.elevatedButtonTextStyle),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/coverImage/image_bloc.dart';
import 'package:freshkart_admin/bloc/coverImage/image_event.dart';
import 'package:freshkart_admin/bloc/coverImage/image_state.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:freshkart_admin/widgets/appbar.dart';

class CoverImagesScreen extends StatefulWidget {
  const CoverImagesScreen({super.key});

  @override
  State<CoverImagesScreen> createState() => _CoverImagesScreenState();
}

class _CoverImagesScreenState extends State<CoverImagesScreen> {
  List<dynamic> coverImages =
      []; // Can be String (URL) or Uint8List (new image)

  @override
  void initState() {
    super.initState();
    context.read<CoverImageBloc>().add(LoadCoverImagesEvent());
  }

  Future<void> pickImage({int? index}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();

      setState(() {
        if (index != null && index < coverImages.length) {
          coverImages[index] = imageBytes;
        } else {
          coverImages.add(imageBytes);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Cover Images'),
      body: BlocBuilder<CoverImageBloc, CoverImageState>(
        builder: (context, state) {
          if (state is CoverImagesLoaded) {
            if (coverImages.isEmpty && state.coverImages.isNotEmpty) {
              coverImages = List.from(
                state.coverImages,
              ); // Network URLs (Strings)
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxixCount = 1;
                  if (constraints.maxWidth > 1200) {
                    crossAxixCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxixCount = 2;
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxixCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: coverImages.length,
                    itemBuilder: (context, index) {
                      final image = coverImages[index];

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () => pickImage(index: index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child:
                                      image is Uint8List
                                          ? Image.memory(
                                            image,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                          : Image.network(
                                            image,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (coverImages.length > 1) {
                                      coverImages.removeAt(index);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Need at least 1 image',
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                splashRadius: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () => pickImage(),
            heroTag: 'Add',
            label: const Text(
              'Add cover Image',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 49, 47, 160),
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            backgroundColor: AppColors.greenColor,
            heroTag: 'Update',
            onPressed: () {
              print(coverImages);
              context.read<CoverImageBloc>().add(
                UpdateCoverImagesEvent(coverImages), // Handle both URL + Bytes
              );
              context.pop();
            },
            label: Text('Update', style: AppStyles.elevatedButtonTextStyle),
          ),
        ],
      ),
    );
  }
}
