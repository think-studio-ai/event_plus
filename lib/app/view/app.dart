import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:event_plus/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:event_plus/feature/qr_code_scan/presentation/widget/qr_code_view.dart';
import 'package:http/http.dart' as http;

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('qrView')),
        body: const Center(
          child: CallingQrCodeView(),
        ),
      ),
    );
  }
}
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrCodeView(onCreateQrController: (qrViewController ) {
          qrViewController.scannedDataStream.listen((scanData) {
            if(scanData.code != null){
              qrViewController.stopCamera();
              Navigator.pop(context,scanData.code);
            }

          });
        }, onPermissionSet: (QRViewController , bool ) {  },
      ),
    );
  }
}

class CallingQrCodeView extends StatefulWidget {
  const CallingQrCodeView({super.key});

  @override
  State<CallingQrCodeView> createState() => _CallingQrCodeViewState();
}

class _CallingQrCodeViewState extends State<CallingQrCodeView> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Qr code'),
    );
  }
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final  result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const App()),
    );
    if (!mounted) return;

    List<String> lines = const LineSplitter().convert(result as String);
    for (var i = lines.length - 1; i >= 0; i--) {
      if (lines[i].startsWith("BEGIN:VCARD") ||
          lines[i].startsWith("END:VCARD") ||
          lines[i].trim().isEmpty) {
        lines.removeAt(i);
      }
    }

    for (var i = lines.length - 1; i >= 0; i--) {
      if (!lines[i].startsWith(new RegExp(r'^\S+(:|;)'))) {
        String tmpLine = lines[i];
        String prevLine = lines[i - 1];
        lines[i - 1] = prevLine + ', ' + tmpLine;
        lines.removeAt(i);
      }
    }
    final code = _strip(getWordOfPrefix('Key',lines) ?? '');
    if(code != null){
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content:
          Text('key is $code'),),);
      final response = await http.get(Uri.parse('https://imceegypt.com/admin/public/entrance/$code'));
      if (response.statusCode == 200) {
        print(response.body);
        // If the server did return a 200 OK response,
        // then parse the JSON.
        QrModel model = QrModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
             SnackBar(content:
            Text('${model.name} ${model.status}'),),);

      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        // throw Exception('Failed to load album');
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content:
            Text('Error'),),);
      }


    }else{
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content:
          Text('Error'),),);
    }


  }
  String? _strip(String? baseString) {
    if (baseString == null) {
      return null;
    }
    try {
      return RegExp(r'(?<=:).+').firstMatch(baseString)?.group(0);
    } catch (e) {
      return null;
    }
  }
  String? getWordOfPrefix(String prefix , List<String> lines) {
    //returns a word of a particular prefix from the tokens minus the prefix [case insensitive]
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].toUpperCase().startsWith(prefix.toUpperCase())) {
        String word = lines[i];
        word = word.substring(prefix.length, word.length);
        return word;
      }
    }
    return null;
  }
}
class QrModel {
  int? id;
  String? name;
  String? lang;
  String? status;

  QrModel({this.id, this.name, this.lang, this.status});

  QrModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'].toString();
    lang = json['lang'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lang'] = this.lang;
    data['status'] = this.status;
    return data;
  }
}
