import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Timers extends StatefulWidget {
  const Timers({super.key});

  @override
  State<Timers> createState() => _TimersState();
}

class _TimersState extends State<Timers> {
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 30, 71),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(189, 3, 10, 47),
        centerTitle: true,
        title: const Text(
          'Animated Clock',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                size: const Size(300, 300),
                painter: ClockPainter(currentTime),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime currentTime;

  ClockPainter(this.currentTime);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..color = const Color.fromARGB(153, 182, 181, 186)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(centerX, centerY),
      100,
      paint,
    );

    final hourPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final minutePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final secondPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final hourHandX = centerX +
        50 * cos((currentTime.hour % 12 + currentTime.minute / 60) * 30 * pi / 180);
    final hourHandY = centerY +
        50 * sin((currentTime.hour % 12 + currentTime.minute / 60) * 30 * pi / 180);
    canvas.drawLine(
        Offset(centerX, centerY), Offset(hourHandX, hourHandY), hourPaint);

    final minuteHandX = centerX + 70 * cos(currentTime.minute * 6 * pi / 180);
    final minuteHandY = centerY + 70 * sin(currentTime.minute * 6 * pi / 180);
    canvas.drawLine(Offset(centerX, centerY), Offset(minuteHandX, minuteHandY),
        minutePaint);

    final secondHandX = centerX + 90 * cos(currentTime.second * 6 * pi / 180);
    final secondHandY = centerY + 90 * sin(currentTime.second * 6 * pi / 180);
    canvas.drawLine(Offset(centerX, centerY), Offset(secondHandX, secondHandY),
        secondPaint);

    final centerPointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), 5, centerPointPaint);

    final markerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final double angle = (i * 30) * pi / 180;
      final double outerX = centerX + 90 * cos(angle);
      final double outerY = centerY + 90 * sin(angle);
      final double innerX = centerX + 80 * cos(angle);
      final double innerY = centerY + 80 * sin(angle);
      canvas.drawLine(Offset(outerX, outerY), Offset(innerX, innerY), markerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
