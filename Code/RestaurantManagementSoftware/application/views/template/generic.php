<?php

/* 
 *  <copyright file="Generic.php" company="RestaurantManagementSoftware">
 *     Copyright (c) 2013, 2014 All Right Reserved
 *  </copyright>
 *  <author>David Fortin</author>
 *  <date>2013-10-05</date>
 *  <summary>The template page.</summary>
 */
?>
<!DOCTYPE HTML>
<html>
<head>
    <title><?php echo $title ?></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <?php echo HTML::style('application/style/style.css'); ?>
</head>
    <body>
        <?php
        if (Session::instance()->get('global_username') != '') {
            $global_username = Session::instance()->get_once('global_username');
        };
        
        if (!$hide_menu) { ?>
            <div class="menu">
                <ul>
                    <li><?php echo HTML::anchor('index/index', 'Home'); ?></li>
                    <li><?php echo HTML::anchor('supplier/findAll', 'Suppliers'); ?></li>
                    <li><?php echo HTML::anchor('productCategory/findAll', 'Product Categories'); ?></li>
                    <li><?php echo HTML::anchor('login/logout', 'Logout'); ?></li>
                </ul>
            </div><?php
            
            if (isset($global_username)) {
                echo 'Welcome back ' . $global_username;
            }
        }

        if (isset($feedbackMessage)) {
            $messages = $feedbackMessage;
        } elseif (Session::instance()->get('feedbackMessage') != '') {
            $messages = Session::instance()->get_once('feedbackMessage');
        } else {
            $messages = array();
        }

        foreach ($messages as $message):
            echo $message."<br/>";
        endforeach;

        echo $content
    ?>
    </body>
</html>
