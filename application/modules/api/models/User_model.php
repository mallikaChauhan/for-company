<?php
if (!defined('BASEPATH')) {
	exit('No direct script access allowed');
}

class User_model extends CI_Model {

	 public function __construct()
      {
        $this->load->database();
      }

	// check if condition exist in users table
	function checkifuserexist($email,$password) 
	{
		$this->db->select('*');
    $this->db->from('users');
    $this->db->where('email', $email);
	  $query = $this->db->get();
	  $row = $query->row();
    if($query->num_rows() > 0)
  	{
    	$hash = $row->password;
      if (password_verify($password, $hash)) 
          return $query->result_array();
      else 
          return false;
  	}
  	else
    	return 0;
	}
  // to generate random string for image names.
  public function RandomString($length){
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.time();
    $string = '';
    for ($i = 0; $i < $length; $i++) {
        $string .= $characters[mt_rand(0, strlen($characters) - 1)];
    }
    return $string;
  }
	function checkUserExist($conditions = array()) 
	{
		$query = $this->db->get_where('users', $conditions);
		if($query->num_rows() > 0 ) 
        {
             return $query->row_array();
        }
        else
        { 
        	return false;
        }
	}
  public function update($table, $data, $id) {
    if (!empty($data) && !empty($id)) {
      $update = $this->db->update('users', $data, array('id' => $id['id']));
      if ($update) {
        return $id;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /*
         * Delete user data
  */
  public function delete($condition,$table) {
   
    $delete = $this->db->delete($table, $condition);
    return $delete ? true : false;
  }
 
  //to get all users
  public function getAllUsers($table) {
    $this->db->select('*');
    $this->db->from($table);
    $this->db->order_by("created_on", "desc");
    $query = $this->db->get();
    if($query->num_rows() > 0 ) {
        return $query->result();
    } else { 
      return false;
    }
  }

	// inserting data in given table
	function insert($table, $data)
	{
		if($this->db->insert($table, $data))
		{
      // returning the last id generated
			return $this->db->insert_id(); 
		}
		else
		{
			return false;
		}
	}
	// displaying data of the last generated id
	function get($table_name, $condition ,$select){
    $this->db->select($select);
    $this->db->from($table_name);
    $this->db->where($condition);
    $query = $this->db->get();
    if($query->num_rows() > 0)
    {
      return $query->result_array();
    }
    else
    {
      return 0;
    }
	}
  /*Check device exist or not*/
  public function checkDevice($data)
  {
    $num_rows = $this->db->select('*')->from('device_information')->where($data)->get()->num_rows();
    return $num_rows ;
  }
  /*deleteDeviceInfo used for delete user device info*/
  public function deleteDeviceInfo($data)
  {
    $isDeleted = $this->db->where($data)->delete('device_information');
    return $isDeleted;
  }
}