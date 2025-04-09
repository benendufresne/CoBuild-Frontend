import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

/// PDF viewer , to open any pdf inside of app
class PDFScreen extends StatefulWidget {
  final String? pdfUrl;
  final String? path;

  const PDFScreen({this.pdfUrl, this.path, super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? filePath;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      if (widget.pdfUrl != null) {
        // Load PDF from URL
        final response = await http.get(Uri.parse(widget.pdfUrl!));
        if (response.statusCode == 200) {
          final tempDir = await getTemporaryDirectory();
          final path = '${tempDir.path}/temp.pdf';
          final file = File(path);
          await file.writeAsBytes(response.bodyBytes);
          setState(() {
            filePath = path;
          });
        } else {
          setState(() {
            errorMessage = 'Failed to load PDF from URL.';
          });
        }
      } else if (widget.path != null) {
        // Load PDF from local path
        final file = File(widget.path!);
        if (await file.exists()) {
          setState(() {
            filePath = widget.path;
          });
        } else {
          setState(() {
            errorMessage = 'The file does not exist at the specified path.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'No source provided for the PDF.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred while loading the PDF: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(title: S.current.media),
      body: _data(),
    );
  }

  Widget _data() {
    if (filePath != null) {
      return PDFView(
        filePath: filePath!,
      );
    } else if (errorMessage != null) {
      return Center(
        child: Text(errorMessage!),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
