import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/session_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var username = ''.obs;
  var isLoading = true.obs;

  static const String _nimPassword = '123230180';

  @override
  void onInit() {
    super.onInit();
    _checkSession();
  }

  Future<void> _checkSession() async {
    isLoading.value = true;
    final savedUsername = await SessionService.getSession();
    if (savedUsername != null && savedUsername.isNotEmpty) {
      username.value = savedUsername;
      isLoggedIn.value = true;
    }
    isLoading.value = false;
  }

  Future<bool> login(String user, String password) async {
    if (user.trim().isEmpty) {
      return false;
    }
    if (password != _nimPassword) {
      Get.snackbar(
        'Login Gagal',
        'Password salah! Gunakan NIM sebagai password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        icon: const Icon(Icons.lock_outline, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
      return false;
    }
    await SessionService.saveSession(user.trim());
    username.value = user.trim();
    isLoggedIn.value = true;
    return true;
  }

  Future<void> logout() async {
    await SessionService.clearSession();
    username.value = '';
    isLoggedIn.value = false;
  }
}
