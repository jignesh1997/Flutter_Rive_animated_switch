import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

DayNightAnimationController animationController = DayNightAnimationController();
AnimationStates _currentAnimationState = AnimationStates.night_idle;
AnimationStates get currentAnimationState => _currentAnimationState;
set currentAnimationState(AnimationStates value) {
  _currentAnimationState = value;
  animationController.changeAnimationState(value);
}
Function(bool) onSelectionChange;
class DayNightSwitch extends StatefulWidget {
  double height, width;
  DayNightSwitch({this.height = 0.0, this.width = 0.0,Function(bool) onSelection}){
    onSelectionChange=onSelection;
  }
  @override
  State<StatefulWidget> createState() => DayNightSwitchState();
}
enum AnimationStates { day_idle, switch_day, night_idle, switch_night }
extension on AnimationStates {
  String getName() {
    return this.toString().split('.').last;
  }
}

class DayNightSwitchState extends State<DayNightSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: GestureDetector(
        child: FlareActor(
          "assets/Animation_button.flr",
          controller: animationController,
        ),
        onTap: () {
          if (currentAnimationState == AnimationStates.day_idle) {
            currentAnimationState = AnimationStates.switch_night;
          } else {
            currentAnimationState = AnimationStates.switch_day;
          }
          // print("click");
          //widget.animationController.changeAnimationState(widget.currentAnimationState);
        },
      ),
    );
  }
}

class DayNightAnimationController extends FlareControls {
  @override
  void onCompleted(String name) {
    print(name);
    if (name == AnimationStates.switch_night.getName()) {
      play(AnimationStates.night_idle.getName());
      currentAnimationState = AnimationStates.night_idle;
      onSelectionChange(false);
    }
    if (name == AnimationStates.switch_day.getName()) {
      play(AnimationStates.day_idle.getName());
      currentAnimationState = AnimationStates.day_idle;
      onSelectionChange(true);
    }
    super.onCompleted(name);
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    play(AnimationStates.night_idle.getName());
  }

  void changeAnimationState(AnimationStates states) {
    print(states.getName());
    play(states.getName());
  }
}
