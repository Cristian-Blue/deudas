import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final double height;

  const HeaderWidget(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          _buildShape(
            width: width,
            height: height,
            offsets: [
              Offset(width * 0.2, height),
              Offset(width * 0.5, height - 60),
              Offset(width * 0.8, height + 20),
              Offset(width, height - 18),
            ],
            gradientColors: [
              primaryColor.withValues().withAlpha(80),
              secondaryColor.withValues().withAlpha(80),
            ],
          ),
          _buildShape(
            width: width,
            height: height,
            offsets: [
              Offset(width / 3, height + 20),
              Offset(width * 0.8, height - 60),
              Offset(width * 0.8, height - 60),
              Offset(width, height - 20),
            ],
            gradientColors: [
              primaryColor.withValues().withAlpha(40),
              secondaryColor.withValues().withAlpha(40),
            ],
          ),
          _buildShape(
            width: width,
            height: height,
            offsets: [
              Offset(width * 0.2, height),
              Offset(width * 0.5, height - 40),
              Offset(width * 0.8, height - 80),
              Offset(width, height - 20),
            ],
            solidColor: secondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildShape({
    required double width,
    required double height,
    required List<Offset> offsets,
    List<Color>? gradientColors,
    Color? solidColor,
  }) {
    return ClipPath(
      clipper: ShapeClipper(offsets),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors,
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )
              : null,
          color: solidColor,
        ),
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  final List<Offset> _offsets;
  const ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(
      _offsets[0].dx,
      _offsets[0].dy,
      _offsets[1].dx,
      _offsets[1].dy,
    );
    path.quadraticBezierTo(
      _offsets[2].dx,
      _offsets[2].dy,
      _offsets[3].dx,
      _offsets[3].dy,
    );

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant ShapeClipper oldClipper) {
    // Re-recorta solo si los offsets han cambiado.
    return oldClipper._offsets != _offsets;
  }
}
