
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

CLASS zmvbr_cl_basic_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_basic_select IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

        data airport_from_id type /dmo/airport_from_id.
        data airport_to_id type /dmo/airport_to_id.

        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " Single field from Single Record...

        select single
        from /dmo/connection
        fields airport_from_id
        where carrier_id = 'LH'
            and connection_id = '0400'
        into @airport_from_id.

        out->write(  '----------------------------'  ).
        out->write( |Flight LH 400 departs from {  airport_from_id }.| ).


        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " Empty Result and sy-subrc...

        select single
        from /dmo/connection
        fields airport_from_id
        where carrier_id = 'XX'
            and connection_id = '1234'
        into @airport_from_id.

        if sy-subrc = 0.

            out->write(  '----------------------------'  ).
            out->write( |Flight LH 400 departs from {  airport_from_id }.| ).

        else.

            out->write(  '----------------------------'  ).
            out->write( |There is no flight XX 1234, but still airport_from_id = {  airport_from_id }!| ).

        endif.

  ENDMETHOD.

ENDCLASS.
