import 'package:flutter/material.dart';
import 'create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // Password visibility
  bool isPasswordVisible = false;

  // Whether OTP section is visible
  bool showOtp = false;

  @override
  void dispose() {
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    otpController.dispose();

    super.dispose();
  }

  // Login button
  void loginUser() {
    final email = emailController.text.trim();
    final mobile = mobileController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty && mobile.isEmpty) {
      showMessage('Please enter Email or Mobile Number');
      return;
    }

    if (password.isEmpty) {
      showMessage('Please enter Password');
      return;
    }

    // TODO:
    // Later this will call your Spring Boot login API.
    //
    // Example:
    // POST /api/auth/login

    showMessage('Login button clicked');
  }

  // Show OTP section
  void showOtpLogin() {
    setState(() {
      showOtp = true;
    });
  }

  // Verify OTP
  void verifyOtp() {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      showMessage('Please enter OTP');
      return;
    }

    // TODO:
    // Later connect this to Spring Boot OTP API.

    showMessage('OTP verification clicked');
  }

  // Create account
  void createAccount() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CreateAccountPage(),
    ),
  );
}

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --------------------------------
                  // LOGO
                  // --------------------------------
                  _buildLogo(),

                  const SizedBox(height: 35),

                  // --------------------------------
                  // TITLE
                  // --------------------------------
                  const Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to manage your farm expenses',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),

                  const SizedBox(height: 35),

                  // --------------------------------
                  // EMAIL
                  // --------------------------------
                  _buildTextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // --------------------------------
                  // MOBILE
                  // --------------------------------
                  _buildTextField(
                    controller: mobileController,
                    label: 'Mobile No.',
                    hint: 'Enter your mobile number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 16),

                  // --------------------------------
                  // PASSWORD
                  // --------------------------------
                  _buildTextField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    obscureText: !isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 22),

                  // --------------------------------
                  // LOGIN BUTTON
                  // --------------------------------
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: loginUser,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --------------------------------
                  // OTP LOGIN
                  // --------------------------------
                  OutlinedButton.icon(
                    onPressed: showOtpLogin,
                    icon: const Icon(Icons.sms_outlined),
                    label: const Text('Login with OTP'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  // --------------------------------
                  // OTP SECTION
                  // --------------------------------
                  if (showOtp) ...[
                    const SizedBox(height: 22),

                    _buildTextField(
                      controller: otpController,
                      label: 'OTP',
                      hint: 'Enter OTP',
                      icon: Icons.password_outlined,
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: verifyOtp,
                        child: const Text(
                          'Verify OTP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // --------------------------------
                  // CREATE ACCOUNT
                  // --------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),

                      TextButton(
                        onPressed: createAccount,
                        child: const Text(
                          'Create',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------
  // LOGO WIDGET
  // --------------------------------
  Widget _buildLogo() {
    return Center(
      child: Container(
        height: 90,
        width: 90,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.green.shade50,
        ),

        child: Icon(Icons.agriculture, size: 50, color: Colors.green.shade700),
      ),
    );
  }

  // --------------------------------
  // TEXT FIELD WIDGET
  // --------------------------------
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
        ),
      ),
    );
  }
}
