package com.f.crud.service.impl;

import com.f.crud.bean.Employee;
import com.f.crud.bean.EmployeeExample;
import com.f.crud.dao.EmployeeMapper;
import com.f.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shkstart
 * @create 2020-09-09-16:37
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public int insertEmp(Employee employee) {
        int count = employeeMapper.insertSelective(employee);
        return count;
    }

    @Override
    public boolean checkEmail(String email) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    @Override
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    @Override
    public void updateEmp(Employee employee) {
        int count = employeeMapper.updateByPrimaryKeySelective(employee);
        System.out.println(count);

    }

    @Override
    public void deleteOneEmp(Integer empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    @Override
    public void deleteAnyEmp(List<String> asList) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(asList);
        employeeMapper.deleteByExample(example);
    }


}
