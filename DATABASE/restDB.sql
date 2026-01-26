CREATE DATABASE PRJ302_MusicStremingDB;
GO

USE PRJ302_MusicStremingDB;
GO

CREATE TABLE ROLES(
	roleID INT IDENTITY(1,1) PRIMARY KEY,
	roleName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE USERS(
	userID INT IDENTITY(1,1) PRIMARY KEY,
	userName NVARCHAR(50) NOT NULL UNIQUE,
	email NVARCHAR(100) UNIQUE,
	password NVARCHAR(255) NOT NULL,
	avatar NVARCHAR(255),
	fullName NVARCHAR(100),
	birthday DATE,
	gender NVARCHAR(10),
	createDate DATETIME NOT NULL DEFAULT GETDATE(),
	lastLogin DATETIME,
	[status] TINYINT NOT NULL DEFAULT 1,
	roleID INT NOT NULL,
	CONSTRAINT FK_User_Role
	FOREIGN KEY(roleID) REFERENCES ROLES(roleID)
);

CREATE TABLE ARTIST(
	artistID INT IDENTITY(1,1) PRIMARY KEY,
	artistName NVARCHAR(100) NOT NULL,
	avatarURL NVARCHAR(255),
	[description] NVARCHAR(MAX),
	debutDate DATE,
	isActive TINYINT NOT NULL DEFAULT 1
)

CREATE TABLE ALBUM(
	albumID INT IDENTITY(1,1) PRIMARY KEY,
	albumName NVARCHAR(200) NOT NULL,
	coverImage NVARCHAR(255),
	releaseDate DATE,
	isActive TINYINT NOT NULL DEFAULT 1
);

CREATE TABLE SONG(
	songID INT IDENTITY(1,1) PRIMARY KEY,
	title NVARCHAR(200) NOT NULL,
	duration INT NOT NULL,
	audioURL NVARCHAR(255) NOT NULL,
	lyric NVARCHAR(MAX),
	releaseDate DATE,
	coverImage NVARCHAR(255),
	isActive TINYINT NOT NULL DEFAULT 1
);

CREATE TABLE SONG_ARTIST(
	songID INT NOT NULL,
	artistID INT NOT NULL,
	CONSTRAINT PK_SongArtist PRIMARY KEY(songID, artistID),
	CONSTRAINT FK_SongArtist_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID),
	CONSTRAINT FK_SongArtist_Artist
	FOREIGN KEY(artistID) REFERENCES ARTIST(artistID)
);
CREATE TABLE ALBUM_ARTIST(
	albumID INT NOT NULL,
	artistID INT NOT NULL,
	CONSTRAINT PK_AlbumArtist PRIMARY KEY (albumID, artistID),
	CONSTRAINT FK_AlbumArtist_Album
	FOREIGN KEY(albumID) REFERENCES ALBUM(albumID),
	CONSTRAINT FK_AlbumArtist_Artist
	FOREIGN KEY(artistID) REFERENCES ARTIST(artistID)
);

CREATE TABLE ALBUM_SONG(
	albumID INT NOT NULL,
	songID INT NOT NULL,
	CONSTRAINT PK_AlbumSong PRIMARY KEY(albumID, songID),
	CONSTRAINT FK_AlbumSong_Album
	FOREIGN KEY(albumID) REFERENCES ALBUM(albumID),
	CONSTRAINT FK_AlbumSong_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID)
);

CREATE TABLE PLAYLIST(
	playListID INT IDENTITY(1,1) PRIMARY KEY,
	playListName VARCHAR(100) NOT NULL,
	userID INT NOT NULL,
	isPublic TINYINT NOT NULL DEFAULT 1,
	createDate DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT FK_PlayList_User
	FOREIGN KEY(userID) REFERENCES USERS(userID)
);

CREATE TABLE PLAYLIST_SONG(
	playListID INT NOT NULL,
	songID INT NOT NULL,
	addDate DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT PK_PlayListSong PRIMARY KEY(playListID, songID),
	CONSTRAINT FK_PlayListSong_PlayList
	FOREIGN KEY(playListID) REFERENCES PLAYLIST(playListID),
	CONSTRAINT FK_PlayListSong_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID)
);

