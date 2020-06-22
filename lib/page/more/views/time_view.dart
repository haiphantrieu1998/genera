import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geneexpert/auth/auth_bloc.dart';
import 'package:geneexpert/auth/auth_event.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/themes/styles.dart';
import 'package:hive/hive.dart';

// b1: click vào sẽ đếm ngược 24h
// khi thoát app ra mà còn đếm ngược thì lưu thời điểm đó vào và thời gian còn lại
// khi mở app ra lại thì lấy thời gian hiện tại trừ thời điểm trên ra số giờ =>
// thời gian con lại lúc này đc cập nhật trừ với
// số giờ

class TimeView extends StatefulWidget {
  final Function onTap;

  TimeView({Key key, this.onTap}) : super(key: key);

  @override
  TimeViewState createState() => TimeViewState();
}

class TimeViewState extends State<TimeView> with WidgetsBindingObserver {
  int _start = 24*60*60;
  Timer _timer;
  DateTime timePause;
  int timeRemain;
  static final String _timeCheckinKey = 'timeCheckinKey';
  var box;


//  DateTime timeUpdate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  void _init() async {
    box = await Hive.openBox(_timeCheckinKey);
    DateTime timeCheckinSave = box.get(_timeCheckinKey); //

    if (timeCheckinSave != null) {
      DateTime timeNow = DateTime.now();
      Duration duration = timeNow.difference(timeCheckinSave);
      int hours = duration.inHours;
      int min = duration.inMinutes;
      int sec = duration.inSeconds;
      int total = hours * 60 * 60 + min * 60 + sec;
      int remain = _start - total;
      if (remain > 1) {
        _start = remain;
        startTimer(isSave: false);
      }
    }
  }

  void _saveTimeCheckin() async {
    box ??= await Hive.openBox(_timeCheckinKey);
    box.put(_timeCheckinKey, DateTime.now());
  }

  void startTimer({bool isSave = true}) {
    if(_start==0){
      _start=24*60*60;
    }
    if (_timer != null) {
      Utils.showToast('You have checked in');
      return;
    }
//    else{
//      BlocProvider.of<AuthBloc>(context).add(CoinChangeEvent(5));
//    }
    print('TimeViewState startTimer ');
    if (isSave) _saveTimeCheckin();  // lưu thời điểm khi user click vào
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
//        print('$time');
        setState(
          () {
            if (_start < 1) {
              timer.cancel();
              _timer = null;
            } else {
              _start = _start - 1;
            }
          },
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // người dùng đã quay lại ứng dụng
      //lấy thời gian user quay lại - thời gian tạm dừng => chạy lại thời gian
      if (_start < 1) return;
      Duration time = DateTime.now().difference(timePause);
      int abc = time.inSeconds;
      _start = _start - abc;
      startTimer();
    } else if (state == AppLifecycleState.paused) {
      //người dùng sắp thoát khỏi ứng dụng theo thời gian
      // tạm dừng timer
      if (_start < 1) return;
      timePause = DateTime.now(); // ghi lại thời gian tạm dừng
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(time),
      child: Text(
        '${time == '00:00:00' ? '' : '($time)'}',
        style: GEXStyles.copyStyle(color: GEXStyles.yellow1),
      ),
    );
  }

  String get time {
    String hour;
    String min;
    String sec;
    int hourInt = (_start ~/ (60 * 60)).toInt();
    if (hourInt < 10) {
      hour = '0$hourInt';
    } else {
      hour = '$hourInt';
    }
    int minInt = (_start - (hourInt * 60 * 60)) ~/ 60;
    if (minInt < 10) {
      min = '0$minInt';
    } else {
      min = '$minInt';
    }
    int second = ((_start - (hourInt * 60 * 60) - (minInt * 60))).toInt();
    if (second < 10) {
      sec = '0$second';
    } else {
      sec = '$second';
    }
    return '$hour:$min:$sec';
  }
}
