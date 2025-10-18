// enum Skill { FLUTTER, DART, OTHER }

// class Address{
//   final String _street;
//   final String _city;
//   final String _zipCode;
  
//   String get street => _street;
//   String get city => _city;
//   String get zipCode => _zipCode;
  
//   Address(this._street, this._city, this._zipCode);

//   @override
//   String toString() => '$street, $city ($zipCode)';
// }

// class Employee {
//   final String _name;
//   double _baseSalary;
//   List<Skill> _skill;
//   final Address _address;
//   int _yearsOfExperience;

//   String get name => _name;
//   double get baseSalary => _baseSalary;
//   List<Skill> get skill => _skill;
//   Address get address => _address;
//   int get yearsOfExperience => _yearsOfExperience;

//   Employee(this._name,
//   this._baseSalary, 
//   this._skill, 
//   this._address, 
//   this._yearsOfExperience);

//   Employee.mobileDeveloper(
//   this._name,
//   this._baseSalary,
//   this._address,
//   this._yearsOfExperience,
//   ) : _skill = [Skill.DART, Skill.FLUTTER];


//   void printDetails() {
//   print('Employee: $name, '
//       'Base Salary: \$$_baseSalary, '
//       'Salary: \$${computeSalary()}, '
//       'Skill: ${_skill.map((s) => s.name).join(', ')}, '
//       'Address: $address, '
//       'Experience: $yearsOfExperience years');
//   }

//   double computeSalary(){

//     double total = baseSalary; //base salary

//     total += _yearsOfExperience * 2000; //add experience

//     for (var skills in _skill){
//       switch(skills){
//         case Skill.DART:
//           total += 3000;
//         break;
//         case Skill.FLUTTER:
//           total += 5000;
//         break;
//         case Skill.OTHER:
//           total += 1000;
//         break;
//       }
//     }
//   return total;
//   }
// }

// void main() {
//   Address adr1 = Address("M09", "Phnom Penh", "121021");
//   var emp1 = Employee('Sokea', 40000, [Skill.DART, Skill.OTHER], adr1, 2 );

//   emp1.printDetails();
// }

enum Skill { FLUTTER(5000), DART(2000), OTHER(1000);
 final int bonus;

  const Skill(this.bonus);
 }

class Employee {
  static const double  BASE_SALARY = 40000;
  static const double  YEAR_EXP_BONUS = 2000;
  String _name;
  double _baseSalary;
  List<Skill> _skills;
  Address _address;
  int _yearsOfExperience;

  Employee(
    this._name, 
    this._baseSalary, {
      required List<Skill> skills,
      required Address address,
      required int yearsOfExperience
    }
  ) : _skills = skills,
      _address = address,
      _yearsOfExperience = yearsOfExperience;

  // Named constructor for a Mobile Developer
  Employee.mobileDeveloper(
    String name,
    double baseSalary,
    Address address, {
      int yearsOfExperience = 0,
    }
  ) : _name = name,
      _baseSalary = baseSalary,
      _skills = [Skill.FLUTTER, Skill.DART],
      _address = address,
      _yearsOfExperience = yearsOfExperience;

  // Getter
  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  // Method to compute salary
  double computeSalary() {
    double salary = BASE_SALARY; // base salary
    salary += _yearsOfExperience * YEAR_EXP_BONUS;

    for (var skill in _skills) {
      
      salary+= skill.bonus;
    }

    return salary;
  }


  void printDetails() {
    final skillList = skills.map((s) => s.name).join(', ');
    print('Employee: $_name');
    print('  Base Salary: \$${_baseSalary}');
    print('  Skills: $skillList');
    print('  Address: $_address');
    print('  Years of Experience: $_yearsOfExperience');
    print('  Computed Salary: \$${computeSalary()}');
    print('------------------------------------');
  }
}

class Address {
  final String street;
  final String city;
  final String zipCode;

  const Address(
    this.street,
    this.city,
    this.zipCode
  );
  
  @override
  String toString() => '$street, $city $zipCode';
}

void main() {
  //Regular employee
  var emp1 = Employee(
    'Sokea', 40000,
    skills: [Skill.DART, Skill.OTHER],
    address: Address('178 toul', 'PhnomPenh', '12000'),
    yearsOfExperience: 2,
  );
  emp1.printDetails();

  // Mobile developer
  var emp2 = Employee.mobileDeveloper(
    'Ronan', 45000,
    Address('12 Samk', 'Phnom Penh', '12000'),
    yearsOfExperience: 5,
  );
  emp2.printDetails();
}