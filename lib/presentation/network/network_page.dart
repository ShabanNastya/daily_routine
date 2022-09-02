import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///https://cat-fact.herokuapp.com/facts/random

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  String? text;
  String? imageUrl;
  bool isCached = false;

  void _sendRequest() async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor());
      Response catResponse =
          await dio.get('https://cat-fact.herokuapp.com/facts/random');
      setState(() {
        text = 'Это данные респонс ${catResponse.data['text']}';
        imageUrl = 'https://http.cat/${catResponse.statusCode}';
      });
    } on DioError catch (error) {
      setState(() {
        text = error.message;
        int? errorCode = error.response?.statusCode;
        if (errorCode != null) {
          imageUrl = 'https://http.cat/${errorCode}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (imageUrl != null) Image.network(imageUrl!),
          Text(
            text ?? 'no data yet',
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: _sendRequest,
            child: const Text('send fact'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('enable cache'),
              Switch(
                  value: isCached,
                  onChanged: (value) {
                    setState(() {
                      isCached = value;
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
