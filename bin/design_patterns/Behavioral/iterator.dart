/*
Iterator Design Pattern:
problem to solve:
Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
*/

class CompanyARepo extends Iterable<String> {
  List<String?> _employees = List<String?>.filled(10, null);
  int _index = 0;
  CompanyARepo() {
    _employees[0] = "Employee A1";
    _employees[1] = "Employee A2";
    _employees[2] = "Employee A3";
    _employees[3] = "Employee A4";
    _employees[4] = "Employee A5";
  }
  void addEmployee(String employee) {
    if (_index >= _employees.length) {
      List<String?> newEmployees = List<String?>.filled(
        _employees.length + 5,
        null,
      );
      for (int i = 0; i < _employees.length; i++) {
        newEmployees[i] = _employees[i];
      }
      _employees = newEmployees;
    }
    _employees[_index] = employee;
    _index++;
  }

  @override
  Iterator<String> get iterator => _EmployeeIterator(_employees);
}

class _EmployeeIterator implements Iterator<String> {
  final List<String?> _employees;
  int _currentIndex = 0;
  String? _currentEmployee;
  _EmployeeIterator(this._employees);

  @override
  String get current => _currentEmployee!;

  bool get hasNext =>
      _currentIndex < _employees.length && _employees[_currentIndex] != null;

  @override
  bool moveNext() {
    while (_currentIndex < _employees.length) {
      _currentEmployee = _employees[_currentIndex];
      _currentIndex++;
      if (_currentEmployee != null) {
        return true;
      }
    }
    return false;
  }
}

void main() {
  CompanyARepo companyARepo = CompanyARepo();
  for (var employee in companyARepo) {
    print(employee);
  }
}
