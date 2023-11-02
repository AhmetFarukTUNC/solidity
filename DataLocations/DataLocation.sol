// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

struct Student{

    uint8 age;

    uint16 score;

    string name;

}

contract School{

   uint256 totalStudents = 0; // storage

   mapping(uint256 => Student) students; // storage

   function addStudent(string calldata name,uint8 age,uint16 score) external {
    uint256 currentId = totalStudents++;

    students[currentId] = Student(age,score,name);
   }

    function changeStudentInfoStoroge(
        uint256 id,
        string calldata newName,
        uint8 newAge,
        uint16 newScore
    ) external{
        Student storage currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;

    }

    function changeStudentInfoMemory(
        uint256 id,
        string calldata newName,
        uint8 newAge,
        uint16 newScore 
    ) external view{
        Student memory currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;

    }

    function getStudentName(uint256 id) external view returns(string memory){

        return students[id].name;

    }



   }