CREATE TABLE FAVORITE_SONG(
	userID INT NOT NULL,
	songID INT NOT NULL,

	CONSTRAINT PK_FavoriteSong PRIMARY KEY(userID, songID),
	CONSTRAINT FK_FavoriteSong_User
	FOREIGN KEY(userID) REFERENCES USERS(userID),
	CONSTRAINT FK_FavoriteSong_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID)
);

CREATE TABLE LISTENING_HISTORY(
	userID INT NOT NULL,
	songID INT NOT NULL,
	listenedAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT PK_Listening_History PRIMARY KEY(userID, songID, listenedAt),
	CONSTRAINT FK_Listening_User
	FOREIGN KEY(userID) REFERENCES USERS(userID),
	CONSTRAINT FK_Listening_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID)
);

CREATE TABLE SONG_SHARE(
	userID INT NOT NULL,
	songID INT NOT NULL,
	shareAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT PK_SongShare PRIMARY KEY(userID, songID, shareAt),
	CONSTRAINT FK_SongShare_User
	FOREIGN KEY(userID) REFERENCES USERS(userID),
	CONSTRAINT FK_SongShare_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID)
);

CREATE TABLE ARTIST_FOLLOW(
	userID INT NOT NULL,
	artistID INT NOT NULL,

	CONSTRAINT PK_ArtistFollow PRIMARY KEY(userID, artistID),
	CONSTRAINT FK_ArtistFollow_User
	FOREIGN KEY(userID) REFERENCES USERS(userID),
	CONSTRAINT FK_ArtistFollow_Artist
	FOREIGN KEY(artistID) REFERENCES ARTIST(artistID)
);

CREATE TABLE COMMENTS(
	commentID INT IDENTITY(1,1) PRIMARY KEY,
	userID INT NOT NULL,
	songID INT NOT NULL,
	content NVARCHAR(MAX) NOT NULL,
	createdAt DATETIME NOT NULL DEFAULT GETDATE(),
	[status] TINYINT NOT NULL DEFAULT 1,

	CONSTRAINT FK_Comment_User
	FOREIGN KEY(userID) REFERENCES USERS(userID),
	CONSTRAINT FK_Comment_Song
	FOREIGN KEY(songID) REFERENCES SONG(songID)
);

CREATE TABLE DONATION(
	donationID INT IDENTITY(1,1) PRIMARY KEY,
	userID INT NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	[message] NVARCHAR(255),
	paymentMethod NVARCHAR(50),
	[status] NVARCHAR(20),
	createAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT FK_Donation_User
	FOREIGN KEY(userID) REFERENCES USERS(userID)
);

CREATE TABLE NOTIFICATIONS(
	notificationID INT IDENTITY(1,1) PRIMARY KEY,
	userID INT NOT NULL,
	title NVARCHAR(100) NOT NULL,
	content NVARCHAR(255),
	[type] NVARCHAR(50),
	isRead TINYINT NOT NULL DEFAULT 0,
	createAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT FK_Notification_User
	FOREIGN KEY(userID) REFERENCES USERS(userID)
);

CREATE TABLE EMAIL_LOG(
	emailLogID INT IDENTITY(1,1) PRIMARY KEY,
	userID INT NOT NULL,
	email NVARCHAR(100) NOT NULL,
	[type] NVARCHAR(50),
	[status] NVARCHAR(20),
	sentAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT FK_EmailLog_User
	FOREIGN KEY(userID) REFERENCES USERS(userID)
);

INSERT INTO ROLES(roleName)
VALUES 
(N'ADMIN'),
(N'USER');

INSERT INTO USERS
(userName, email, password, fullName, birthday, gender, roleID)
VALUES
('admin', 'admin@music.com', '123456', N'Quản trị hệ thống', '2000-01-01', 'Male', 1),

