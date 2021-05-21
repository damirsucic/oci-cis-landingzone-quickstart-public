# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# General
variable "service_label" {
    validation {
        condition     = length(regexall("^[A-Za-z][A-Za-z0-9]{1,7}$", var.service_label)) > 0
        error_message = "The service_label variable is required and must contain alphanumeric characters only, start with a letter and 8 character max."
  }
}

variable "tenancy_ocid" {}
variable "user_ocid" {
    default = ""
}
variable "fingerprint" {
    default = ""
}
variable "private_key_path" {
    default = ""
}
variable "private_key_password" {
    default = ""
}
variable "region" {
    validation {
        condition     = length(trim(var.region,"")) > 0
        error_message = "The region variable is required."
  }
}  

# Networking
variable "vcn_cidr" {
    default = "10.0.0.0/16"
    validation { 
        condition = length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$",var.vcn_cidr)) > 0
        error_message = "Invalid cidr block value provided for vcn_cidr variable."
    }
}
variable "public_subnet_cidr" {
    default = "10.0.1.0/24"
    validation { 
        condition = length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$",var.public_subnet_cidr)) > 0
        error_message = "Invalid cidr block value provided for public_subnet_cidr variable."
    }
}
variable "private_subnet_app_cidr" {
    default = "10.0.2.0/24"
    validation { 
        condition = length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$",var.private_subnet_app_cidr)) > 0
        error_message = "Invalid cidr block value provided for private_subnet_app_cidr variable."
    }
}
variable "private_subnet_db_cidr" {
    default = "10.0.3.0/24"
    validation { 
        condition = length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$",var.private_subnet_db_cidr)) > 0
        error_message = "Invalid cidr block value provided for private_subnet_db_cidr variable."
    }
}
variable "public_src_bastion_cidr" {
    validation {
        condition     = var.public_src_bastion_cidr != "0.0.0.0/0" && length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))?$",var.public_src_bastion_cidr)) > 0
        error_message = "The public_src_bastion_cidr variable value must be different than 0.0.0.0/0."
    }
}
variable "public_src_lbr_cidr" {
    default = "0.0.0.0/0"
    validation { 
        condition = length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$",var.public_src_lbr_cidr)) > 0
        error_message = "Invalid cidr block value provided for public_src_lbr_cidr variable."
    }
}
variable "is_vcn_onprem_connected" {
    default = false
    validation {
      condition = can(tobool(var.is_vcn_onprem_connected))
      error_message = "Invalid value provided for is_vcn_onprem_connected. Valid values: true or false."
    }
}
variable "onprem_cidr" {
    default = "0.0.0.0/0"
    validation { 
        condition = length(regexall("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$",var.onprem_cidr)) > 0
        error_message = "Invalid cidr block value provided for onprem_cidr variable."
    }
}

# Monitoring
variable "network_admin_email_endpoint" {
    validation { 
        condition = length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",var.network_admin_email_endpoint)) > 0
        error_message = "Invalid email address value provided for network_admin_email_endpoint variable."
    }
}
variable "security_admin_email_endpoint" {
    validation { 
        condition = length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",var.security_admin_email_endpoint)) > 0
        error_message = "Invalid email address value provided for security_admin_email_endpoint variable."
    }
}
variable "cloud_guard_configuration_status" {
  default = "ENABLED"
  validation {
      condition = var.cloud_guard_configuration_status == "ENABLED" || var.cloud_guard_configuration_status == "DISABLED"
      error_message = "Invalid value provided for cloud_guard_configuration_status. Valid values: ENABLED or DISABLED."
  }
}
variable "use_enclosing_compartment" {
    type    = bool
    default = false
    description = "Whether or not the Landing Zone compartments are created within an enclosing compartment. If unchecked, the Landing Zone compartments are created under the root compartment."
}
variable "existing_enclosing_compartment_ocid" {
    type    = string
    default = ""
    description = "The enclosing compartment where Landing Zone compartments will be created. If not provided and use_enclosing_compartment is true, an enclosing compartment is created under the root compartment."
}
/*
variable "use_existing_tenancy_policies" {
    type    = bool
    default = false
    description = "Whether or not required policies have already been created at the root compartment and must just be assigned to the Landing Zone groups. If unchecked, you must be sure the user executing this stack has permissions to create policies in the root compartment."
}
*/
variable "policies_in_root_compartment" {
    type    = string
    default = "CREATE"
    description = "Whether or not required policies at the root compartment should be created or simply used. If \"CREATE\", you must be sure the user executing this stack has permissions to create policies in the root compartment. If \"USE\", policies must have been created previously."
    validation {
      condition = var.policies_in_root_compartment == "CREATE" || var.policies_in_root_compartment == "USE"
      error_message = "Invalid value provided for policies_in_root_compartment. Valid values: CREATE or USE."
  }
}
variable "use_existing_iam_groups" {
    type    = bool
    default = false
    description = "Whether or not existing groups are to be reused for this Landing Zone. If unchecked, one set of groups is created. If checked, existing group names must be provided and this set will be able to manage resources in this Landing Zone."
}
variable "existing_iam_admin_group_name" {
    type    = string
    default = ""
}
variable "existing_cred_admin_group_name" {
    type    = string
    default = ""
}
variable "existing_security_admin_group_name" {
    type    = string
    default = ""
}
variable "existing_network_admin_group_name" {
    type    = string
    default = ""
}
variable "existing_appdev_admin_group_name" {
    type    = string
    default = ""
}
variable "existing_database_admin_group_name" {
    type    = string
    default = ""
}
variable "existing_auditor_group_name" {
    type    = string
    default = ""
}
variable "existing_announcement_reader_group_name" {
    type    = string
    default = ""
}
