package com.f.crud.service;

import com.f.crud.bean.Employee;

import java.util.List;

/**
 * @author shkstart
 * @create 2020-09-09-16:36
 */
public interface EmployeeService {
    List<Employee> getAll();


    int insertEmp(Employee employee);

    boolean checkEmail(String email);


    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    void deleteOneEmp(Integer empId);

    void deleteAnyEmp(List<String> asList);
}
