update organizations_people
set
email_address_1 = null,
email_address_2 = null ,
encrypted_ssn = null ,
birth_date = null,
tax_id = null,
alternate_phone_number = null ,
location_phone = null ,
phone_business = null ,
phone_cell = null ,
phone_extension = null ,
phone_fax = null ,
phone_home = null ,
policy_number_code = null,
address_1='Test_Address',
address_2='Test_Address',
address_3='Test_Address';
go
update configuration set variable_value = '' where licensee_code = '<<licenseeCode>>' and variable = 'WhiteListedIPs';
update configuration set variable_value = '' where licensee_code = '<<licenseeCode>>' and variable = 'Copymailboxaddress';
go
update transmission_log set sent_to = '';
go

update configuration set variable_value = '' where licensee_code = '<<licenseeCode>>' and variable = 'WhiteListedIPs';
update configuration set variable_value = '' where licensee_code = '<<licenseeCode>>' and variable = 'Copymailboxaddress'; 
update transmission_log set sent_to = ''; 