
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_work_struc_data_obj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_work_struc_data_obj IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Access to sub-components of nested structures...

    types: begin of st_connection_nested,
                message type symsg,
                airport_from_id type /dmo/airport_from_id,
                airport_to_id type /dmo/airport_to_id,
                carrier_name type /dmo/carrier_name,
           end of st_connection_nested.


    data connection_nested type st_connection_nested.

    connection_nested-message-msgty = 'E'.
    connection_nested-message-msgid = 'ABC'.
    connection_nested-message-msgno = '123'.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Use a VALUE #( ) expression to fill the structure...

    connection_nested = value #( airport_from_id = 'ABC'
                                      airport_to_id = 'XYZ'
                                      message       = VALUE #( msgty = 'E'
                                                                            msgid = 'ABC'
                                                                            msgno = '123'
                                                                           )
                                      carrier_name = 'My Airline'
                                     ).



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " The Corresponding Operator...
    " When you copy data between structures, you usually want to copy information from one field into the corresponding field of the target structure...
    " The fields must have identical names...
    " The components do not have to be in the same position or sequence in the two structures...
    " If the fields have different types, ABAP attempts a type conversion according to the predefined set of rules...

    types: begin of st_connection,
                airport_from_id type /dmo/airport_from_id,
                airport_to_id type /dmo/airport_to_id,
                carrier_name type /dmo/carrier_name,
           end of st_connection.

    data: connection type st_connection.

    connection_nested = value #( airport_from_id = 'ABC'
                                      airport_to_id = 'XYZ'
                                      carrier_name = 'My Airline'
                                      message-msgty = 'E'
                                      message-msgid = 'ABC'
                                      message-msgno = '123'
                                   ).


    out->write( '-------------------------------------------------------' ).
    out->write( 'connection_nested ok:' ).
    out->write( connection_nested ).

    " Result:
    " MESSAGE-MSGTY   MESSAGE-MSGID   MESSAGE-MSGNO   MESSAGE-MSGV1   MESSAGE-MSGV2   MESSAGE-MSGV3   MESSAGE-MSGV4
    " E                        ABC                           12
    " AIRPORT_FROM_ID    AIRPORT_TO_ID    CARRIER_NAME
    " ABC                          XYZ                      My Airline




    connection =  connection_nested.      " Note: It'll generate worng values...

    out->write( '-------------------------------------------------------' ).
    out->write( 'Wrong result after direct assignment:' ).
    out->write( connection ).

    " Result: Wrong result after direct assignment...
    " AIRPORT_FROM_ID    AIRPORT_TO_ID    CARRIER_NAME
    " EAB                           C                         123




    connection =  corresponding #( connection_nested ).

    out->write( '-------------------------------------------------------' ).
    out->write( 'Correct Result after assignment with CORRESPONDING:' ).
    out->write( connection ).

    " Result: Correct Result after assignment with CORRESPONDING...
    " AIRPORT_FROM_ID    AIRPORT_TO_ID    CARRIER_NAME
    " ABC                          XYZ                      My Airline







    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Structured Data Objects in ABAP SQL... Part 01...

    data connection_full type /DMO/I_Connection.

    select single
    from /DMO/I_Connection
    fields *
    where AirlineID = 'LH' and
              ConnectionID = '0400'
    into @connection_full.


    out->write( '-------------------------------------------------------' ).
    out->write( 'connection_full:' ).
    out->write( connection_full ).



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Structured Data Objects in ABAP SQL... Part 02...

    TYPES: BEGIN OF st_connection_short,
           DepartureAirport   TYPE /dmo/airport_from_id,
           DestinationAirport TYPE /dmo/airport_to_id,
    END OF st_connection_short.

    data connection_short type st_connection_short.

    select single
    from /DMO/I_Connection
    fields *
    where AirlineID = 'LH' and
              ConnectionID = '0400'
    into corresponding fields of @connection_short.


    out->write( '-------------------------------------------------------' ).
    out->write( 'connection_short:' ).
    out->write( connection_short ).




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Structured Data Objects in ABAP SQL... Part 03...

" Note: The simplest technique to avoid conflicts between the field selection and the target structure is an inline declaration in the INTO clause...
"          The sequence, type and name of the inline declared structure is derived from the FIELD clause...
"          Therefore the target structure always fits the field selection...
"          If you use an inline declaration in the INTO clause, you have to provide a name for each element in the FIELDS clause...

    select single
    from /DMO/I_Connection
    fields DepartureAirport,
             DestinationAirport,
             \_Airline-Name as AirlineName
    where AirlineID = 'LH' and
              ConnectionID = '0400'
    into @data(connection_inline).


    out->write( '-------------------------------------------------------' ).
    out->write( 'connection_inline:' ).
    out->write( connection_inline ).






"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Structured Data Objects in ABAP SQL... Part 04...

" Implement SQL joins...


    select single
    from /dmo/connection as con
    left outer join /dmo/airport as air
        on con~airport_from_id = air~airport_id
    fields con~carrier_id,
             con~connection_id,
             con~airport_from_id,
             con~airport_to_id,
             air~name as airport_from_name
    where con~carrier_id = 'LH' and
              con~connection_id = '0400'
    into @data(connection_join).


    out->write( '-------------------------------------------------------' ).
    out->write( 'connection_join:' ).
    out->write( connection_join ).






"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Structured Data Objects in ABAP SQL... Part 05...

" Implement SQL joins...


    select single
    from /dmo/connection as con

        left outer join /dmo/airport as orig
            on con~airport_from_id = orig~airport_id

        left outer join /dmo/airport as dest
            on con~airport_to_id = dest~airport_id

    fields con~carrier_id,
             con~connection_id,
             con~airport_from_id,
             con~airport_to_id,
             orig~name as airport_from_name,
             dest~name as airport_to_name

    where con~carrier_id = 'LH' and
              con~connection_id = '0400'

    into @data(connection_join2).


    out->write( '-------------------------------------------------------' ).
    out->write( 'connection_join2:' ).
    out->write( connection_join2 ).


  ENDMETHOD.

ENDCLASS.
