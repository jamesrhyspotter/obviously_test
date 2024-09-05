import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum LoadingType { circle, dots }

enum LoadingSize { small, regular }

class LoadingWidget extends StatefulWidget {
  final String? label;
  final LoadingType loadingType;
  final bool fadeIn;
  final LoadingSize loadingSize;
  final Color? color; 
  const LoadingWidget(
      {super.key,
      this.label,
      this.loadingType = LoadingType.circle,
      this.fadeIn = false,
      this.loadingSize = LoadingSize.regular,  this.color});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    setState(() {
      opacity = widget.fadeIn ? 0 : 1;
    });

    opacity == 0 ? animate() : null;
  }

  animate() async {
    while (true && mounted) {
      double newOpacity = opacity += 0.1;

      if (opacity > 1) {
        break;
      } else {
        setState(() {
          opacity = newOpacity;
        });
      }

      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.loadingType == LoadingType.circle
              ? LoadingAnimationWidget.threeArchedCircle(
                  color: widget.color ?? Theme.of(context).primaryColor,
                  size: widget.loadingSize == LoadingSize.regular ? 40 : 20,
                )
              : LoadingAnimationWidget.prograssiveDots(
                  color: widget.color ?? Theme.of(context).primaryColor,
                  size: widget.loadingSize == LoadingSize.regular ? 40 : 20,
                ),
          const SizedBox(
            height: 20,
          ),
          if (widget.label != null)
            Text(
              widget.label!,
              style: widget.loadingSize == LoadingSize.regular
                  ? Theme.of(context).textTheme.displayMedium
                  : Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }
}
