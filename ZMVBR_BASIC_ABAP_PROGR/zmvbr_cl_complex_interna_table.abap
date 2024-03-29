
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_complex_interna_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_complex_interna_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Local Structured Type...

    types: begin of st_connection,
                carrier_id              type /dmo/carrier_id,
                connection_id       type /dmo/connection_id,
                airport_from_id     type /dmo/airport_from_id,
                airport_to_id         type /dmo/airport_to_id,
                carrier_name        type /dmo/carrier_name,
           end of st_connection.



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Local Table Type...

    types tt_connections type sorted table of st_connection
                                                        with unique key carrier_id
                                                                                 connection_id.



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Global Table Type...

    data flights type /dmo/t_flight.



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Simple and Complex Internal Table...

    " simple table (scalar row type)
       DATA numbers TYPE TABLE OF i.


       " complex table (structured row type)
       DATA connections TYPE TABLE OF st_connection.



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Complex Internal Tables...

    " standard table with non-unique standard key (short form)...
    data connections_1 type table of st_connection.


    " standard table with non-unique standard key (explicit form)...
    data connections_2 type standard table of st_connection
                                            with non-unique default key.


    " sorted table with non-unique explicit key...
    data connections_3 type sorted table of st_connection
                                            with non-unique key airport_from_id
                                                                            airport_to_id.


    " sorted hashed with unique explicit key...
    data connections_4 type hashed table of st_connection
                                            with unique key carrier_id
                                                                     connection_id.





  ENDMETHOD.


ENDCLASS.
