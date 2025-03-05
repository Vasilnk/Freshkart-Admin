import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({super.key, name, image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar(title: 'edit category'));
  }
}
