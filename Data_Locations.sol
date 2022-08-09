// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;


struct Student{
    uint8 age;
    uint16 score;
    string name;
}

contract School{
    uint256 totalStudent = 0;
    mapping(uint256 => Student) students;

    function addStudent(string calldata _name, uint8 _age, uint16 _score)external  {
        uint256 currentId = totalStudent++;
        //stuents[currentId] = Student(_age,_score,_name);
        Student memory tempStudent = Student(_age,_score,_name);
        tempStudent.age = _age;
        tempStudent.score = _score;
        tempStudent.name = _name;
        students[currentId] = tempStudent;
    }



    //Storage yerine memory kullansaydık değişikliği göremezdik çünkü currentStudent fonksiyon
    //sonlandığında silinecekti.O yüzden storage kullandık
    function changesStudentInfos(uint id, string calldata newName,uint8 newAge,uint16 newScore)external{
        Student storage currentStudent = students[id];
        currentStudent.name = newName;
        currentStudent.age = newAge; 
        currentStudent.score = newScore;

    }

}