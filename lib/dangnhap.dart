import 'package:flutter/material.dart';
import 'main.dart'; // Import màn hình chính (MovieScreen)

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void navigateToMovies(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MovieScreen()), // Chuyển sang màn hình chính
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            // Tránh lỗi tràn màn hình
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? 'Đăng Nhập' : 'Đăng Ký',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Tài khoản',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    if (!isLogin) ...[
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                      ),
                    ],
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => navigateToMovies(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      ),
                      child: Text(isLogin ? 'Đăng Nhập' : 'Đăng Ký'),
                    ),
                    TextButton(
                      onPressed: toggleAuthMode,
                      child: Text(
                        isLogin
                            ? 'Chưa có tài khoản? Đăng ký ngay'
                            : 'Đã có tài khoản? Đăng nhập',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
