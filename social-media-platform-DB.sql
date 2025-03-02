USE [Social Media Platform];
CREATE TABLE Users(
     ID INT IDENTITY PRIMARY KEY,
	 UserName NVARCHAR(100) NOT NULL,
	 Email NVARCHAR(100) UNIQUE NOT NULL,
	 DOB DATE NOT NULL,
	 Gender NVARCHAR(20) CHECK(Gender IN ('Male', 'Female') ) NOT NULL,
	 JoinDate DATETIME DEFAULT GETUTCDATE()
);
CREATE TABLE Posts(
      ID INT IDENTITY PRIMARY KEY,
	  Content NVARCHAR(250) NOT NULL,
	  Date DATETIME DEFAULT GETUTCDATE(),
	  Visibility NVARCHAR(50) CHECK(Visibility IN
	  ('Public','Private')) Default 'Public',
	  UserID INT NOT NULL,
	  FOREIGN KEY (UserID) REFERENCES Users(ID)
);


CREATE TABLE Interactions(
      ID INT IDENTITY PRIMARY KEY,
	  Type NVARCHAR(100) CHECK (Type IN ('Reaction', 'Comment', 'Share')),
	  InteractionDate DATETIME DEFAULT GETUTCDATE(),
	  UserID INT NOT NULL,
	  PostID INT NOT NULL,
	  FOREIGN KEY (UserID) REFERENCES Users(ID),
	  FOREIGN KEY (PostID) REFERENCES Posts(ID)
);


CREATE TABLE Comments(
     ID INT IDENTITY PRIMARY KEY,
	 Content NVARCHAR(250) NOT NULL,
	 CommentDate DATETIME DEFAULT GETUTCDATE(),
	 UserID INT NOT NULL,
	 PostID INT NOT NULL,
	 FOREIGN KEY (UserID) REFERENCES Users(ID),
	 FOREIGN KEY (PostID) REFERENCES Posts(ID)

);

CREATE TABLE UserPosts(
      UserID INT NOT NULL,
	  PostID INT NOT NULL,
	  PRIMARY KEY (UserID, PostID),
	  FOREIGN KEY (UserID) REFERENCES Users(ID),
	  FOREIGN KEY (PostID) REFERENCES Posts(ID)
);

INSERT INTO Users(UserName, Email, DOB, Gender, JoinDate)
VALUES ('BruceWayne', 'brucewayne@gmail.com', '1939-02-19',
'Male','2025-02-02'),
('TonyStark', 'tonystark@gmail.com', '1970-03-29','Male', 
'2025-02-02' );

INSERT INTO Posts(Content, Date, Visibility, UserID) VALUES
('Comedy', '2025-02-02 14:30:00', 'Private',1),
('Social', '2025-02-02 14:30:00', 'Public',2);

INSERT INTO Interactions(Type, InteractionDate, UserID, PostID)
VALUES('Reaction', '2025-02-02 14:30:00', 1,1),
('Comment','2025-02-02 14:30:00',2,2);

INSERT INTO Comments(Content, CommentDate, UserID, PostID) VALUES
('Hahaha', '2025-02-02 14:30:00', 1, 1),
('This is sad', '2025-02-02 14:30:00', 2, 2);

INSERT INTO UserPosts(UserID, PostID) VALUES 
(1,1),
(2,2);
