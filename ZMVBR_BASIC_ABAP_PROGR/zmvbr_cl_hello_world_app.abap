
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


  CLASS zmvbr_cl_hello_world_app DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_hello_world_app IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Hello World' ).

  ENDMETHOD.


ENDCLASS.

