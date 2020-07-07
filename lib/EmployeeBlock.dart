import 'dart:async';
import 'Employee.dart';

class EmployeeBLoc {

  List<Employee> _employeeList =[
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 20000.0),
    Employee(3, "Employee three", 30000.0),
    Employee(4, "Employee four", 40000.0),
    Employee(5, "Employee five", 50000.0),
  ];

final _employeeListStreamController = StreamController<List<Employee>>();

//for inc and dec
final _employeeSalaryIncreamentStreamController = StreamController<Employee>();
final _employeeSalaryDecreamentStreamController = StreamController<Employee>();

//getters

Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

StreamSink<Employee> get employeeSalaryIncreament => _employeeSalaryIncreamentStreamController.sink;

StreamSink<Employee> get employeeSalaryDecreament => _employeeSalaryDecreamentStreamController.sink;

EmployeeBLoc () {
  _employeeListStreamController.add(_employeeList); 

  _employeeSalaryIncreamentStreamController.stream.listen(_increamentSalary);
  _employeeSalaryDecreamentStreamController.stream.listen(_decreamentSalary);
}

_increamentSalary(Employee employee){
  double salary = employee.salary;

  double increamentedSalary = salary * 20/100;

  _employeeList[employee.id -1].salary = salary + increamentedSalary;

  employeeListSink.add(_employeeList);
}

_decreamentSalary(Employee employee){
  double salary = employee.salary;

  double decreamentedSalary = salary * 20/100;

  _employeeList[employee.id -1].salary = salary - decreamentedSalary;

  employeeListSink.add(_employeeList);
}

void dispose(){
  _employeeSalaryIncreamentStreamController.close();
  _employeeSalaryDecreamentStreamController.close();
  _employeeListStreamController.close();
}
}