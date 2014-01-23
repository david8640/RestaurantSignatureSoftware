<?php

/* 
 *  <copyright file="Controller_Product.php" company="RestaurantManagementSoftware">
 *     Copyright (c) 2013, 2014 All Right Reserved
 *  </copyright>
 *  <author>Omar Hijazi</author>
 *  <date>2013-11-07</date>
 *  <summary>The controller that handle all the manipulation on products.</summary>
 */
class Controller_Product extends Controller {
    /**
     * Get all the products.
     */
    public function action_findAll() {
        // Get all the informations from the repository.
        $repo = new Repository_Product();
        $product = $repo->getAll();
        
        // Transfert the information to the view.
        $view = View::factory('sproduct/products')
                    ->set('products', $products);
        
        $this->response->body($view);
    }
    
    /**
     * Initiate the creation of a product.
     */
    public function action_create() {
        $view = View::factory('product/product');
        $this->response->body($view);
    }
    
    /**
     * Add a product.
     */
    public function action_add() {
        if (isset($_POST) && Valid::not_empty($_POST)) {
            $post = $this->getValidationFactory($_POST);
            $product = new Model_Product(-1, $post['name']);
            
            if ($post->check()) {
                // Add the product
                $repo = new Repository_Product();
                $success = $repo->add($product);
        
                // Redirect if the add was successful
                if ($success) {
                    Session::instance()->set('feedbackMessage', array('The product was added.'));
                    $this->redirect ('index/index');
                }
            } else {
                // Invalid fields
                $feedbackMessage = $post->errors('product');
            }
            
            $view = View::factory('product/product')
                    ->set('product', $product)
                    ->set('feedbackMessage', $feedbackMessage)
                    ->set('submitAction', 'product/add');
            $this->response->body($view);
        } else {
            // Empty POST
            Session::instance()->set('feedbackMessage', array('An error occured.'));
            $this->redirect ('index/index');
        }
    }
    
    /**
     * Initiate the edition of a product.
     */
    public function action_edit() {
        $id = $this->request->param('id');
        // Validate id
        if (!(Valid::not_empty($id) && Valid::numeric($id))) {
            Session::instance()->set('feedbackMessage', array('Invalid product id.'));
            $this->redirect ('index/index');
        }
        
        // Get the product to edit
        $repo = new Repository_Product();
        $product = $repo->get($id);

        // The id do not refer to a valid product
        if (!is_object($product)) {
            Session::instance()->set('feedbackMessage', array('Invalid product id.'));
            $this->redirect ('index/index');
        }

        $view = View::factory('product/product')
                ->set('product', $product)
                ->set('submitAction', 'product/update');
        
        $this->response->body($view);
    }
    
    /**
     * Update a product.
     */
    public function action_update() {
        if (isset($_POST) && Valid::not_empty($_POST)) {
            $post = $this->getValidationFactory($_POST);
            $product = new Model_Product($post['id']);
            
            if ($post->check()) {
                // Update the product
                $repo = new Repository_Product();
                $success = $repo->update($product);
                
                // Redirect if the update was successful
                if ($success) {
                    Session::instance()->set('feedbackMessage', array('The product was updated.'));
                    $this->redirect ('index/index');
                }
            } else {
                // Invalid fields
                $feedbackMessage = $post->errors('product');
            }
            
            $view = View::factory('product/product')
                    ->set('product', $product)
                    ->set('feedbackMessage', $feedbackMessage)
                    ->set('submitAction', 'product/update');
        
            $this->response->body($view);
        } else {
            // Empty POST
            Session::instance()->set('feedbackMessage', array('An error occured.'));
            $this->redirect ('index/index');
        }
    }
    
    /**
     * Delete a product.
     */
    public function action_delete() {
        $id = $this->request->param('id');
        // Validate id
        if (!(Valid::not_empty($id) && Valid::numeric($id))) {
            Session::instance()->set('feedbackMessage', array('Invalid product id.'));
            $this->redirect ('index/index');
        }
        
        // Delete the product
        $repo = new Repository_Product();
        $success = $repo->delete($id);
        
        // Delete failed
        if (!$success) {
            Session::instance()->set('feedbackMessage', array('An error occuring while deleting the product.'));
            $this->redirect ('index/index');
        }
        
        // Delete succeed
        Session::instance()->set('feedbackMessage', array('The product was deleted.'));
        $this->redirect ('index/index');
    }
    
    /**
     * Get the validation object.
     * @param $_POST The post variable of the request
     * @return Validation::factory
     */
    private function getValidationFactory($post) {
        return Validation::factory($post)
                ->rule('name', 'not_empty')
                ->rule('name', 'max_length', array(':value', 100));
    }
}

?>