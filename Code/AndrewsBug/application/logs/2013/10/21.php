<?php defined('SYSPATH') OR die('No direct script access.'); ?>

2013-10-21 12:19:05 --- EMERGENCY: Exception [ 0 ]: Executing query failed.\nConnection to database failed.\nexception 'PDOException' with message 'SQLSTATE[42000] [1049] Unknown database 'restaurantmanagementware'' in /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/AbstractRepository.php:77
Stack trace:
#0 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/AbstractRepository.php(77): PDO->__construct('mysql:host=loca...', 'root', 'root')
#1 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/AbstractRepository.php(57): Repository_AbstractRepository->connect()
#2 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php(49): Repository_AbstractRepository->execute('insert into sup...', Array)
#3 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Supplier.php(14): Repository_Supplier->add(Object(Model_Supplier))
#4 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Supplier->action_findAll()
#5 [internal function]: Kohana_Controller->execute()
#6 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Supplier))
#7 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#8 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#9 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Index.php(13): Kohana_Request->execute()
#10 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Index->action_index()
#11 [internal function]: Kohana_Controller->execute()
#12 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Index))
#13 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#14 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#15 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/index.php(118): Kohana_Request->execute()
#16 {main} ~ APPPATH/classes/Repository/AbstractRepository.php [ 63 ] in /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php:49
2013-10-21 12:19:05 --- DEBUG: #0 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php(49): Repository_AbstractRepository->execute('insert into sup...', Array)
#1 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Supplier.php(14): Repository_Supplier->add(Object(Model_Supplier))
#2 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Supplier->action_findAll()
#3 [internal function]: Kohana_Controller->execute()
#4 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Supplier))
#5 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#6 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#7 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Index.php(13): Kohana_Request->execute()
#8 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Index->action_index()
#9 [internal function]: Kohana_Controller->execute()
#10 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Index))
#11 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#12 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#13 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/index.php(118): Kohana_Request->execute()
#14 {main} in /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php:49
2013-10-21 12:19:33 --- EMERGENCY: Exception [ 0 ]: Executing query failed.\nConnection to database failed.\nexception 'PDOException' with message 'SQLSTATE[42000] [1049] Unknown database 'restaurantmanagemensoftware'' in /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/AbstractRepository.php:77
Stack trace:
#0 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/AbstractRepository.php(77): PDO->__construct('mysql:host=loca...', 'root', 'root')
#1 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/AbstractRepository.php(57): Repository_AbstractRepository->connect()
#2 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php(49): Repository_AbstractRepository->execute('insert into sup...', Array)
#3 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Supplier.php(14): Repository_Supplier->add(Object(Model_Supplier))
#4 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Supplier->action_findAll()
#5 [internal function]: Kohana_Controller->execute()
#6 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Supplier))
#7 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#8 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#9 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Index.php(13): Kohana_Request->execute()
#10 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Index->action_index()
#11 [internal function]: Kohana_Controller->execute()
#12 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Index))
#13 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#14 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#15 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/index.php(118): Kohana_Request->execute()
#16 {main} ~ APPPATH/classes/Repository/AbstractRepository.php [ 63 ] in /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php:49
2013-10-21 12:19:33 --- DEBUG: #0 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php(49): Repository_AbstractRepository->execute('insert into sup...', Array)
#1 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Supplier.php(14): Repository_Supplier->add(Object(Model_Supplier))
#2 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Supplier->action_findAll()
#3 [internal function]: Kohana_Controller->execute()
#4 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Supplier))
#5 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#6 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#7 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Controller/Index.php(13): Kohana_Request->execute()
#8 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Controller.php(84): Controller_Index->action_index()
#9 [internal function]: Kohana_Controller->execute()
#10 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Index))
#11 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#12 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/system/classes/Kohana/Request.php(986): Kohana_Request_Client->execute(Object(Request))
#13 /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/index.php(118): Kohana_Request->execute()
#14 {main} in /Users/andrew/Documents/seg4910-project/Code/RestaurantManagementSoftware/application/classes/Repository/Supplier.php:49