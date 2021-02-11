import 'dart:async';
import 'package:flutter_productivity_timer_app/Models/TimerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';




class CountDownTimer{

  //double
  double _radius = 1;

  //bool
  bool _isActive = true;

  //timer
  Timer timer;

  //duration
  Duration _time;
  Duration _fullTime;

  //int
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  //void
  void startWork() async{
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  void startTimer(){
    if(this._time.inSeconds > 0){
      this._isActive = true;
    }
  }

  void stopTimer(){
    this._isActive = false;
  }


  void startBreak(bool isShort){
    _radius = 1;
    _time = Duration(
        minutes: (isShort) ? shortBreak : longBreak,
        seconds: 0
    );
    _fullTime = _time;
  }

//Futures
  Future readSettings() async {
    SharedPreferences prefs = await
    SharedPreferences.getInstance();
    work = prefs.getInt("workTime") == null ? 30: prefs.getInt("workTime");
    shortBreak = prefs.getInt("shortBreak") == null ? 5: prefs.getInt("shortBreak");
    longBreak = prefs.getInt("longBreak") == null ? 15: prefs.getInt("longBreak");
  }

  Stream<TimerModel> stream() async*{
    yield* Stream.periodic(
        Duration(seconds: 1),
            (int a){
              String time;
              if (this._isActive){
                _time = _time - Duration(seconds: 1);
                _radius = _time.inSeconds / _fullTime.inSeconds;
                if (_time.inSeconds <= 0){
                  _isActive = false;
                }
              }
              time = returnTime(_time);
              return TimerModel(time, _radius);
        });
  }

  String returnTime(Duration durationOfTime){
    String minutes = (durationOfTime.inMinutes < 10)
        ? "0" + durationOfTime.inMinutes.toString()
        : durationOfTime.inMinutes.toString();

    int numSeconds = durationOfTime.inSeconds - (durationOfTime.inMinutes * 60);

    String seconds = (numSeconds < 10)
    ? "0" + numSeconds.toString()
        : numSeconds.toString();

    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }
}