import 'package:checkmark/checkmark.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:obviously_test_final/app/widgets/double_button_column.dart';
import 'package:obviously_test_final/app/widgets/loading_widget.dart';

class ConfirmationScreen extends StatefulWidget {
  final String? title;
  final String? message;
  final String? confirmationTitle;
  final String? confirmationMessage;
  final String? onTapText;
  final Function? onTap;
  final Widget icon;
  final Widget? centerWidget;
  final bool bypassFirstScreen;
  final String loadingString; 
  final bool showActionButtons; 
  const ConfirmationScreen(
      {super.key,
      this.title,
      this.message = '',
      this.confirmationMessage,
      this.confirmationTitle,
      this.onTap,
      this.onTapText,
      required this.icon,
      this.centerWidget,
      this.bypassFirstScreen = false,this.loadingString = 'Loading...', this.showActionButtons = true});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool checked = false;
  bool animating = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    widget.bypassFirstScreen ? showNotification() : null;
  }

  showNotification() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = false;
    });
    setState(() {
      animating = true;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      checked = true;
    });
    await Future.delayed(const Duration(milliseconds: 2000));
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.primaryColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading
                              ?  LoadingWidget(label: widget.loadingString, color: Colors.white,)
                              : animating
                                  ? SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CheckMark(
                                        active: checked,
                                        curve: Curves.decelerate,
                                        activeColor:
                                            Colors.white,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                    )
                                  : widget.icon,
                          const SizedBox(
                            height: 40,
                          ),
                          if (!isLoading)
                            animating
                                ? DelayedDisplay(
                                    delay: const Duration(milliseconds: 200),
                                    child: Text(
                                      widget.confirmationTitle ?? '',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  )
                                : DelayedDisplay(
                                    delay: const Duration(milliseconds: 200),
                                    child: Text(
                                      widget.title ?? '',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (!isLoading)
                            animating
                                ? DelayedDisplay(
                                    delay: const Duration(milliseconds: 200),
                                    child: Text(
                                      widget.confirmationMessage ?? '',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  )
                                : DelayedDisplay(
                                    delay: const Duration(milliseconds: 400),
                                    child: widget.centerWidget ??
                                        Text(
                                          widget.message ?? '',
                                          style: theme.textTheme.displayMedium,
                                          
                                          textAlign: TextAlign.center,
                                        ),
                                  ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if(widget.showActionButtons)
            Positioned(
                bottom: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: animating ? 0 : 1,
                  child: DoubleButtonColumn(
                    titleOne: widget.onTapText ?? '',
                    titleTwo: 'Cancel',
                    onTapOne: () => showNotification(),
                    onTapTwo: () => Navigator.of(context).pop(),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
