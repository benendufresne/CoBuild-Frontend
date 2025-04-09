import 'package:cobuild/ui/components/text/title3.dart';
import 'package:flutter/material.dart';

/// Common emspty listing view
class EmptyListing extends StatelessWidget {
  final String title;
  const EmptyListing({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Title3(title: title, fontSize: 16));
  }
}
