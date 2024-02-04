// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract StudentDB {
    struct Student {
        string name;
        uint256 age;
        string major;
        string email;
        uint256 studentId;
    }

    mapping(address => Student) public students;

    event StudentAdded(address indexed studentAddress, string name, uint256 age, string major, string email, uint256 studentId);
    event StudentUpdated(address indexed studentAddress, string name, uint256 age, string major, string email, uint256 studentId);
    event StudentRemoved(address indexed studentAddress);

    modifier onlyStudent() {
        require(students[msg.sender].studentId != 0, "Not a registered student");
        _;
    }

    function addStudent(string memory _name, uint256 _age, string memory _major, string memory _email, uint256 _studentId) external {
        require(students[msg.sender].studentId == 0, "Student already exists");

        students[msg.sender] = Student({
            name: _name,
            age: _age,
            major: _major,
            email: _email,
            studentId: _studentId
        });

        emit StudentAdded(msg.sender, _name, _age, _major, _email, _studentId);
    }

    function updateStudent(string memory _name, uint256 _age, string memory _major, string memory _email, uint256 _studentId) external onlyStudent {
        students[msg.sender].name = _name;
        students[msg.sender].age = _age;
        students[msg.sender].major = _major;
        students[msg.sender].email = _email;
        students[msg.sender].studentId = _studentId;

        emit StudentUpdated(msg.sender, _name, _age, _major, _email, _studentId);
    }

    function removeStudent() external onlyStudent {
        delete students[msg.sender];

        emit StudentRemoved(msg.sender);
    }
}
