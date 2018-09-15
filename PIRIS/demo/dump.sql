INSERT INTO `piris`.`City` (`name`) VALUES ('city1');
INSERT INTO `piris`.`City` (`name`) VALUES ('city2');
INSERT INTO `piris`.`City` (`name`) VALUES ('city3');

INSERT INTO `piris`.`marital_status` (`value`) VALUES ('zhenat');
INSERT INTO `piris`.`marital_status` (`value`) VALUES ('ne_zhenat!');

INSERT INTO `piris`.`disability` (`value`) VALUES ('1');
INSERT INTO `piris`.`disability` (`value`) VALUES ('2');
INSERT INTO `piris`.`disability` (`value`) VALUES ('3');

INSERT INTO `piris`.`citizen_ship` (`value`) VALUES ('belarus');
INSERT INTO `piris`.`citizen_ship` (`value`) VALUES ('russia');
INSERT INTO `piris`.`citizen_ship` (`value`) VALUES ('ukraine');

INSERT INTO `piris`.`passport` (`series`, `number`, `number_id`, `issued_by`, `issue_date`, `reg_addr`) VALUES ('HB', '2691232', 'qwer123456789', 'HZ', '23.10.17', 'HZ_ADDR');

INSERT INTO `piris`.`address` (`address`, `tel`, `city_id`) VALUES ('HZ_ADDRR', '375-29-149-73-59', '1');

INSERT INTO `piris`.`client` (`name`, `surname`, `patronymic`, `sex`, `date_of_birth`, `is_pensioner`, `monthly_income`, `place_of_birth`, `mob_tel`, `cs_id`, `ms_id`, `address_id`, `passport_id`, `disability_id`) VALUES ('name1', 'surname1', 'patr1', 'M', '1998.05.03', '0', '123', 'HZ_PLACE', '375-29-149-73-58', '1', '1', '1', '1', '1');