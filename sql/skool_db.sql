use skool_db;
CREATE TABLE Users (
                       UserID INT AUTO_INCREMENT PRIMARY KEY,
                       Name VARCHAR(100) NOT NULL,
                       Email VARCHAR(255) NOT NULL UNIQUE,
                       Role ENUM('Educator', 'Member') NOT NULL,
                       JoinDate TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       ProfileDetails TEXT,
                       INDEX idx_email (Email)
);
CREATE TABLE `Groups` (
                          GroupID INT AUTO_INCREMENT PRIMARY KEY,
                          CreatorID INT NOT NULL,
                          Name VARCHAR(100) NOT NULL,
                          Description TEXT,
                          PrivacyType ENUM('Public', 'Private') NOT NULL DEFAULT 'Public',
                          CreationDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (CreatorID) REFERENCES Users(UserID),
                          INDEX idx_creator (CreatorID)
);

CREATE TABLE Group_Members (
                               GroupID INT,
                               UserID INT,
                               JoinDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (GroupID, UserID),
                               FOREIGN KEY (GroupID) REFERENCES `Groups`(GroupID),
                               FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Courses (
                         CourseID INT AUTO_INCREMENT PRIMARY KEY,
                         GroupID INT NOT NULL,
                         EducatorID INT NOT NULL,
                         Title VARCHAR(255) NOT NULL,
                         Description TEXT,
                         CreationDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         AccessType ENUM('Free', 'Paid') NOT NULL DEFAULT 'Free',
                         FOREIGN KEY (GroupID) REFERENCES `Groups`(GroupID),
                         FOREIGN KEY (EducatorID) REFERENCES Users(UserID),
                         INDEX idx_group (GroupID)
);

CREATE TABLE Modules (
                         ModuleID INT AUTO_INCREMENT PRIMARY KEY,
                         CourseID INT NOT NULL,
                         Title VARCHAR(255) NOT NULL,
                         Content TEXT,
                         Resources TEXT,
                         `Order` INT NOT NULL,
                         FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
                         INDEX idx_course (CourseID)
);

CREATE TABLE Discussions (
                             DiscussionID INT AUTO_INCREMENT PRIMARY KEY,
                             GroupID INT NOT NULL,
                             CreatorID INT NOT NULL,
                             Content TEXT NOT NULL,
                             CreationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (GroupID) REFERENCES `Groups`(GroupID),
                             FOREIGN KEY (CreatorID) REFERENCES Users(UserID),
                             INDEX idx_group (GroupID)
);

CREATE TABLE Events (
                        EventID INT AUTO_INCREMENT PRIMARY KEY,
                        GroupID INT NOT NULL,
                        Title VARCHAR(255) NOT NULL,
                        Description TEXT,
                        StartTime DATETIME NOT NULL,
                        EndTime DATETIME NOT NULL,
                        TimeZone VARCHAR(50) NOT NULL DEFAULT 'UTC',
                        Location ENUM('Online', 'Offline') NOT NULL,
                        FOREIGN KEY (GroupID) REFERENCES `Groups`(GroupID),
                        INDEX idx_group (GroupID)
);
CREATE TABLE Event_RSVPs (
                             EventID INT,
                             UserID INT,
                             RSVPStatus ENUM('Yes', 'No', 'Maybe') NOT NULL DEFAULT 'Yes',
                             RSVPDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             PRIMARY KEY (EventID, UserID),
                             FOREIGN KEY (EventID) REFERENCES Events(EventID),
                             FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE Progress (
                          ProgressID INT AUTO_INCREMENT PRIMARY KEY,
                          MemberID INT NOT NULL,
                          CourseID INT NOT NULL,
                          ModuleID INT NOT NULL,
                          CompletionStatus ENUM('Not Started', 'In Progress', 'Completed') NOT NULL DEFAULT 'Not Started',
                          Timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (MemberID) REFERENCES Users(UserID),
                          FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
                          FOREIGN KEY (ModuleID) REFERENCES Modules(ModuleID),
                          UNIQUE KEY unique_progress (MemberID, CourseID, ModuleID)
);
SHOW TABLES;

DESCRIBE Users;
DESCRIBE `Groups`;

INSERT INTO Users (Name, Email, Role)
VALUES ('John Doe', 'john@example.com', 'Educator');
INSERT INTO `Groups` (CreatorID, Name, Description)
VALUES (1, 'Test Group', 'This is a test group');
SELECT * FROM Users;
SELECT * FROM `Groups`;