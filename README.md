FPGA-Based Digital Locker Security System

A digital combination lock system implemented in VHDL on a Basys 3 FPGA board. 
The project simulates a locker security mechanism (similar to gym or mall lockers)
where a user can set and unlock a 3-character distinct code. The system is built 
using a strict Control Unit (CU) and Execution Unit (EU) architecture, ensuring 
clean logic separation.

(For complete technical details, state diagrams, and resource breakdowns, please 
refer to the Proiect PSN Locker.docx file included in this repository.)

Features:
Custom Code Generation: Users set a 3-character security code using physical UP/DOWN buttons, iterating through characters 0-9 and A-F.  
Distinct Character Validation: The system strictly enforces the selection of distinct characters; 
                               a built-in comparator prevents the user from advancing if the current character matches a previously entered one.   
State Management (CU/EU): The Control Unit manages transitions between 'Free', 'Occupied', and 'Code Verification' states, utilizing status LEDs 
(LIBER_OCUPAT, INTRODU_CARACTERE) to guide the user.   
Hardware Debouncing (MPG): Integrates a Monopulse Generator (MPG) module to eliminate mechanical button bounce, ensuring precise character selection.   
SSD Multiplexing: Dynamically displays the current and previously entered characters on the 7-segment displays using a custom BCD to 7-segment decoder 
and frequency divider.  
