-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 10, 2011 at 02:14 AM
-- Server version: 5.1.53
-- PHP Version: 5.3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `introtodbs`
--

-- --------------------------------------------------------

--
-- Table structure for table `apply`
--

CREATE TABLE IF NOT EXISTS `apply` (
  `sID` int(5) NOT NULL,
  `cName` varchar(21) NOT NULL,
  `major` varchar(30) NOT NULL,
  `decision` varchar(3) NOT NULL,
  KEY `major` (`major`),
  KEY `cName` (`cName`),
  KEY `sID` (`sID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apply`
--

INSERT INTO `apply` (`sID`, `cName`, `major`, `decision`) VALUES
(123, 'Stanford', 'CS', 'Y'),
(123, 'Berkeley', 'CS', 'Y'),
(123, 'Stanford', 'EE', 'N'),
(123, 'Cornell', 'EE', 'Y'),
(234, 'Berkeley', 'biology', 'N'),
(345, 'MIT', 'bioengineering', 'Y'),
(345, 'Cornell', 'bioengineering', 'N'),
(345, 'Cornell', 'CS', 'Y'),
(345, 'Cornell', 'EE', 'N'),
(678, 'Stanford', 'History', 'Y'),
(987, 'Stanford', 'CS', 'Y'),
(987, 'Berkeley', 'CS', 'Y'),
(876, 'Berkeley', 'CS', 'N'),
(876, 'MIT', 'biology', 'Y'),
(876, 'MIT', 'marine biology', 'N'),
(765, 'Stanford', 'History', 'Y'),
(765, 'Cornell', 'History', 'N'),
(765, 'Cornell', 'psychology', 'Y'),
(543, 'MIT', 'CS', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `college`
--

CREATE TABLE IF NOT EXISTS `college` (
  `cName` varchar(21) NOT NULL,
  `State` varchar(21) NOT NULL,
  `Enrollment` int(12) NOT NULL,
  PRIMARY KEY (`cName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `college`
--

INSERT INTO `college` (`cName`, `State`, `Enrollment`) VALUES
('Stanford', 'CA', 15000),
('Berkeley', 'CA', 36000),
('MIT', 'MA', 10000),
('Cornell', 'NY', 21000);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `sID` int(5) NOT NULL,
  `sName` varchar(21) NOT NULL,
  `sizeHS` int(5) NOT NULL,
  `GPA` decimal(5,2) NOT NULL,
  PRIMARY KEY (`sID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`sID`, `sName`, `sizeHS`, `GPA`) VALUES
(234, 'Bob', 1500, '3.60'),
(123, 'Amy', 1000, '3.90'),
(345, 'Craig', 500, '3.50'),
(456, 'Doris', 1000, '3.90'),
(567, 'Edward', 2000, '2.90'),
(678, 'Fay', 200, '3.80'),
(789, 'Gary', 800, '3.40'),
(987, 'Helen', 800, '3.70'),
(876, 'Irene', 400, '3.90'),
(765, 'Jay', 1500, '2.90'),
(654, 'Amy', 1000, '3.90'),
(543, 'Craig', 2000, '3.40');
