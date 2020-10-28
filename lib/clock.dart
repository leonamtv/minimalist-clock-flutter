import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  final format = new NumberFormat("00");

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) { 
      setState(() { });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 50),
          child: Text(
            format.format(now.hour).toString()   + ":" +  
            format.format(now.minute).toString() + ":" + 
            format.format(now.second).toString(),
            style: TextStyle(
              letterSpacing: 10,
              fontStyle: FontStyle.italic,
              color: Color(0xff3794e6),
              fontSize: 40,
            )
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 5 * 4,
          height: MediaQuery.of(context).size.width / 5 * 4,
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              painter: Painter ()
            ),
          ),
        ),
      ],
    );
  }
}


class Painter extends CustomPainter {

  DateTime dateTime = DateTime.now();

  Color mainColor = Color(0xff3794e6);

  double offset = 15;

  @override
  void paint(Canvas canvas, Size size) {

      double centerX = size.width   / 2;
      double centerY = size.height  / 2;
      double radius  = min(centerX, centerY);

      Offset center  = Offset(centerX, centerY);

      Paint externOutlineBrush = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = mainColor;
      
      Paint outlineBrush = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = mainColor;

      Paint centerFillBrush = Paint()
        ..color = mainColor;

      Paint secondBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = mainColor;

      Paint minuteBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = mainColor;

      Paint hourBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = mainColor;

      Paint dashBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = mainColor;

      double secondRadius = 4 * radius / 5;
      double minuteRadius = 3 * radius / 5;
      double hourRadius   = 2.5 * radius / 5;

      double secondX = centerX + ( secondRadius * cos(dateTime.second * 6 * pi / 180 ));
      double secondY = centerY + ( secondRadius * sin(dateTime.second * 6 * pi / 180 ));

      double minuteX = centerX + ( minuteRadius * cos(dateTime.minute * 6 * pi / 180 ));
      double minuteY = centerY + ( minuteRadius * sin(dateTime.minute * 6 * pi / 180 ));

      double hourX   = centerX + ( hourRadius   * cos(( dateTime.hour * 30 + dateTime.minute * 0.5 ) * pi / 180 ));
      double hourY   = centerY + ( hourRadius   * sin(( dateTime.hour * 30 + dateTime.minute * 0.5 ) * pi / 180 ));

      canvas.drawCircle(center, radius - offset, outlineBrush);
      canvas.drawCircle(center, radius, externOutlineBrush);

      canvas.drawLine(center, Offset(secondX, secondY), secondBrush);
      canvas.drawLine(center, Offset(minuteX, minuteY), minuteBrush);
      canvas.drawLine(center, Offset(hourX, hourY), hourBrush);

      canvas.drawCircle(center, 5, centerFillBrush);

      double outerCircleRadius      = radius;
      double bigInnerCircleRadius   = radius - 8;
      double smallInnerCircleRadius = radius - 25;

      for ( double i = 0; i < 360; i += 6 ) {
        double x1 = centerX + outerCircleRadius * cos ( i * pi / 180 );
        double y1 = centerY + outerCircleRadius * sin ( i * pi / 180 );


        if ( i % 15 == 0 ) {
          double x2 = centerX + smallInnerCircleRadius * cos ( i * pi / 180 );
          double y2 = centerY + smallInnerCircleRadius * sin ( i * pi / 180 );
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
        } else {
          double x2 = centerX + bigInnerCircleRadius * cos ( i * pi / 180 );
          double y2 = centerY + bigInnerCircleRadius * sin ( i * pi / 180 );
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
        }

      }

  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
