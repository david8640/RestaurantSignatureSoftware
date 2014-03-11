<?php
/*
 *  <copyright file="suppliers.php" company="RestaurantManagementSoftware">
 *     Copyright (c) 2013, 2014 All Right Reserved
 *  </copyright>
 *  <author>David Fortin</author>
 *  <date>2013-10-05</date>
 *  <summary>The view that print all the suppliers.</summary>
 */
?>
<h2>
    <div class="left">Suppliers</div> 
    <div class="button">    
        <?php echo HTML::anchor('supplier/create', '', array('class' => 'button_add', 'name' => 'Add')); ?>
    </div> 
    <div class="clear"></div>
</h2>
<table id="suppliers">
    <thead>
        <tr>
            <th class="id">Id</th>
            <th>Name</th>
            <th>Contact Name</th>
            <th>Phone Number</th>
            <th>Fax Number</th>
            <th class="edit">Edit</th>
            <th class="remove">Remove</th>
        </tr>
        <tr class="filter">
            <td><input class="search_init" type="text" value="Search names" name="search_id"></td>
            <td><input class="search_init" type="text" value="Search names" name="search_name"></td>
            <td><input class="search_init" type="text" value="Search contact name" name="search_contact_name"></td>
            <td><input class="search_init" type="text" value="Search phone number" name="search_phone_number"></td>
            <td><input class="search_init" type="text" value="Search fax number" name="search_fax_number"></td>
            <td></td>
            <td></td>
        </tr>
    </thead>
    <tfoot
        <tr role="row">
            <th class="id">Id</th>
            <th>Name</th>
            <th>Contact Name</th>
            <th>Phone Number</th>
            <th>Fax Number</th>
            <th class="edit">Edit</th>
            <th class="remove">Remove</th>
        </tr>
    </tfoot>
    <tbody>
        <?php foreach ($suppliers as $s) { ?>
            <tr>
                <td><?php echo $s->getId(); ?></td>
                <td><?php echo $s->getName(); ?></td>
                <td><?php echo $s->getContactName(); ?></td>
                <td><?php echo $s->getPhoneNumber(); ?></td>
                <td><?php echo $s->getFaxNumber(); ?></td>
                <td><?php echo HTML::anchor('supplier/edit/'.$s->getId(), '', array('class' => 'button_edit', 'name' => 'Edit')); ?></td>
                <td><?php echo HTML::anchor('supplier/delete/'.$s->getId(), '', array('class' => 'button_delete', 'name' => 'Delete')); ?></td>
            </tr>
        <?php } ?>
    </tbody>
</table>
<script>
    var nbOfHiddenColumn = 1;
    
    $(document).ready(function() {
        var oTable = $('#suppliers').dataTable( {
                "bSortCellsTop": true,
                "bStateSave": true,
                "bAutoWidth": false,
                "aoColumnDefs": [
                    { "bSortable": false, "bSearchable": false, "bVisible": false, "aTargets": [0] },
                    { "bSortable": false, "bSearchable": false, "aTargets": [5] },
                    { "bSortable": false, "bSearchable": false, "aTargets": [6] }
                ],
                "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
        });
            
        $("thead tr.filter input").keyup( function () {
            oTable.fnFilter( this.value, $("thead tr.filter input").index(this) + nbOfHiddenColumn );
        });
    });
</script>
