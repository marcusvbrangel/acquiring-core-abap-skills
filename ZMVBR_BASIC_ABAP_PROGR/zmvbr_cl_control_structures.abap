
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_control_structures DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_control_structures IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Conditional Branching


* Declarations
**********************************************************************

    CONSTANTS c_number TYPE i VALUE 0.
*    CONSTANTS c_number TYPE i VALUE 1.
*    CONSTANTS c_number TYPE i VALUE 2.
*    CONSTANTS c_number TYPE i VALUE -1.
*    CONSTANTS c_number TYPE i VALUE -2.

* Example 1: Simple IF ... ENDIF.
**********************************************************************

    out->write(  `--------------------------------` ).
    out->write(  `Example 1: Simple IF ... ENDIF.` ).
    out->write(  `-------------------------------` ).

    IF c_number = 0.
      out->write( `The value of C_NUMBER equals zero`   ).
    ELSE.
      out->write( `The value of C_NUMBER is NOT zero`   ).
    ENDIF.

* Example 2: Optional Branches ELSEIF and ELSE
**********************************************************************

    out->write(  `--------------------------------------------` ).
    out->write(  `Example 2: Optional Branches ELSEIF and ELSE` ).
    out->write(  `--------------------------------------------` ).

    IF c_number = 0.
      out->write( `The value of C_NUMBER equals zero`            ).
    ELSEIF c_number > 0.
      out->write( `The value of C_NUMBER is greater than zero`   ).
    ELSE.
      out->write( `The value of C_NUMBER is less than zero`      ).
    ENDIF.

* Example 3: CASE ... ENDCASE
**********************************************************************

    out->write(  `---------------------------` ).
    out->write(  `Example 3: CASE ... ENDCASE` ).
    out->write(  `---------------------------` ).

    CASE c_number.
      WHEN 0.
        out->write( `The value of C_NUMBER equals zero`             ).
      WHEN 1.
        out->write( `The value of C_NUMBER equals one`              ).
      WHEN 2.
        out->write( `The value of C_NUMBER equals two`              ).
      WHEN OTHERS.
        out->write( `The value of C_NUMBER equals non of the above` ).
    ENDCASE.







  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Iteration Implementation



* Declarations
**********************************************************************

    CONSTANTS c_number2 TYPE i VALUE 3.
*    CONSTANTS c_number TYPE i VALUE 5.
*    CONSTANTS c_number TYPE i VALUE 10.

    DATA number TYPE i.

* Example 1: DO ... ENDDO with TIMES
**********************************************************************

    out->write(  `----------------------------------` ).
    out->write(  `Example 1: DO ... ENDDO with TIMES` ).
    out->write(  `----------------------------------` ).

    DO c_number2 TIMES.
      out->write(  `Hello World` ).
    ENDDO.

* Example 2: DO ... ENDDO with Abort Condition
**********************************************************************

    out->write(  `-------------------------------` ).
    out->write(  `Example 2: With Abort Condition` ).
    out->write(  `-------------------------------` ).

    number = c_number2 * c_number2.

    " count backwards from number to c_number.
    DO.

      out->write( |{ sy-index }: Value of number: {  number }| ).
      number = number - 1.

      "abort condition
      IF number <= c_number2.
        EXIT.
      ENDIF.

    ENDDO.


  ENDMETHOD.
ENDCLASS.
