import 'package:flutter/material.dart';

import 'widgets.dart';

const _airplaneSize = 30.0;
const _dotSize = 18.0;
const _cardAnimationDuration = 100;

class FlightTimeLine extends StatefulWidget {
  const FlightTimeLine({super.key});

  @override
  State<FlightTimeLine> createState() => _FlightTimeLineState();
}

class _FlightTimeLineState extends State<FlightTimeLine> {
  bool animated = false;
  bool animatedCards = false;
  bool animatedButton = false;

  void initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animatedCards = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animatedButton = true;
    });
  }

  onRoutesPressed() {
    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_, animation1, __) {
        return FadeTransition(
          opacity: animation1,
          child: const FlightRoutes(),
        );
      }),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerDot = constraints.maxWidth / 2 - _airplaneSize;
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: centerDot,
              top: animated
                  ? 20.0
                  : constraints.maxHeight - _airplaneSize - 10.0,
              bottom: 0.0,
              child: const AircraftAndLine(),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              left: centerDot,
              top: animated ? 80.0 : constraints.maxHeight,
              child: TimeLineDot(
                selected: true,
                displayCard: animatedCards,
                delay: const Duration(milliseconds: _cardAnimationDuration),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              right: centerDot,
              top: animated ? 140.0 : constraints.maxHeight,
              child: TimeLineDot(
                left: true,
                displayCard: animatedCards,
                delay: const Duration(milliseconds: _cardAnimationDuration * 2),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              left: centerDot,
              top: animated ? 200.0 : constraints.maxHeight,
              child: TimeLineDot(
                displayCard: animatedCards,
                delay: const Duration(milliseconds: _cardAnimationDuration * 3),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1200),
              right: centerDot,
              top: animated ? 260.0 : constraints.maxHeight,
              child: TimeLineDot(
                selected: true,
                left: true,
                displayCard: animatedCards,
                delay: const Duration(milliseconds: _cardAnimationDuration * 4),
              ),
            ),
            if (animated)
              Align(
                alignment: Alignment.bottomLeft,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: onRoutesPressed,
                    child: const Icon(Icons.check),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class AircraftAndLine extends StatelessWidget {
  const AircraftAndLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: [
          const Icon(
            Icons.flight,
            color: Colors.red,
            size: _airplaneSize,
          ),
          Expanded(
            child: Container(
              width: 5.0,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeLineDot extends StatefulWidget {
  const TimeLineDot({
    super.key,
    this.selected = false,
    this.displayCard = false,
    this.left = false,
    required this.delay,
  });

  final bool selected;
  final bool displayCard;
  final bool left;
  final Duration delay;

  @override
  State<TimeLineDot> createState() => _TimeLineDotState();
}

class _TimeLineDotState extends State<TimeLineDot> {
  bool animated = false;

  void animatedWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimeLineDot oldWidget) {
    animatedWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget buildCard() => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: _cardAnimationDuration),
        builder: (context, value, child) {
          return Transform.scale(
            alignment:
                widget.left ? Alignment.centerRight : Alignment.centerLeft,
            scale: value,
            child: child,
          );
        },
        child: Container(
          color: Colors.grey[200],
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('JFK + ORY'),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if ((animated) && (widget.left)) ...[
          buildCard(),
          Container(
            height: 1.0,
            width: 10.0,
            color: Colors.grey[400],
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: widget.selected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if ((animated) && (!widget.left)) ...[
          Container(
            height: 1.0,
            width: 10.0,
            color: Colors.grey[400],
          ),
          Container(
            color: Colors.grey[200],
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('JFK + ORY'),
            ),
          ),
        ],
      ],
    );
  }
}
