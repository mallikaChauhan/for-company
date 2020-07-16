<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Common_library {
	private $CI;
	public function __construct() {
		$CI = &get_instance();
		$this->CI = &get_instance();
		$this->CI->load->library('form_validation');
	}

	public function validate_fields($rules = array(), $data = array()) {
		if (!empty($rules)) {
			$this->CI->form_validation->set_data($data);
			$this->CI->form_validation->set_rules($rules);

			if ($this->CI->form_validation->run() === FALSE) {
				$error = $this->CI->form_validation->error_array();
				$error = reset($error);
				$response['success'] = FALSE;
				$response['message'] = $error;
				return $response;
			} else {
				$response['success'] = TRUE;
				return $response;
			}
		}
	}
}