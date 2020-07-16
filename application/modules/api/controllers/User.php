<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class User extends REST_Controller {
	function __construct() 
	{
		parent::__construct();
		$this->load->helper('url');
		$this->load->helper('form');
		$this->load->library('session');
		$this->load->library('common_library');
		$this->load->model('User_model');
	}

	/**   @SWG\Post(
	 *     path="/User/userSignup",
	 *     tags={"user"},
	 *     summary="signup user profile",
	 *     description="user signup",
	 *   @SWG\Parameter(
	 *     in="body",
	 *     name="body",
	 *     description="first_name,last_name,email,password,phone_number,role_type are required params",
	 *     required=true,
	 *     @SWG\Schema(ref="#/definitions/UserSignup")
	 *   ),
	 *   @SWG\Response(response="200", description="Successful operation")
	 * )
	 */
	public function userSignup_post() {
		/*Defined validation rules*/
		$rules = array(
			array('field' => 'first_name', 'label' => 'first_name', 'rules' => 'required'),
			array('field' => 'last_name', 'label' => 'last_name', 'rules' => 'required'),
			array('field' => 'email', 'label' => 'email', 'rules' => 'required|valid_email|is_unique[users.email]'),
			array('field' => 'password', 'label' => 'password', 'rules' => 'required'),
			array('field' => 'phone_number', 'label' => 'phone_number', 'rules' => 'required'),
			array('field' => 'role_type', 'label' => 'role_type', 'rules' => 'required'),
		);
		$postData = $this->post(); // stores all data from post()
		$validation= $this->common_library->validate_fields($rules, $postData);// used for validation of entries
		if ($validation['success']) { // if success is true
			$password = password_hash($postData['password'],PASSWORD_DEFAULT); // used for encrypting password for storing it
			$userData = array(
				'first_name'   => $postData['first_name'],
				'last_name'    => $postData['last_name'],
				'email'        => $postData['email'],
				'password'     => $password,
				'phone_number'     => $postData['phone_number'],
				'role_type'     => $postData['role_type'],
				'created_on'   => time(),//to get the current time in timestam
				'accesskey' => random_string('alnum', 32) //generating access token
			);
			// for inserting data in users table
			$lastInsertId = $this->User_model->insert($tableName = 'users', $userData);
			if(empty($lastInsertId)) {// if last id is not generated
				$this->response([
					'success'=> FALSE,
					'message'=>'Something went wrong'],
					REST_Controller::HTTP_BAD_REQUEST);
			} else {							
				$this->response([
					'success'=>TRUE,
					'message'=>'User successfully signup.',
				]);				
			}
		} else {
			//for setting validation message
			$this->response($validation, REST_Controller::HTTP_BAD_REQUEST);
		}
	}

	
	/**
	 * @SWG\Get(
	 *  path="/User/getAllUsers",
	 *  tags={"user"},
	 *  summary="To get all Users",
	 *  @SWG\Response(
	 *      response="200",
	 *      description="Sample result",
	 *      @SWG\Schema(type="array", @SWG\Items(ref="#/definitions/GetAllUsers"))
	 *  )
	 * )
	 */

	//for listing all wall posts
	public function getAllUsers_get() {
    	$getallusers= $this->User_model->getAllUsers('users');
		if(empty($getallusers)){
			/* if no posts are in database */
			$this->response([
				'success'=> FALSE,
				'error'=> 'Posts not found.'
			],
			REST_Controller::HTTP_BAD_REQUEST);
		} else{
			/* get all the posts */
			$this->response([
				'success'=> TRUE,
				'data'=> $getallusers
			],
			REST_Controller::HTTP_OK);
		}
	}

	/**   @SWG\Post(
	 *     path="/User/getUsersByRoleType",
	 *     tags={"user"},
	 *     summary="Users by role types",
	 *     description="user signup",
	 *   @SWG\Parameter(
	 *     in="body",
	 *     name="body",
	 *     description="role_type is required params",
	 *     required=true,
	 *     @SWG\Schema(ref="#/definitions/GetAllUsersByRole")
	 *   ),
	 *   @SWG\Response(response="200", description="Successful operation")
	 * )
	 */

	//for listing all wall posts
	public function getUsersByRoleType_post() {
		$rules = array(
						array('field' => 'role_type', 'label' => 'role_type', 'rules' => 'required')
					);
		$postdata=$this->post();
		/* for passing validation */
		$validation = $this->common_library->validate_fields($rules, $postdata);

		if($validation['success']) {
			$getusers= $this->User_model->get('users', array('role_type'=>$postdata['role_type']), '*');
			if(empty($getusers)){
				/* if no posts are in database */
				$this->response([
					'success'=> FALSE,
					'error'=> 'Posts not found.'
				],
				REST_Controller::HTTP_BAD_REQUEST);
			} else{
				/* get all the posts */
				$this->response([
					'success'=> TRUE,
					'data'=> $getusers
				],
				REST_Controller::HTTP_OK);
			}
		} else {
			//for setting validation message
			$this->response($validation, REST_Controller::HTTP_BAD_REQUEST);
		}


    	
	}

	/**   @SWG\Post(
	 *     path="/User/delete",
	 *     tags={"user"},
	 *     summary="Delete Walls",
	 *     description="Deleting wall posts",
	 *    @SWG\Parameter(
     *       name="accesskey",
     *       in="header",
     *       description="user authentication key",
     *       required=true,
     *       type="string"
     *         ),
	 *   @SWG\Parameter(
	 *     in="body",
	 *     name="data",
	 *     description="id is required param",
	 *     required=true,
	 *     @SWG\Schema(ref="#/definitions/Delete")
	 *   ),
	 *   @SWG\Response(response="200", description="Successful operation")
	 * )
	 */

    /* for deleting posts*/
    public function delete_post() {
    	$rules = array(
						array('field' => 'id', 'label' => 'id', 'rules' => 'required|is_natural_no_zero')
					);
		$postdata=$this->post();
		/* for passing validation */
		$validation = $this->common_library->validate_fields($rules, $postdata);
		if($validation['success']) {
			// check if authentication is verified
			if($this->authentication($postdata['id'])) {
				/* if post is present with this post_id */
				$check_If_Id_Exist=$this->User_model->get('users', array('id'=>$postdata['id']), '*');
				// if post_id is present
				if(!empty($check_If_Id_Exist)) {
					$deletePost= $this->User_model->delete(array('id'=>$check_If_Id_Exist[0]['id']), 'users');
					if(!empty($deletePost)) {
						$this->response([
							'success'=> TRUE,
							'message'=> 'Successfully deleted.'
						],
						REST_Controller::HTTP_BAD_REQUEST);
					} else{
						$this->response([
							'success'=> FALSE,
							'message'=> 'Could not delete post.'
						],
						REST_Controller::HTTP_BAD_REQUEST);
					}
				} else {
					$this->response([
						'success'=> FALSE,
						'message'=> 'Post_id and user_id do not match'
					],
					REST_Controller::HTTP_BAD_REQUEST);
				}
			}
		} else {
			//for setting validation message
			$this->response($validation, REST_Controller::HTTP_BAD_REQUEST);
		}
    }


	/**   @SWG\Post(
	 *     path="/User/update",
	 *     tags={"user"},
	 *     summary="Update Users",
	 *     description="Editing Users details",
	 *    @SWG\Parameter(
     *       name="accesskey",
     *       in="header",
     *       description="user authentication key",
     *       required=true,
     *       type="string"
     *         ),
	 *   @SWG\Parameter(
	 *     in="body",
	 *     name="data",
	 *     description="user_id is required param and any one from username, email, password, first_name, last_name, phone_number, role_type is required param",
	 *     required=true,
	 *     @SWG\Schema(ref="#/definitions/Update")
	 *   ),
	 *   @SWG\Response(response="200", description="Successful operation")
	 * )
	 */

    /* for updating posts */
    public function update_post() {
    	$rules = array(
						array('field' => 'id', 'label' => 'id', 'rules' => 'required|is_natural_no_zero')
					);
		$postdata=$this->post();
		/* for passing validation */
		$validation = $this->common_library->validate_fields($rules, $postdata);
		/* if validation is successfull */
		if($validation['success']) {
			// check if authentication is verified
			if($this->authentication($postdata['id'])) {
				/* if post is present with this post_id */
				$check_If_Id_Exist=$this->User_model->get('users', array('id'=>$postdata['id']), '*');
				// if post_id is present
				if(!empty($check_If_Id_Exist)) {
					
					/* new array for storing updated values */
					$editData= array();
					if(!empty($postdata['username'])) {
						$editData['username']=$postdata['username'];
					}
					if(!empty($postdata['email'])) {
						$editData['email']=$postdata['email'];
					}
					if(!empty($postdata['password'])) {
						$editData['password']=$postdata['password'];
						$editData['password']= password_hash($editData['password'],PASSWORD_DEFAULT);
					}
					if(!empty($postdata['first_name'])) {
						$editData['first_name']=$postdata['first_name'];
					}
					if(!empty($postdata['last_name'])) {
						$editData['last_name']=$postdata['last_name'];
					}
					if(!empty($postdata['phone_number'])) {
						$editData['phone_number']=$postdata['phone_number'];
					}
					if(!empty($postdata['role_type'])) {
						$editData['role_type']=$postdata['role_type'];
					}

					if(!isset($postdata['username']) && !isset($postdata['email']) && !isset($postdata['password']) && !isset($postdata['first_name']) && !isset($postdata['last_name']) && !isset($postdata['phone_number']) && !isset($postdata['role_type'])){
						$editData['updated_at']= time();// for update time
						/* get latest id after being updated */
						$lastEditedId = $this->User_model->update('users', $editData, array('id'=>$postdata['id']));
						if(!empty($lastEditedId)) {
							/* get details of last id which is being updated */
							$getPost= $this->User_model->get('users', array('id'=>$lastEditedId['id']), '*');
							if(!empty($getPost)) {
								$this->response([
									'success'=> TRUE,
									'message'=> 'Information successfully edited.',
									'data'=> $getPost[0]
								],
								REST_Controller::HTTP_OK);
							} else {
								$this->response([
									'success'=> FALSE,
									'message'=> 'Something went wrong.'
								],
								REST_Controller::HTTP_BAD_REQUEST);
							}
						} else {
							$this->response([
								'success'=> FALSE,
								'message'=> 'Information could not be updated.'
							],
							REST_Controller::HTTP_BAD_REQUEST);
						}
					} else {

						/* Checking if no value is inserted for editing */
						$post_value= array('username','email','password','first_name','last_name','phone_number','role_type');
						//print_r($editData);die;
						foreach ($post_value as $key) {
							$value[]= in_array($key, array_keys(array_filter($editData)));
						}
						if(empty(array_filter($value))) {
							$this->response([
								'success'=> FALSE,
								'message'=> 'Any one from text, audio, video, image, latitude or longitude should be filled for editing the post.'
							],
							REST_Controller::HTTP_BAD_REQUEST);
						} else {
							/* if value is present in editData to be edited */
							$editData['updated_at']= time();// for update time
							/* get latest id after being updated */
							$lastEditedId = $this->User_model->update('users', $editData, array('id'=>$postdata['id']));
							if(!empty($lastEditedId)) {
								/* get details of last id which is being updated */
								$getPost= $this->User_model->get('users', array('id'=>$lastEditedId['id']), '*');
								if(!empty($getPost)) {
									$this->response([
										'success'=> TRUE,
										'message'=> 'Information successfully edited.',
										'data'=> $getPost[0]
									],
									REST_Controller::HTTP_OK);
								} else {
									$this->response([
										'success'=> FALSE,
										'message'=> 'Something went wrong.'
									],
									REST_Controller::HTTP_BAD_REQUEST);
								}
							} else {
								$this->response([
									'success'=> FALSE,
									'message'=> 'Information could not be updated.'
								],
								REST_Controller::HTTP_BAD_REQUEST);
							}
						}
					}	
				
				// if id is not present
				} else {
					$this->response([
						'success'=> FALSE,
						'message'=> 'id do not exist'
					],
					REST_Controller::HTTP_BAD_REQUEST);
				}
			}
		} else {
			//for setting validation message
			$this->response($validation, REST_Controller::HTTP_BAD_REQUEST);
		}
    }


    //  token-based authentication to access all API's
	public function authentication($id){
		// for requesting access token in headers
        $accesskey=$this->input->request_headers('accesskey');
        //if access token is given
        if (isset($accesskey['accesskey'])) {
        	$where= array('accesskey'=>$accesskey['accesskey'], 'id'=>$id);
        	// verify if access token and user id is present in database
            if ($this->User_model->get('users', $where, '*')) {
                return 1;
            } else { 
            	// if accesskey do not match with id 
                $this->response(['success' => false, 'message' => 'Unauthorized Access'], 401);
            }
        } else {
        	// if no access key is provided
            $this->response(['success' => false,'message' => 'Access Forbidden'], 
              REST_Controller::HTTP_FORBIDDEN);
        }
    }



}