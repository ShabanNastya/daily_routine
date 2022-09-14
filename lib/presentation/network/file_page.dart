import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

enum PageState {
  CHOOSING_FILE,
  LOADING,
  FINISH,
}

class FilePage extends StatefulWidget {
  const FilePage({Key? key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  File? image;
  double loadPersent = 0;
  PageState state = PageState.CHOOSING_FILE;
  String resultText = '';
  int lastTimeMs = 0;

  Future chooseFile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('File selection error');
    }
  }

  void _sendFile() async {
    setState(() {
      state = PageState.LOADING;
    });

    FormData formData = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'file': image,
    });
    await Dio().post('https://httpbin.org/post', data: formData,
        onSendProgress: (count, total) {
      print(count / total);
      setState(() {
        loadPersent = count / total;
      });
    });

    setState(() {
      state = PageState.FINISH;
    });
  }

  List<Widget> _buildImageBlock() {
    switch (state) {
      case PageState.LOADING:
        return <Widget>[
          SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              value: loadPersent,
            ),
          )
        ];
      case PageState.FINISH:
        return <Widget>[
          Text(resultText),
          OutlinedButton(
            onPressed: () => setState(() {
              state = PageState.CHOOSING_FILE;
            }),
            child: const Text('Повторить'),
          ),
        ];
      default:
        {
          return <Widget>[
            image != null
                ? SizedBox(
                    height: 200,
                    width: 160,
                    child: Image.file(
                      image!,
                    ))
                : const Text('pppppp'),
            OutlinedButton(
              onPressed: chooseFile,
              child: const Text('Выбрать файл'),
            ),
          ];
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildImageBlock(),
              ),
            ),
            if (state == PageState.CHOOSING_FILE)
              OutlinedButton(
                  onPressed: image != null ? _sendFile : null,
                  child: const Text('sent'))
          ],
        ),
      ),
    );
  }
}
