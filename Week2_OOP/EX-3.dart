class CustomeDuration{
  final int _milliseconds;

  int get milliseconds => _milliseconds;

  CustomeDuration(this._milliseconds) : assert(_milliseconds>= 0, 'Duration must be positive');

  CustomeDuration.fromHours(int hours): assert(hours>=0, 'Hour must be positive') , _milliseconds = hours * 3600000;
  CustomeDuration.fromMinutes(int minutes): assert(minutes>=0, 'Minute must be positive') , _milliseconds = minutes * 60000;
  CustomeDuration.fromSeconds(int seconds): assert(seconds>=0, 'Seconds must be positive') , _milliseconds = seconds * 1000;

  bool operator >(CustomeDuration other) => milliseconds > other.milliseconds;

  CustomeDuration operator +(CustomeDuration other) => CustomeDuration(milliseconds +other.milliseconds);

  CustomeDuration operator -(CustomeDuration other){
    final minus = milliseconds - other.milliseconds;
    if (minus < 0) {
      throw ArgumentError('Resulting duration must be >= 0');
    }
    return CustomeDuration(minus);
  }

  double get hours => _milliseconds / 3_600_000;
  double get minutes => _milliseconds / 60_000;
  double get seconds => _milliseconds / 1000;
  int get millisecond => _milliseconds;  

  @override
  String toString() => '${milliseconds} ms';
}

void main(){
  CustomeDuration d1 = CustomeDuration.fromHours(2);
  CustomeDuration d2 = CustomeDuration.fromMinutes(20);

  print('The total duration of d1 and d2 is ${(d1 + d2).seconds} s');
  print('The different between d1 and d2 is ${(d1 - d2).minutes} mn');
  print('The duration of d1 is greater than d2 ${d1 > d2}');
}