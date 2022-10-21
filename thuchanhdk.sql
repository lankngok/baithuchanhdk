--khoi tao database

CREATE DATABASE `BKInside` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--khoi tao bang Students
CREATE TABLE IF NOT EXISTS `Students` (
 	StudentID int PRIMARY KEY AUTO_INCREMENT,
    StudentName varchar(50),
    Age int ,
    Email varchar(100)
) ;
--khoi tao bang Subjects
CREATE TABLE IF NOT EXISTS `Subjects` (
  	SubjectID int PRIMARY KEY,
    SubjectName varchar(50)
);
--khoi tao bang Classes
CREATE TABLE IF NOT EXISTS `Classes` (
 	ClassID int PRIMARY KEY,
    ClassName varchar(50)
);
--khoi tao bang Marks
CREATE TABLE IF NOT EXISTS `Marks` (
	Marks int ,
    SubjectID int,
    StudentID int 

);
-- khoi tao bang ClassStudent
CREATE TABLE IF NOT EXISTS `ClassStudent` (
 	StudentID int,
    ClassID int
);

-- tao rang buoc khoa ngoai 
ALTER TABLE marks
ADD FOREIGN KEY (StudentID) REFERENCES students (StudentID)

ALTER TABLE classstudent
ADD FOREIGN KEY (StudentID) REFERENCES students (StudentID)

ALTER TABLE classstudent
ADD FOREIGN KEY (ClassID) REFERENCES classes (ClassID)

ALTER TABLE marks
ADD FOREIGN KEY (SubjectID) REFERENCES subjects (SubjectId)



-- chen du lieu vao bang Students
INSERT INTO students VALUES
(null,"Tran Lan Anh",19,"anh@gmail.com"),
(null,"Le Khac Thien",18,"thien3110"),
(null,"Pham Quoc Hung",19,"hung@yahoo.com"),
(null,"Ngo Tien Dat",20,"dat09@gmail.com"),
(null,"Vu Trung Kien",25,"kien@com");

-- chen du lieu vao bang Classes 
INSERT INTO classes VALUES
(1,"C2110I1"),
(2,"C2110H1");

-- chen du lieu vao bang ClassStudent

INSERT INTO classstudent VALUES
(1,1),
(2,1),
(3,2),
(4,2),
(5,2);
-- chen  du lieu vao bang  Subjects
INSERT INTO subjects VALUES
(1,"SQL"),
(2,"Java"),
(3,"C"),
(4,"Visual Basic");

-- chen du lieu vao bang Marks
INSERT INTO marks VALUES
(8,1,1),
(4,2,1),
(9,1,1),
(7,1,3),
(3,1,4),
(5,2,5),
(8,3,3),
(1,3,5),
(3,2,4);

-- 4 thuc hien truy van
---4.1 Hiển thị danh sách tất cả các học viên (Danh sách phải sắp xếp theo tên học viên)
SELECT *
FROM students 
ORDER BY StudentName ASC

--4.2Hiển thị danh sách tất cả các môn học
SELECT su.SubjectName
FROM subjects su

--4.3Hiển thị danh sách những học viên nào có địa chỉ email chính xác
SELECT *
FROM students WHERE Email LIKE '%@gmail.com'
-- hoac la:
SELECT * 
FROM students st 
WHERE st.Email REGEXP '^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9_\-]@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]\.[a-zA-Z]{2,4}$'

--4.4Hiển thị danh sách những học viên có họ là Tran
SELECT *
FROM students WHERE StudentName LIKE 'Tran%'

--4.5Hiển thị danh sách ác bạn học viên của lớp C2110I1
SELECT st.StudentName,  cl.ClassName
FROM students st INNER JOIN classstudent cs ON cs.StudentID = st.StudentID INNER JOIN classes cl ON cl.ClassID = cs.ClassID
WHERE cl.ClassName = "C2110i1"  

-- 4.6 Hiển thị danh sách và điểm học viên ứng với môn học
SELECT st.StudentName , su.SubjectName , m.Marks
FROM students st INNER JOIN marks m ON m.StudentID=st.StudentID INNER JOIN subjects su ON su.SubjectID=m.SubjectID

--4.7 Hiển thị danh sách học viên chưa thi môn nào (Chưa có điểm)
SELECT st.StudentName , su.SubjectName , m.Marks, COUNT(m.StudentID)
FROM students st LEFT JOIN marks m ON m.StudentID=st.StudentID LEFT JOIN subjects su ON su.SubjectID=m.SubjectID 
GROUP BY st.StudentName , su.SubjectName , m.Marks
HAVING COUNT(m.StudentID) = 0

--4.8 Hiển thị môn nào chưa được học viên nào thi
SELECT su.SubjectName , COUNT(m.SubjectID)
FROM subjects su LEFT JOIN marks m ON m.SubjectID=su.SubjectID 
GROUP BY su.SubjectName
HAVING COUNT(m.SubjectID) =0

--4.9 Tính điểm trung bình cho các học viên
SELECT st.StudentName , AVG(ma.Marks)
FROM marks ma LEFT JOIN students st ON st.StudentID=ma.StudentID
GROUP BY st.StudentName

--4.10 Hiển thị môn học nào được thi nhiều nhất
SELECT su.SubjectName , COUNT(ma.SubjectID)
FROM marks ma INNER JOIN subjects su ON su.SubjectID=ma.SubjectID
GROUP BY su.SubjectName
ORDER BY  COUNT(ma.SubjectID) DESC 
LIMIT 1;
--4.11 Hiển thị môn học nào có học sinh thi được điểm cao nhất

SELECT su.SubjectName , MAX(ma.Marks) 
FROM marks ma INNER JOIN subjects su ON su.SubjectID=ma.SubjectID

--4.12 Hiển thị môn học nào có nhiều điểm dưới trung bình nhất (<5)
SELECT su.SubjectName , COUNT(ma.Marks)
FROM marks ma INNER JOIN subjects su ON su.SubjectID=ma.SubjectID WHERE ma.Marks<5
GROUP BY su.SubjectName
ORDER BY COUNT(ma.Marks) DESC
LIMIT 1

--5 tao rang buoc
--5.1 Tạo Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE students 
ADD CONSTRAINT CHECK(Age>15 AND Age<50)
--5.2 Xóa học viên có StudentID là 1


--5.3 Trong bảng Student them một column Status có kiểu dữ liệu là Bit và có giá trị Default là 1
ALTER TABLE students
ADD Status bit DEFAULT 1
--5.4 Cập nhật giá trị Status trong bảng Student là 0 tại StudentID = 3
UPDATE students
SET Status = 0
WHERE StudentID =3



