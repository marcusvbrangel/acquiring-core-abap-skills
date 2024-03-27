
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_local_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_local_class IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Static..

    lcl_connection=>conn_counter = 4654.

    out->write( lcl_connection=>conn_counter  ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Instance...

    DATA connection TYPE REF TO lcl_connection.

    out->write( connection  ).

    connection = NEW #( ).

    connection->carrier_id    = 'LH'.
    connection->connection_id = '0400'.

    out->write( connection ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Instance Management in an Internal Table...

    DATA connections TYPE TABLE OF REF TO lcl_connection.

    connection = NEW #( ).
    APPEND connection TO connections.

    CLEAR connection.

    connection = NEW #( ).
    APPEND connection TO connections.

    out->write( connections ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Method Calls...

    "connection->set_attributes(
    "            EXPORTING
    "                            i_carrier_id    = 'PT'
    "                            i_connection_id = '0750' ).
*    CATCH cx_abap_invalid_value.

    " connection->set_attributes(
    "    i_carrier_id    = 'PT'
    "    i_connection_id = '0750'
    ")

    " connection->set_attributes( '0750'  ).

    "out->write( connection ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Try It Out: Method Calls and Exception Handling...

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
    CONSTANTS c_connection_id TYPE /dmo/connection_id VALUE '0400'.

    connection = NEW #(  ).

    out->write( '---------------------------------------------------------------------------' ).
    out->write(  |i_carrier_id    = '{ c_carrier_id }' | ).
    out->write(  |i_connection_id = '{ c_connection_id }'| ).

    try.

        connection->set_attributes(
            EXPORTING
                  i_carrier_id          =  c_carrier_id
                  i_connection_id   =  c_connection_id
        ).

        APPEND connection to connections.

        out->write( 'Method call successfull' ).

        CATCH cx_abap_invalid_value.

            out->write( 'Method call failed' ).

    ENDTRY.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Functional Methods...

     " in a value assignment (with inline declaration for result)...
    data(result) = connection->get_output(  ).

    " in logical expression...
    if connection->get_output(  ) is not INITIAL.

        LOOP AT connections INTO connection.

            out->write( connection->get_output( ) ).

        ENDLOOP.

        "  to supply input parameter of another method...
        out->write( data = connection->get_output(  )
                                  name = '' ).

    ENDIF.



  ENDMETHOD.

ENDCLASS.




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   LOCAL TYPES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


class lcl_connection definition.

  public section.

    data: carrier_id type /dmo/carrier_id,
            connection_id type /dmo/connection_id.

    class-DATA conn_counter type i.

" NOTE: CTRL + 1  ....  to view possible errors... and implement it...
    METHODS set_attributes
                           IMPORTING i_carrier_id type /dmo/carrier_id OPTIONAL
                                              i_connection_id type /dmo/connection_id
                           RAISING
                             cx_abap_invalid_value.

    METHODS get_attributes
                          EXPORTING e_carrier_id type /dmo/carrier_id
                                             e_connection_id type /dmo/connection_id.

    " Functional Methods...
    METHODS get_output
                      RETURNING VALUE(r_output) type string_table.

  protected section.
  private section.

endclass.

class lcl_connection implementation.

  method set_attributes.

    if carrier_id is initial or connection_id is initial.

        RAISE EXCEPTION TYPE cx_abap_invalid_value.

    ENDIF.

    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
    conn_counter = conn_counter + 1.

  endmethod.

  method get_attributes.

    e_carrier_id = carrier_id.
    e_connection_id = connection_id.

  endmethod.

  method get_output.

       APPEND |------------------------------    | TO r_output.
       APPEND |Carrier:     { carrier_id             }| TO r_output.
       APPEND |Connection:  { connection_id }| TO r_output.

  endmethod.

endclass.




