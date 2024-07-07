CREATE TABLE FileSystem (
    NodeID INT PRIMARY KEY,
    NodeName NVARCHAR(50) NOT NULL,
    ParentID INT NULL,
    SizeBytes INT NULL
)