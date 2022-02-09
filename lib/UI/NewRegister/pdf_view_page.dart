

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PdfViewPage extends StatefulWidget {
  final File file;
  const PdfViewPage({ Key? key , required this.file}) : super(key: key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
  final name = 'Aydınlatma Metni ve KVKK sözleşmesi';
    return Scaffold(appBar: AppBar(
      backgroundColor:Theme.of(context).primaryColorDark,
      title:Text("$name",style:TextStyle(fontSize:MediaQuery.of(context).size.width/24) )),
    body:PDFView(

     filePath: widget.file.path, 
    ),
    );
  }
}