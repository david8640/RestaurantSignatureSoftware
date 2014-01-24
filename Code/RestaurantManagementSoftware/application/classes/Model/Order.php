<?php

/* 
 * <copyright file="Order.php" company="RestaurantManagementSoftware">
 *     Copyright (c) 2013, 2014 All Right Reserved
 * </copyright>
 * <author>Andrew Assaly</author>
 * <date>2014-01-19</date>
 * <summary>Model representing an order.</summary>
 */
class Model_Order extends Model {
    // Private members
    private $idOrder;
    private $idRestaurant;
    private $subtotal;
    private $shippingCost;
    private $taxes;
    private $totalCost;
    private $state;
     
    /**
     * Constructor of a Order model
     * @param int $idOrder the id of the order
     * @param int $idRestaurant the id of the restaurant
     * @param string $dateOrdered the date ordered
     * @param string $dateDelivered the date delivered
     * @param double $subtotal the subtotal of the order
     * @param double $shippingCost the shipping cost of the order
     * @param double $taxes the taxes of the order
     * @param double $totalCost the total cost of the order
     * @param int $state the state of the order
     */
    public function __construct($idOrder, $idRestaurant, $subtotal, $shippingCost, 
                                $taxes, $totalCost, $state) {
        $this->setOrderID($idOrder);
        $this->setRestaurantID($idRestaurant);
        $this->setSubtotal($subtotal);
        $this->setShippingCost($shippingCost);
        $this->setTaxes($taxes);
        $this->setTotalCost($totalCost);
        $this->setState($state);
    }
   
    // Getters and setters
    /**
     * get the id of the order
     * @param int $idOrder 
     */
    public function getOrderID($idOrder) {
        return $this->idOrder;
    }

    /**
     * Set the id of the order
     * @param int $idOrder 
     */
    public function setOrderID($idOrder) {
        $this->idOrder = $idOrder;
    }
    /**
     * get the id of the restaurant
     * @param int $idRestaurant 
     */
    public function getRestaurantID($idRestaurant) {
        return $this->idRestaurant;
    }

    /**
     * Set the id of the restaurant
     * @param int $idRestaurant 
     */
    public function setRestaurantID($idRestaurant) {
        $this->idRestaurant = $idRestaurant;
    }
    
    /**
     * get the subtotal of the order
     * @param double $subtotal 
     */
    public function getSubtotal($subtotal) {
        return $this->dateDelivered;
    }
    
    /**
     * Set the subtotal of the order
     * @param double $subtotal
     */
    public function setSubtotal($subtotal) {
        $this->subtotal = $subtotal;
    }
    
    /**
     * get the shipping cost of the order
     * @param double $shippingCost 
     */
    public function getShippingCost($shippingCost) {
        return $this->shippingCost;
    }
    
    /**
     * Set the shipping cost of the order
     * @param double $shippingCost
     */
    public function setShippingCost($shippingCost) {
        $this->shippingCost = $shippingCost;
    }
    
    /**
     * get the taxes of the order
     * @param double $taxes 
     */
    public function getTaxes($taxes) {
        return $this->taxes;
    }
    
    /**
     * Set the taxes of the order
     * @param double $taxes
     */
    public function setTaxes($taxes) {
        $this->taxes = $taxes;
    }
    
    /**
     * get the total cost of the order
     * @param double $totalCost 
     */
    public function getTotalCost($totalCost) {
        return $this->totalCost;
    }
    
    /**
     * Set the total cost of the order
     * @param double $totalCost
     */
    public function setTotalCost($totalCost) {
        $this->totalCost = $totalCost;
    }
    
    /**
     * get the state of the order
     * @param int $state
     */
    public function getState($state) {
        return $this->state;
    }
    
    /**
     * Set the state of the order
     * @param int $state
     */
    public function setState($state) {
        $this->state = $state;
    }
}

?>