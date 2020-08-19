# DB 세팅
DROP DATABASE IF EXISTS `pp`;
CREATE DATABASE `pp`;
USE `pp`;

# article 테이블 세팅
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL,
    memberId INT(10) NOT NULL
);

# member 테이블 세팅
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME,
	updateDate DATETIME,
    delDate DATETIME,	
	delStatus TINYINT(1) NOT NULL DEFAULT 0,
	authStatus TINYINT(1) NOT NULL DEFAULT 0,
	loginId CHAR(20) NOT NULL UNIQUE,
	loginPw CHAR(100) NOT NULL,
	`name` CHAR(20) NOT NULL,
	`nickname` CHAR(20) NOT NULL UNIQUE,
	`email` CHAR(100) NOT NULL,
	`phoneNo` CHAR(20) NOT NULL,
	`division` CHAR(100) NOT NULL
);

# member 테이블에 테스트 데이터 삽입
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = SHA2('admin', 256),
`name` = '관리자',
`nickname` = '관리자',
`email` = '',
`phoneNo` = '',
`division` = 'sbs';

# article 테이블에 테스트 데이터 삽입
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
memberId = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
memberId = 1;