<?php
/*
 *  <copyright file="orders.php" company="RestaurantManagementSoftware">
 *     Copyright (c) 2013, 2014 All Right Reserved
 *  </copyright>
 *  <author>Andrew Assaly</author>
 *  <date>2014-01-19</date>
 *  <summary>The view that print all the orders of given restaurants.</summary>
 */
?>
<h2>Orders Placed</h2>
<table id="orders">
    <tr>
        <th class="id">Id</th>
        <th>Restaurant</th>
        <th>Ordered Date</th>
        <th>Subtotal</th>
        <th>Shipping</th>
        <th>Taxes</th>
        <th>Total</th>
        <th>State</th>
        <th class="view">View</th>
        <th class="edit">Edit</th>
        <th class="remove">Remove</th>
    </tr>
    <?php foreach ($orders as $o) { ?>
        <tr>
            <td><?php echo $o->getOrderID(); ?></td>
            <td><?php echo $o->getRestaurantName(); ?></td>
            <td><?php echo $o->getDateCreated(); ?></td>
            <td><?php echo $o->getSubtotal(); ?></td>
            <td><?php echo $o->getShippingCost(); ?></td>
            <td><?php echo $o->getTaxes(); ?></td>
            <td><?php echo $o->getTotalCost(); ?></td>
            <td><?php echo $o->getStateName(); ?></td>
            <td><?php echo HTML::anchor('order/view/'.$o->getOrderID().'/findAll', '', array('class' => 'button_view', 'name' => 'View')); ?></td>
            <td><?php 
                if ($o->getState() == Constants_OrderState::IN_PROGRESS) {
                    echo HTML::anchor('order/edit/'.$o->getOrderID().'/findAll', '', array('class' => 'button_edit', 'name' => 'Edit'));
                } else {
                    ?><span class="button_edit_disabled"></span><?php
                }
            ?></td>    
            <td><?php 
                if ($o->getState() == Constants_OrderState::IN_PROGRESS) {
                    echo HTML::anchor('order/delete/'.$o->getOrderID().'/findAll', '', array('class' => 'button_delete', 'name' => 'Delete'));
                } else {
                    ?><span class="button_delete_disabled"></span><?php
                }
            ?></td>
        </tr>
    <?php } ?>
</table>
<div class="button">
    <?php echo HTML::anchor('order/getStep1/-1/findAll', '', array('class' => 'button_add', 'name' => 'Add')); ?>
</div>
