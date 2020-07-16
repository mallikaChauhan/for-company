<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
|--------------------------------------------------------------------------
| Swagger Definitions
|--------------------------------------------------------------------------
| Example: https://github.com/zircote/swagger-php/tree/master/Examples/petstore.swagger.io/models
*/

// To avoid class naming conflicts when defining Swagger Definitions
namespace MySwaggerDefinitions;

/**
 * @SWG\Definition()
 */
class UserSignup {

	/**
	 * @var string
	 * @SWG\Property()
	 */
	public $first_name;

	/**
	 * @var string
	 * @SWG\Property()
	 */
	public $last_name;

	/**
	 * @var string
	 * @SWG\Property()
	 */
	public $email;

	/**
	 * @var string
	 * @SWG\Property()
	 */
	public $password;

	/**
	 * @var int
	 * @SWG\Property()
	 */
	public $phone_number;	

	/**
	 * @var string
	 * @SWG\Property()
	 */
	public $role_type;

}

/**
 * @SWG\Definition()
 */
class GetAllUsers {

	/**
	 * @var int
	 * @SWG\Property()
	 */
	public $user_id;
}

/**
 * @SWG\Definition()
 */
class UserSetting {

	/**
	 * @var string
	 * @SWG\Property(enum={"push_notification", "drink_bought_notification","offer_redeem_notification"," use_gydo_notification", "social_activity_notification", "email_me_notification"})
	 */
	public $notification_type;

	/**
	 * @var string
	 * @SWG\Property(enum={"on", "off"})
	 */
	public $status;
}

/**
 * @SWG\Definition()
 */
class Update {

     /**
      * @var int
      * @SWG\Property()
      */
     public $id;

     /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */
     public $username;

     /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */
     public $email;

     /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */

     public $password;

     /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */

     public $first_name;

     /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */
     public $last_name;

     /**
      * @var int
      * @SWG\Property()
      */
     public $phone_number;

     /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */
     public $role_type;

}

/**
 * @SWG\Definition()
 */
class GetAllUsersByRole {

    /**
     * @SWG\Property(
     *     type = "string",
     *     default = "",
     *     @SWG\Items(
     *         type = "string"
     *     )
     * )
     */
    public $role_type;

}

/**
 * @SWG\Definition()
 */
class Delete {

     /**
      * @var int
      * @SWG\Property()
      */
     public $id;

}
