enum Skill { FLUTTER, DART, OTHER }

Map<Skill, int> skillSalaries = {
    Skill.FLUTTER: 5000,
    Skill.DART: 3000,
    Skill.OTHER: 1000
};

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address({required this.street, required this.city, required this.zipCode});
}

class Employee {
  final String _name;
  double _baseSalary;
  List<Skill> _skills;
  Address _address;
  int _yearsOfExperience;

  Employee({required String name,
   required double baseSalary,
    required List<Skill> skills,
     required Address address,
      required int yearsOfExperience}):
    _name = name,
    _baseSalary = baseSalary,
    _skills = skills,
    _address = address,
    _yearsOfExperience = yearsOfExperience;

  Employee.mobileDeveloper(
      {required String name,
      required double baseSalary,
      required Address address,
      required int yearsOfExperience}):
    _skills = [Skill.DART, Skill.FLUTTER],
    _name = name,
    _baseSalary = baseSalary,
    _address = address,
    _yearsOfExperience = yearsOfExperience;

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    double bonus = 0;
    _skills.forEach((skill) {
      if(skillSalaries.containsKey(skill)){
        bonus += skillSalaries[skill]!;
      }
    });
    return _baseSalary + 2000*_yearsOfExperience + bonus;
  }

  void printDetails() {
    print('Employee: $_name, Base Salary: \$${_baseSalary}, '
        'Years of Experience: $_yearsOfExperience, '
        'Address: ${_address.toString()}, '
        'Skills: ${_skills.map((skill) => skill.toString()).join(', ')}');
  }
}
void main() {
  var employee1 = Employee(
    name: 'Alice Johnson',
    baseSalary: 75000,
    skills: [Skill.FLUTTER, Skill.OTHER],
    address: Address(street: '123 Main St', city: 'Springfield', zipCode: '12345'),
    yearsOfExperience: 5,
  );

  var mobileDeveloper = Employee.mobileDeveloper(
    name: 'Bob Smith',
    baseSalary: 85000,
    address: Address(street: '456 Elm St', city: 'Metropolis', zipCode: '67890'),
    yearsOfExperience: 3,
  );

  employee1.printDetails();
  print('Total Salary: \$${employee1.computeSalary()}\n');

  mobileDeveloper.printDetails();
  print('Total Salary: \$${mobileDeveloper.computeSalary()}');
}
