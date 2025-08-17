import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text('🎮 لعبة تطابق الصور', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo[800],
          centerTitle: true,
        ),
        body: ImageGame(),
      ),
    ),
  );
}

class ImageGame extends StatefulWidget {
  const ImageGame({super.key});

  @override
  State<ImageGame> createState() => _ImageGameState();
}

class _ImageGameState extends State<ImageGame> {
  var leftImageNumber = 1;
  var rightImageNumber = 2;
  int score = 0;
  int attempts = 0;
  int timeLeft = 30; // 30 ثانية للعب
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          t.cancel();
          showGameOverDialog();
        }
      });
    });
  }

  void changeImage() {
    leftImageNumber = Random().nextInt(8) + 1;
    rightImageNumber = Random().nextInt(8) + 1;
    attempts++;

    if (leftImageNumber == rightImageNumber) {
      score += 10; // تطابق ناجح
    } else {
      score -= 2; // خطأ
    }
  }

  void resetGame() {
    setState(() {
      score = 0;
      attempts = 0;
      timeLeft = 30;
      startTimer();
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("⏳ انتهى الوقت!"),
        content: Text("النتيجة: $score\nعدد المحاولات: $attempts"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: Text("إعادة اللعب"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 🔹 عرض النقاط والوقت
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("النقاط: $score",
                style: TextStyle(fontSize: 22, color: Colors.white)),
            Text("المحاولات: $attempts",
                style: TextStyle(fontSize: 22, color: Colors.white)),
            Text("⏱ $timeLeft",
                style: TextStyle(fontSize: 22, color: Colors.redAccent)),
          ],
        ),

        // 🔹 رسالة النجاح أو المحاولة
        Text(
          leftImageNumber == rightImageNumber
              ? '🎉 مبرك لقد نجحت!'
              : '❌ حاول مرة اخرى',
          style: TextStyle(
            fontSize: 32.0,
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),

        // 🔹 الصور
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
