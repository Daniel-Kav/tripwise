import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  final _formKey = GlobalKey<FormState>();
  String _otpCode = '';
  int _resendSeconds = 30;
  bool _isResendActive = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_resendSeconds > 0) {
            _resendSeconds--;
            _startResendTimer();
          } else {
            _isResendActive = true;
          }
        });
      }
    });
  }

  void _resendCode() {
    if (_isResendActive) {
      // In a real app, you would resend the OTP code here
      setState(() {
        _resendSeconds = 30;
        _isResendActive = false;
      });
      _startResendTimer();
      
      // Clear all fields
      for (var controller in _otpControllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP code resent successfully'),
        ),
      );
    }
  }

  void _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      _otpCode = _otpControllers.map((controller) => controller.text).join();
      
      // In a real app, you would verify the OTP code here
      // For now, we'll just navigate to the home screen
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/signup'),
        ),
        title: Text(
          'OTP Verification',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                
                // OTP Verification Message
                Text(
                  'An OTP has been sent to your mobile number',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  '+254 7XX-XXXX',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0D47A1), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Resend Code Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resend code: ',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: _isResendActive ? _resendCode : null,
                      child: Text(
                        _isResendActive ? 'Resend now' : '00:${_resendSeconds.toString().padLeft(2, '0')}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _isResendActive ? const Color(0xFF0D47A1) : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Verify Button
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6200EE), // Purple color from UI
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
