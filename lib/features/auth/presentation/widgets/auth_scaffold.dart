import 'package:flutter/material.dart';


import 'glass_card.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage(
              'assets/images/f6923f44afe94daecc0c3738c559bc98c6522974 (1).jpg',
            ),
            fit: BoxFit.fitHeight,
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GlassCard(child: child),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
