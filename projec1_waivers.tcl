# ==========================================================================
# Status Commands 
# Version 2021.1 4558100 win64 28-Jan-2021
# Timestamp     : 2025-02-23 17:46:25
# Description   : Provides list of commands associated with the status(s) that are exported from GUI.
# Design        : DSP48A1
# Database      : D:/Digital_Design/Project_1/lint.db
# ==========================================================================


lint report item  -arg lhs_width=49  -arg rhs_width=48  -arg module=DSP48A1  -arg lhs_expression={cout,post_add_sub}  -arg file=design.v  -check {assign_width_underflow} -rtl_id {a7b96903_00200} -status {waived}

# Completed writing status commands 
# ==========================================================================



# ==========================================================================
# Appended Status Commands 
# Version 2021.1 4558100 win64 28-Jan-2021
# Timestamp     : 2025-02-23 17:54:18


lint report item  -arg lhs_width=49  -arg rhs_width=48  -arg module=DSP48A1  -arg lhs_expression={cout,post_add_sub}  -arg file=design.v  -check {assign_width_underflow} -rtl_id {a7b96903_00200} -status {waived}

# Completed writing status commands 
# ==========================================================================



# ==========================================================================
# Appended Status Commands 
# Version 2021.1 4558100 win64 28-Jan-2021
# Timestamp     : 2025-03-05 17:54:49


lint report item  -arg lhs_width=49  -arg rhs_width=48  -arg module=DSP48A1  -arg lhs_expression={cout,post_add_sub}  -arg file=design.v  -check {assign_width_underflow} -rtl_id {a7b96903_00200} -status {waived}
lint report item  -arg size=13  -arg module=mux4  -arg {loop=m10.b > m10.out > post_add > ... > x_mux > p > m10.b}  -arg file=mux4.v  -check {combo_loop} -status {waived}

# Completed writing status commands 
# ==========================================================================

