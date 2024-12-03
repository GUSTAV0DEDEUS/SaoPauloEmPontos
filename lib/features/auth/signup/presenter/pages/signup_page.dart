import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/components/button_submit.dart';
import 'package:sp_pontos/core/components/text_app.dart';
import 'package:sp_pontos/core/components/text_field_form.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/core/styles/app_font_size.dart';
import 'package:sp_pontos/core/utils/constant/validators.dart';
import 'package:sp_pontos/features/auth/signup/presenter/state/auth_signup_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final authState = context.read<AuthSignupState>();
      await authState.register(_emailController.text, _passwordController.text,
          _displayNameController.text);
      if (authState.errorMessage != null) {
        if (!mounted) return; // Ensure context is still valid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(authState.errorMessage ?? 'Erro desconhecido')),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Parabéns, conta criada com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthSignupState>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TextApp(
                      label: 'Criar Conta',
                      fontSize: AppFontSize.xxxLarge,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    const SizedBox(height: 10),
                    const TextApp(
                      label:
                          'Por favor, preencha os campos abaixo para criar sua conta.',
                      color: AppColors.gray,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'exemplo@gmail.com',
                      validator: emailValidator,
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                      controller: _displayNameController,
                      labelText: 'Nome do Usuário',
                      hintText: 'user',
                      validator: displayNameValidator,
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                      controller: _passwordController,
                      labelText: 'Senha',
                      hintText: 'Sua senha',
                      obscureText: true,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                      controller: _confirmPasswordController,
                      labelText: 'Confirme sua senha',
                      hintText: 'Sua senha',
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    ButtonSubmitForm(
                      label: 'Registrar',
                      function: () => _register(context),
                      isLoading: authState.isLoading,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: const TextApp(
                label: 'Já tem uma conta? Faça login!',
                color: AppColors.black,
                fontSize: AppFontSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
