import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text('تطابق الصور', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo[800],
        ),
        body: ImagePage(),
      ),
    ),
  );
}

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  var leftImageNumber = 1;
  var rightImageNumber = 2;

  void changeImage() {
    leftImageNumber = Random().nextInt(8) + 1; //0-8
    rightImageNumber = Random().nextInt(8) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Text(
          leftImageNumber == rightImageNumber
              ? 'مبرك لقد نجحت'
              : 'حاول مرة اخرى',

          style: TextStyle(
            fontSize: 42.0,
            color: Colors.white,
            fontFamily: 'Georgia',
            backgroundColor: Colors.black12,
          ),
        ),

        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    changeImage();
                  });
                },
                child: Image.asset('images/image-$leftImageNumber.png'),
              ),
            ),

            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    changeImage();
                  });
                },
                child: Image.asset('images/image-$rightImageNumber.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
