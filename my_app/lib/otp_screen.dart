import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  int secondsRemaining = 30;
  late final ticker;
  bool codeSent = false;

  @override
  void initState() {
    super.initState();
    ticker = Ticker(_tick);
    ticker.start();
  }

  void _tick(Duration elapsed) {
    if (mounted) {
      setState(() {
        secondsRemaining = 30 - elapsed.inSeconds;
        if (secondsRemaining <= 0) {
          ticker.stop();
          secondsRemaining = 0;
        }
      });
    }
  }

  void verifyOtp() {
    // Accept any OTP for demonstration
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
                    final phone = args != null && args['phone'] != null ? args['phone'] : 'your mobile number';
                    return Text('An SMS was sent to $phone', style: TextStyle(fontSize: 18));
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: otpController,
                  decoration: InputDecoration(labelText: 'Enter OTP'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Text('Resend code: 00:${secondsRemaining.toString().padLeft(2, '0')}', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: verifyOtp,
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ticker {
  final void Function(Duration) onTick;
  late final Stopwatch _stopwatch;
  late final Duration _interval;
  bool _isActive = false;

  Ticker(this.onTick, [this._interval = const Duration(seconds: 1)]) {
    _stopwatch = Stopwatch();
  }

  void start() {
    _isActive = true;
    _stopwatch.start();
    _tick();
  }

  void _tick() async {
    while (_isActive && _stopwatch.isRunning) {
      await Future.delayed(_interval);
      onTick(_stopwatch.elapsed);
    }
  }

  void stop() {
    _isActive = false;
    _stopwatch.stop();
  }

  void dispose() {
    stop();
  }
}
