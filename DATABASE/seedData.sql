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
