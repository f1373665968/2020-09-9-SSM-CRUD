package com.f.crud.test;


import com.f.crud.dao.DepartmentMapper;
import com.f.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


/**
 * @author shkstart
 * @create 2020-09-09-15:09
 * dao层的测试工作
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);
       /* //插入几个部门
       // departmentMapper.insertSelective(new Department(null, "开发部"));
       // departmentMapper.insertSelective(new Department(null, "测试部"));

        //测试插入员工数据
        //employeeMapper.insertSelective(new Employee(null, "Jerry","M","jerry@163.com",1));

        //批量插入多个员工,批量，使用可以执行的
        *//*EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@163.com", 1));
        }
        System.out.println("执行完成");*/

        employeeMapper.deleteByPrimaryKey(1001);
    }
}
