import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyStopwatchApp());
}

class MyStopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Timer? _timer; // The timer that updates the stopwatch
  int _elapsedMilliseconds = 0; // Total elapsed time in milliseconds
  bool _isRunning = false; // Whether the stopwatch is running

  // Format time as minutes, seconds, and milliseconds
  String _formatTime(int milliseconds) {
    final minutes = milliseconds ~/ (1000 * 60);
    final seconds = (milliseconds ~/ 1000) % 60;
    final millis = milliseconds % 1000;
    return '${_padZero(minutes)}:${_padZero(seconds)}:${_padZero(millis, 3)}';
  }

  // Helper function to pad numbers with zeroes
  String _padZero(int number, [int length = 2]) {
    return number.toString().padLeft(length, '0');
  }

  // Start the stopwatch
  void _startStopwatch() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedMilliseconds += 10;
      });
    });
  }

  // Pause the stopwatch
  void _pauseStopwatch() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  // Reset the stopwatch
  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _elapsedMilliseconds = 0;
    });
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the formatted time
            Text(
              _formatTime(_elapsedMilliseconds),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Buttons for start, pause, and reset
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startStopwatch,
                  child: Text('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 175, 255, 178), // Add a color for each button
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning ? _pauseStopwatch : null,
                  child: Text('Pause'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 237, 190, 129), // Add a color for each button
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 131, 124), // Add a color for each button
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
