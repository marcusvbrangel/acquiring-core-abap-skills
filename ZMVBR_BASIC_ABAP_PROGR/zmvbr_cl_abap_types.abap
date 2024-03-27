
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

CLASS zmvbr_cl_abap_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_abap_types IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Data Objects with Built-in Types
    " ---------------------------------------------------------------------

    " comment/uncomment the following declarations and check the output
"    DATA variable TYPE string.
"   DATA variable TYPE i.
"    DATA variable TYPE d.
"      DATA variable TYPE t.
"    DATA variable TYPE c LENGTH 10.
"    DATA variable TYPE n LENGTH 10.
    DATA variable TYPE p LENGTH 8 DECIMALS 2.

    " Output
    " ---------------------------------------------------------------------

    out->write( 'Result with Initial Value)' ).
    out->write( variable ).
    out->write( '---------' ).

    variable = '198911091111.98'.

    out->write( 'Result with new Value' ).
    out->write( variable ).
    out->write( '---------' ).

  ENDMETHOD.



ENDCLASS.

