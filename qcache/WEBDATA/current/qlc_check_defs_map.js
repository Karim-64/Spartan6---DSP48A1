var setupInfo = { "setupInfo" : [
{ "HOME_0IN" : "C:/QFT_2021.1/QFT_2021.1/QFT/V2021.1/win64" },{ "QHOME" : "C:/QFT_2021.1/QFT_2021.1/QFT/V2021.1/win64" },{ "ZSH" : "" },{ "ZI_RTLD_LIB" : "" }]};
var category = { "category" : [
{ "categoryId" : "0" , "categoryName":"Rtl Design Style" },
{ "categoryId" : "1" , "categoryName":"Simulation" },
{ "categoryId" : "2" , "categoryName":"Synthesis" },
{ "categoryId" : "3" , "categoryName":"Connectivity" },
{ "categoryId" : "4" , "categoryName":"Reset" },
{ "categoryId" : "5" , "categoryName":"Clock" },
{ "categoryId" : "6" , "categoryName":"Testbench" },
{ "categoryId" : "7" , "categoryName":"Nomenclature Style" },
{ "categoryId" : "8" , "categoryName":"Setup Checks" }]};
var severity = { "severity" : [
{ "severityId" : "0" , "severityName":"Error" },
{ "severityId" : "1" , "severityName":"Warning" },
{ "severityId" : "2" , "severityName":"Info" }]};
var statusObj = { "status" : [
{ "statusId" : "0" , "statusName":"uninspected" },
{ "statusId" : "1" , "statusName":"pending" },
{ "statusId" : "2" , "statusName":"waived" },
{ "statusId" : "3" , "statusName":"bug" },
{ "statusId" : "4" , "statusName":"fixed" },
{ "statusId" : "5" , "statusName":"verified" }]} ;
var checks = { "checks":[
{ "checksId":"0", "checksName":"assign_width_underflow","severityId":"0","categoryId":"0"},
{ "checksId":"1", "checksName":"const_reg_data","severityId":"2","categoryId":"3"},
{ "checksId":"2", "checksName":"unloaded_input_port","severityId":"2","categoryId":"3"},
{ "checksId":"3", "checksName":"ordered_port_connection","severityId":"1","categoryId":"3"},
{ "checksId":"4", "checksName":"multiplication_operator","severityId":"2","categoryId":"0"},
{ "checksId":"5", "checksName":"conditional_operator_nested","severityId":"2","categoryId":"0"},
{ "checksId":"6", "checksName":"reserved_keyword","severityId":"2","categoryId":"7"},
{ "checksId":"7", "checksName":"condition_const","severityId":"1","categoryId":"0"},
{ "checksId":"8", "checksName":"combo_loop","severityId":"0","categoryId":"1"},
{ "checksId":"9", "checksName":"assign_with_multi_arith_operations","severityId":"1","categoryId":"0"},
{ "checksId":"10", "checksName":"parameter_name_duplicate","severityId":"2","categoryId":"7"},
{ "checksId":"11", "checksName":"multi_ports_in_single_line","severityId":"2","categoryId":"0"},
{ "checksId":"12", "checksName":"mux_select_const","severityId":"1","categoryId":"3"},
{ "checksId":"13", "checksName":"gen_label_missing","severityId":"2","categoryId":"0"},
{ "checksId":"14", "checksName":" ","severityId":"3","categoryId":"9"}]};
var schematicStatus = {  
"assign_width_underflow" : "off",
"const_reg_data" : "on",
"unloaded_input_port" : "on",
"ordered_port_connection" : "off",
"multiplication_operator" : "off",
"conditional_operator_nested" : "off",
"reserved_keyword" : "off",
"condition_const" : "off",
"combo_loop" : "on",
"assign_with_multi_arith_operations" : "off",
"parameter_name_duplicate" : "off",
"multi_ports_in_single_line" : "off",
"mux_select_const" : "on",
"gen_label_missing" : "off"};
var adaptiveModeStatus = {  
"assign_width_underflow" : "off",
"const_reg_data" : "off",
"unloaded_input_port" : "on",
"ordered_port_connection" : "off",
"multiplication_operator" : "off",
"conditional_operator_nested" : "off",
"reserved_keyword" : "off",
"condition_const" : "off",
"combo_loop" : "on",
"assign_with_multi_arith_operations" : "off",
"parameter_name_duplicate" : "on",
"multi_ports_in_single_line" : "off",
"mux_select_const" : "off",
"gen_label_missing" : "off"};
var checkAliasMap = { };
var argMap = {  
"1":"lhs_expression",
"2":"lhs_width",
"3":"rhs_width",
"4":"module",
"5":"file",
"6":"line",
"7":"signal",
"8":"port",
"9":"name",
"10":"reason",
"11":"size",
"12":"loop",
"13":"expression",
"14":"count",
"15":"parameter",
"16":"module1",
"17":"file1",
"18":"line1",
"19":"module2",
"20":"file2",
"21":"line2",
"22":"genblock"};
