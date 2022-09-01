List<String> citysList = [
  'Erbil',
  'Duhok',
  'Slemmany',
  'Karkuk',
  'Zakho',
  'Halabja'
];
List<String> lessonType = [
  'Kurdish',
  'English',
  'Arabic',
  'Mathematics',
  'Chemistry',
  'Physics',
  'Biology',
  'Geography',
];
List<String> gender = [
  'Male',
  'Female',
];

class Numbers {
  methods() {
    for (var i = 1; i < 32; i++) {
      days.add('$i');
    }
    for (var i = 1; i < 13; i++) {
      months.add('$i');
    }
    for (var i = 2022; i > 1950; i--) {
      years.add('$i');
    }
  }

  final List<String> days = [];
  final List<String> months = [];
  final List<String> years = [];
}
