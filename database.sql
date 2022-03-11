CREATE TABLE IF NOT EXISTS `users` (
  `neu` varchar(1) COLLATE utf8_bin DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `users` ADD COLUMN `neu` varchar(1) COLLATE utf8_bin DEFAULT '1';
ALTER TABLE `users` ADD PRIMARY KEY (`identifier`);
