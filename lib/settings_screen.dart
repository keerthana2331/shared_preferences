import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String username;
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;

  SettingsScreen({
    required this.username,
    required this.isDarkTheme,
    required this.onThemeChanged,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _enableNotifications = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: widget.isDarkTheme ? Colors.black87 : Colors.blue,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isDarkTheme
                  ? [Colors.black87, Colors.grey[900]!]
                  : [Colors.blue[100]!, Colors.blue[300]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${widget.username}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Enable Notifications',
                  style: TextStyle(
                    color: widget.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                value: _enableNotifications,
                onChanged: (value) {
                  setState(() {
                    _enableNotifications = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: widget.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                value: widget.isDarkTheme,
                onChanged: (value) {
                  widget.onThemeChanged(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
