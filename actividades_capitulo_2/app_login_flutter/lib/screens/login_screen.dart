import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      _showSnackBar(
        result['message'],
        isError: false,
      );

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, a, b) =>
              HomeScreen(user: result['user']),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(
            opacity: anim,
            child: child,
          ),
          transitionDuration:
              const Duration(milliseconds: 600),
        ),
      );
    } else {
      setState(() {
        _errorMessage = result['message'];
      });
    }
  }

  void _showSnackBar(
    String message, {
    required bool isError,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? AppTheme.error : AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: GradientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                ),

                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),

                  child: FadeTransition(
                    opacity: _fadeAnim,

                    child: SlideTransition(
                      position: _slideAnim,

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const SizedBox(height: 60),

                          const Center(
                            child: AppLogo(),
                          ),

                          const SizedBox(height: 48),

                          const Text(
                            'Bienvenido de nuevo',

                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            'Inicia sesión para continuar',

                            style: TextStyle(
                              color:
                                  AppTheme.textSecondary,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 36),

                          Form(
                            key: _formKey,

                            child: Column(
                              children: [
                                CustomTextField(
                                  controller:
                                      _emailController,

                                  label:
                                      'Correo electrónico',

                                  hint:
                                      'ejemplo@correo.com',

                                  prefixIcon:
                                      Icons.email_outlined,

                                  keyboardType:
                                      TextInputType
                                          .emailAddress,

                                  validator: (value) {
                                    if (value == null ||
                                        value
                                            .trim()
                                            .isEmpty) {
                                      return 'Ingresa tu correo electrónico';
                                    }

                                    if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    ).hasMatch(
                                      value.trim(),
                                    )) {
                                      return 'Ingresa un correo válido';
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                CustomTextField(
                                  controller:
                                      _passwordController,

                                  label: 'Contraseña',

                                  hint:
                                      'Tu contraseña',

                                  prefixIcon:
                                      Icons.lock_outline,

                                  isPassword: true,

                                  textInputAction:
                                      TextInputAction
                                          .done,

                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'Ingresa tu contraseña';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),

                          if (_errorMessage != null) ...[
                            const SizedBox(height: 16),

                            Container(
                              padding:
                                  const EdgeInsets.all(14),

                              decoration: BoxDecoration(
                                color: AppTheme.error
                                    .withValues(
                                  alpha: 0.1,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),

                                border: Border.all(
                                  color: AppTheme.error
                                      .withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),

                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color:
                                        AppTheme.error,
                                    size: 18,
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      _errorMessage!,

                                      style:
                                          const TextStyle(
                                        color:
                                            AppTheme.error,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 28),

                          LoadingButton(
                            onPressed: _handleLogin,
                            label: 'Iniciar Sesión',
                            isLoading: _isLoading,
                            icon:
                                Icons.login_rounded,
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppTheme
                                      .textSecondary
                                      .withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 16,
                                ),

                                child: Text(
                                  '¿No tienes cuenta?',

                                  style: TextStyle(
                                    color: AppTheme
                                        .textSecondary
                                        .withValues(
                                      alpha: 0.7,
                                    ),

                                    fontSize: 12,
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Divider(
                                  color: AppTheme
                                      .textSecondary
                                      .withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },

                            style:
                                OutlinedButton.styleFrom(
                              minimumSize:
                                  const Size(
                                double.infinity,
                                54,
                              ),

                              side: BorderSide(
                                color: AppTheme
                                    .highlight
                                    .withValues(
                                  alpha: 0.5,
                                ),
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  14,
                                ),
                              ),

                              foregroundColor:
                                  AppTheme.highlight,
                            ),

                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                              children: [
                                Icon(
                                  Icons
                                      .person_add_outlined,
                                  size: 20,
                                ),

                                SizedBox(width: 8),

                                Text(
                                  'Crear una cuenta',

                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}