
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



CLASS zmvbr_cl_cds_view DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_cds_view IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

* First Instance
**********************************************************************

    TRY.
        connection = NEW #(
                            i_carrier_id    = 'LH'
                            i_connection_id = '0400'
                          ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

* Second instance
**********************************************************************

    TRY.
        connection = NEW #(
                            i_carrier_id    = 'AA'
                            i_connection_id = '0017'
                          ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

* Third instance
**********************************************************************

    TRY.
        connection = NEW #(
                            i_carrier_id    = 'SQ'
                            i_connection_id = '0001'
                          ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

* Output
**********************************************************************

    LOOP AT connections INTO connection.

      out->write( connection->get_output( ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   LOCAL TYPES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i.

    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
      RAISING
        cx_ABAP_INVALID_VALUE .

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    data airport_from_id type /dmo/airport_from_id.
    data airport_to_id type /dmo/airport_to_id.
    data carrier_name type /dmo/carrier_name.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    select single
    from /DMO/I_Connection
    fields DepartureAirport, DestinationAirport, \_Airline-Name
    where AirlineID = @i_carrier_id and
                ConnectionID = @i_connection_id
    into ( @airport_from_id, @airport_to_id, @carrier_name  ).

    if sy-subrc <> 0.
        raise exception type cx_abap_invalid_value.
    endif.

    me->connection_id = i_connection_id.
    me->carrier_id = i_carrier_id.

    conn_counter = conn_counter + 1.

  ENDMETHOD.

  METHOD get_output.

    APPEND |------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
    APPEND |Connection:  { connection_id }| TO r_output.
    APPEND |Departure:   { airport_from_id }|   TO r_output.
    APPEND |Destination: { airport_to_id   }|   TO r_output.



  ENDMETHOD.

ENDCLASS.




