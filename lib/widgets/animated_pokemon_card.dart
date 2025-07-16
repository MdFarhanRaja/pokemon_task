import 'package:flutter/material.dart';
import '../models/pokemon_list_response.dart';
import '../screens/pokemon_card_view.dart';

class AnimatedPokemonCard extends StatefulWidget {
  final Data pokemon;
  final int index;

  const AnimatedPokemonCard({
    Key? key,
    required this.pokemon,
    required this.index,
  }) : super(key: key);

  @override
  State<AnimatedPokemonCard> createState() => _AnimatedPokemonCardState();
}

class _AnimatedPokemonCardState extends State<AnimatedPokemonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 20 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutQuad,
                  transform:
                      Matrix4.identity()
                        ..scale(_isHovering ? 1.03 : 1.0)
                        ..translate(
                          _isHovering ? 0.0 : 0.0,
                          _isHovering ? -2.0 : 0.0,
                        ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          _isHovering ? 0.2 : 0.1,
                        ),
                        blurRadius: _isHovering ? 8.0 : 4.0,
                        offset: Offset(0, _isHovering ? 4.0 : 2.0),
                        spreadRadius: _isHovering ? 2.0 : 0.0,
                      ),
                    ],
                  ),
                  child: PokemonCardView(pokemon: widget.pokemon),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
