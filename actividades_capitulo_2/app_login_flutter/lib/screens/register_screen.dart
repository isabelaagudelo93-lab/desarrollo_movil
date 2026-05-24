import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController =
      TextEditingController();

  final _authService = AuthService();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  bool _isLoading = false;
  String? _errorMessage;
  int _passwordStrength = 0;

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

    _animController.forward();

    _passwordController.addListener(
      _updatePasswordStrength,
    );
  }

  void _updatePasswordStrength() {
    final pwd = _passwordController.text;

    int strength = 0;

    if (pwd.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(pwd)) strength++;
    if (RegExp(r'[0-9]').hasMatch(pwd)) strength++;
    if (RegExp(r'[!@#\$&*~]').hasMatch(pwd)) strength++;

    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  void dispose() {
    _animController.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Color get _strengthColor {
    switch (_passwordStrength) {
      case 1:
        return AppTheme.error;

      case 2:
        return Colors.orange;

      case 3:
        return Colors.yellow;

      case 4:
        return AppTheme.success;

      default:
        return Colors.transparent;
    }
  }

  String get _strengthLabel {
    switch (_passwordStrength) {
      case 1:
        return 'Muy débil';

      case 2:
        return 'Débil';

      case 3:
        return 'Buena';

      case 4:
        return 'Fuerte ✓';

      default:
        return '';
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.registerUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      await Future.delayed(
        const Duration(milliseconds: 600),
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,

        PageRouteBuilder(
          pageBuilder: (_, a, b) =>
              HomeScreen(user: result['user']),

          transitionsBuilder:
              (_, anim, __, child) =>
                  FadeTransition(
            opacity: anim,
            child: child,
          ),

          transitionDuration:
              const Duration(milliseconds: 600),
        ),

        (route) => false,
      );
    } else {
      setState(() {
        _errorMessage = result['message'];
      });
    }
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
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 28,
                ),

                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        constraints.maxHeight,
                  ),

                  child: FadeTransition(
                    opacity: _fadeAnim,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const SizedBox(height: 24),

                        GestureDetector(
                          onTap: () =>
                              Navigator.pop(context),

                          child: Container(
                            padding:
                                const EdgeInsets.all(
                              10,
                            ),

                            decoration:
                                BoxDecoration(
                              color: AppTheme.cardBg,

                              borderRadius:
                                  BorderRadius
                                      .circular(12),

                              border: Border.all(
                                color: AppTheme
                                    .accent
                                    .withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),

                            child: const Icon(
                              Icons
                                  .arrow_back_ios_new_rounded,

                              color:
                                  AppTheme.textPrimary,

                              size: 18,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          'Crear cuenta',

                          style: TextStyle(
                            color:
                                AppTheme.textPrimary,

                            fontSize: 26,

                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'Completa el formulario para registrarte',

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
                                    _nameController,

                                label:
                                    'Nombre completo',

                                hint: 'Tu nombre',

                                prefixIcon:
                                    Icons
                                        .badge_outlined,

                                validator: (value) {
                                  if (value == null ||
                                      value
                                          .trim()
                                          .isEmpty) {
                                    return 'Ingresa tu nombre';
                                  }

                                  if (value
                                          .trim()
                                          .length <
                                      2) {
                                    return 'El nombre debe tener al menos 2 caracteres';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              CustomTextField(
                                controller:
                                    _emailController,

                                label:
                                    'Correo electrónico',

                                hint:
                                    'ejemplo@correo.com',

                                prefixIcon:
                                    Icons
                                        .email_outlined,

                                keyboardType:
                                    TextInputType
                                        .emailAddress,

                                validator: (value) {
                                  if (value == null ||
                                      value
                                          .trim()
                                          .isEmpty) {
                                    return 'Ingresa tu correo';
                                  }

                                  if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(
                                    value.trim(),
                                  )) {
                                    return 'Correo electrónico inválido';
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
                                    'Mínimo 6 caracteres',

                                prefixIcon:
                                    Icons
                                        .lock_outline,

                                isPassword: true,

                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Ingresa una contraseña';
                                  }

                                  if (value.length <
                                      6) {
                                    return 'La contraseña debe tener al menos 6 caracteres';
                                  }

                                  return null;
                                },
                              ),

                              if (_passwordController
                                  .text
                                  .isNotEmpty) ...[
                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    ...List.generate(
                                      4,
                                      (i) {
                                        return Expanded(
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(
                                              right:
                                                  i < 3
                                                      ? 4
                                                      : 0,
                                            ),

                                            height: 4,

                                            decoration:
                                                BoxDecoration(
                                              color:
                                                  i <
                                                          _passwordStrength
                                                      ? _strengthColor
                                                      : AppTheme
                                                          .accent
                                                          .withValues(
                                                          alpha:
                                                              0.3,
                                                        ),

                                              borderRadius:
                                                  BorderRadius.circular(
                                                2,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      _strengthLabel,

                                      style:
                                          TextStyle(
                                        color:
                                            _strengthColor,

                                        fontSize:
                                            11,

                                        fontWeight:
                                            FontWeight
                                                .w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],

                              const SizedBox(height: 16),

                              CustomTextField(
                                controller:
                                    _confirmPasswordController,

                                label:
                                    'Confirmar contraseña',

                                hint:
                                    'Repite la contraseña',

                                prefixIcon:
                                    Icons
                                        .lock_person_outlined,

                                isPassword: true,

                                textInputAction:
                                    TextInputAction
                                        .done,

                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Confirma tu contraseña';
                                  }

                                  if (value !=
                                      _passwordController
                                          .text) {
                                    return 'Las contraseñas no coinciden';
                                  }

                                  return null;
                                },
                              ),

                              if (_confirmPasswordController
                                      .text
                                      .isNotEmpty &&
                                  _passwordController
                                      .text
                                      .isNotEmpty) ...[
                                const SizedBox(
                                  height: 8,
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      _confirmPasswordController
                                                  .text ==
                                              _passwordController
                                                  .text
                                          ? Icons
                                              .check_circle_outline
                                          : Icons
                                              .cancel_outlined,

                                      size: 14,

                                      color:
                                          _confirmPasswordController
                                                      .text ==
                                                  _passwordController
                                                      .text
                                              ? AppTheme
                                                  .success
                                              : AppTheme
                                                  .error,
                                    ),

                                    const SizedBox(
                                      width: 6,
                                    ),

                                    Text(
                                      _confirmPasswordController
                                                  .text ==
                                              _passwordController
                                                  .text
                                          ? 'Las contraseñas coinciden'
                                          : 'Las contraseñas no coinciden',

                                      style:
                                          TextStyle(
                                        fontSize:
                                            12,

                                        color:
                                            _confirmPasswordController
                                                        .text ==
                                                    _passwordController
                                                        .text
                                                ? AppTheme
                                                    .success
                                                : AppTheme
                                                    .error,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        if (_errorMessage != null) ...[
                          const SizedBox(height: 16),

                          Container(
                            padding:
                                const EdgeInsets.all(
                              14,
                            ),

                            decoration:
                                BoxDecoration(
                              color: AppTheme.error
                                  .withValues(
                                alpha: 0.1,
                              ),

                              borderRadius:
                                  BorderRadius
                                      .circular(12),

                              border: Border.all(
                                color: AppTheme
                                    .error
                                    .withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),

                            child: Row(
                              children: [
                                const Icon(
                                  Icons
                                      .error_outline,

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
                                          AppTheme
                                              .error,

                                      fontSize:
                                          13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 28),

                        LoadingButton(
                          onPressed:
                              _handleRegister,

                          label:
                              'Crear Cuenta',

                          isLoading:
                              _isLoading,

                          icon: Icons
                              .how_to_reg_rounded,
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: TextButton(
                            onPressed: () =>
                                Navigator.pop(
                              context,
                            ),

                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 13,
                                ),

                                children: [
                                  TextSpan(
                                    text:
                                        '¿Ya tienes cuenta? ',

                                    style:
                                        TextStyle(
                                      color: AppTheme
                                          .textSecondary,
                                    ),
                                  ),

                                  TextSpan(
                                    text:
                                        'Inicia sesión',

                                    style:
                                        TextStyle(
                                      color: AppTheme
                                          .highlight,

                                      fontWeight:
                                          FontWeight
                                              .w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
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