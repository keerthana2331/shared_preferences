// ignore_for_file: use_super_parameters, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkTheme,
    required this.onThemeChanged,
    required String username,
    required Null Function(dynamic String) onUsernameChanged,
  }) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool enableNotifications = false;
  TextEditingController usernameController = TextEditingController();
  String username = '';

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      usernameController.text = username;
    });
  }

  saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            widget.isDarkTheme ? Colors.purpleAccent : Colors.tealAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isDarkTheme
                ? [Color(0xFF121212), Colors.deepPurple[900]!]
                : [Colors.lightBlue[50]!, Colors.teal[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    buildUsernameSection(),
                    buildSettingOption(
                      title: 'Notifications',
                      subtitle: 'Receive app updates and alerts',
                      icon: Icons.notifications_active_rounded,
                      value: enableNotifications,
                      onChanged: (value) =>
                          setState(() => enableNotifications = value),
                    ),
                    buildSettingOption(
                      title: 'Dark Mode',
                      subtitle: 'Switch between light and dark themes',
                      icon: Icons.dark_mode_rounded,
                      value: widget.isDarkTheme,
                      onChanged: (value) => widget.onThemeChanged(value),
                    ),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: widget.isDarkTheme
                    ? Colors.purpleAccent.withOpacity(0.2)
                    : Colors.tealAccent.withOpacity(0.2),
                child: Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: widget.isDarkTheme
                      ? Colors.purpleAccent
                      : Colors.tealAccent,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Customize your experience',
            style: TextStyle(
              fontSize: 14,
              color: widget.isDarkTheme ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUsernameSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: widget.isDarkTheme
            ? Color(0xFF1E1E1E)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: widget.isDarkTheme
                ? Colors.black.withOpacity(0.7)
                : Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(
            color: widget.isDarkTheme ? Colors.white : Colors.black87,
          ),
          prefixIcon: Icon(
            Icons.person_rounded,
            color: widget.isDarkTheme ? Colors.purpleAccent : Colors.tealAccent,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: widget.isDarkTheme
              ? Color(0xFF1E1E1E)
              : Colors.white.withOpacity(0.8),
        ),
        style: TextStyle(
          color: widget.isDarkTheme ? Colors.white : Colors.black87,
        ),
        onChanged: (value) {
          setState(() {
            username = value;
          });
        },
      ),
    );
  }

  Widget buildSettingOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: widget.isDarkTheme
            ? Color(0xFF1E1E1E)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: widget.isDarkTheme
                ? Colors.black.withOpacity(0.7)
                : Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: widget.isDarkTheme ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: widget.isDarkTheme ? Colors.white70 : Colors.black54,
          ),
        ),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: value
                ? (widget.isDarkTheme
                    ? Colors.purpleAccent.withOpacity(0.2)
                    : Colors.tealAccent.withOpacity(0.2))
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: value
                ? (widget.isDarkTheme
                    ? Colors.purpleAccent
                    : const Color.fromARGB(255, 8, 229, 178))
                : Colors.grey,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor:
            widget.isDarkTheme ? Colors.purpleAccent : Colors.tealAccent,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: () {
          saveUsername(username);
          showSnackbar('Username saved successfully!');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isDarkTheme
              ? Colors.purpleAccent
              : const Color.fromARGB(255, 39, 38, 38),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'Save Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
