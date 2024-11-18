```mermaid
   erDiagram
    Users ||--o{ Groups : creates
    Users }o--o{ Groups : joins
    Users ||--o{ Discussions : creates
    Users }o--o{ Events : RSVPs
    
    Groups ||--o{ Courses : contains
    Groups ||--o{ Discussions : hosts
    Groups ||--o{ Events : schedules
    
    Courses ||--|{ Modules : contains
    Courses }o--o{ Progress : tracks
    
    Users }o--o{ Progress : has
    Modules ||--o{ Progress : tracks

    Users {
        int UserID PK
        string Name
        string Email
        enum Role
        date JoinDate
        text ProfileDetails
    }

    Groups {
        int GroupID PK
        int CreatorID FK
        string Name
        text Description
        enum PrivacyType
        date CreationDate
    }

    Courses {
        int CourseID PK
        int GroupID FK
        int EducatorID FK
        string Title
        text Description
        date CreationDate
        enum AccessType
    }

    Modules {
        int ModuleID PK
        int CourseID FK
        string Title
        text Content
        text Resources
        int Order
    }

    Discussions {
        int DiscussionID PK
        int GroupID FK
        int CreatorID FK
        text Content
        date CreationDate
    }

    Events {
        int EventID PK
        int GroupID FK
        string Title
        text Description
        datetime StartTime
        datetime EndTime
        string TimeZone
        enum Location
    }

    Progress {
        int ProgressID PK
        int MemberID FK
        int CourseID FK
        int ModuleID FK
        enum CompletionStatus
        datetime Timestamp
    }