('nhat', 'nhat@gmail.com', '123456', N'Hoàng Minh Nhật', '2004-05-10', 'Male', 2),

('user01', 'user01@gmail.com', '123456', N'Hoàng Quốc', '2003-03-15', 'Male', 2),

('user02', 'user02@gmail.com', '123456', N'Trần Thị Quý Lê', '2002-07-20', 'Female', 2);

INSERT INTO ARTIST
(artistName, description, debutDate)
VALUES
(N'Sơn Tùng M-TP', N'Ca sĩ nhạc pop hàng đầu Việt Nam', '2012-01-01'),
(N'Đen Vâu', N'Rapper với phong cách đời và triết lý', '2014-01-01'),
(N'Vũ.', N'Ca sĩ indie với nhạc chill', '2015-01-01'),
(N'MIN', N'Nữ ca sĩ Vpop', '2016-01-01');

INSERT INTO ALBUM
(albumName, releaseDate)
VALUES
(N'm-tp MTP', '2017-01-01'),
(N'Đen', '2019-01-01'),
(N'Bước Qua Mùa Cô Đơn', '2020-01-01');

INSERT INTO SONG
(title, duration, audioURL, releaseDate)
VALUES
(N'Lạc Trôi', 245, 'audio/lactroi.mp3', '2017-01-01'),
(N'Chạy Ngay Đi', 210, 'audio/chayngaydi.mp3', '2018-01-01'),
(N'Bài Này Chill Phết', 260, 'audio/chillphet.mp3', '2019-01-01'),
(N'Bước Qua Mùa Cô Đơn', 240, 'audio/buocquamua.mp3', '2020-01-01'),
(N'Có Em Chờ', 230, 'audio/coemcho.mp3', '2017-01-01'); -- SINGLE (không album)

INSERT INTO SONG_ARTIST(songID, artistID)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4);

INSERT INTO ALBUM_ARTIST(albumID, artistID)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO ALBUM_SONG(albumID, songID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

INSERT INTO PLAYLIST
(playListName, userID, isPublic)
VALUES
(N'Nhạc yêu thích', 2, 1),
(N'Nhạc chill buổi tối', 2, 1),
(N'Playlist cá nhân', 3, 0);

INSERT INTO PLAYLIST_SONG(playListID, songID)
VALUES
(1, 1),
(1, 3),
(2, 4),
(3, 2);

INSERT INTO FAVORITE_SONG(userID, songID)
VALUES
(2, 1),
(2, 3),
(3, 3),
(4, 4);

INSERT INTO LISTENING_HISTORY(userID, songID, listenedAt)
VALUES
(2, 1, DATEADD(MINUTE, -10, GETDATE())),
(2, 1, DATEADD(MINUTE, -5, GETDATE())),
(2, 1, GETDATE()),
(3, 1, DATEADD(MINUTE, -3, GETDATE())),
(3, 3, GETDATE());


INSERT INTO ARTIST_FOLLOW(userID, artistID)
VALUES
(2, 1),
(2, 2),
(3, 1),
(4, 3);

INSERT INTO COMMENTS(userID, songID, content)
VALUES
(2, 1, N'Nghe lại vẫn thấy hay'),
(3, 3, N'Bài này chill thật sự'),
(4, 4, N'Nghe buổi tối rất hợp');

INSERT INTO NOTIFICATIONS(userID, title, content, type)
VALUES
(2, N'Chào mừng', N'Chào mừng bạn đến với hệ thống nghe nhạc', 'SYSTEM'),
(2, N'Playlist mới', N'Playlist của bạn vừa được cập nhật', 'PLAYLIST');

INSERT INTO EMAIL_LOG(userID, email, type, status)
VALUES
(2, 'nhat@gmail.com', 'REGISTER', 'SENT'),
(3, 'user01@gmail.com', 'REGISTER', 'SENT');

INSERT INTO DONATION(userID, amount, message, paymentMethod, status)
VALUES
(2, 100000, N'Ủng hộ duy trì hệ thống', 'MOMO', 'SUCCESS');
