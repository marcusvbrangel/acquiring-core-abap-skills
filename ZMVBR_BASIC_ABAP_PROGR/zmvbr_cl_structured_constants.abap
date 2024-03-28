
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_structured_constants DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    constants:

        begin of co_key_name,
            draft type string value 'DRAFT',
            cid   type string value 'CID',
            pid type string value 'PID',
            entity type strIng value 'ENTITY',
        end of co_key_name.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zmvbr_cl_structured_constants IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( |co_key_name-cid: { co_key_name-cid }| ).
    out->write( |co_key_name-draft: { co_key_name-draft }| ).
    out->write( |co_key_name-entity: { co_key_name-entity }| ).
    out->write( |co_key_name-pid: { co_key_name-pid }| ).


  ENDMETHOD.
ENDCLASS.

