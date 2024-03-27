
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_encapsulation DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zmvbr_cl_encapsulation IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Using Encapsulation to Ensure Consistency...

    DATA connection TYPE REF TO lcl_connection.

*    connection = NEW #( ).

*    out->write( '----------------------------------------------' ).
*    out->write( connection ).

*    connection->set_attributes(
*                                i_carrier_id    = 'LH'
*                                i_connection_id = '0400'
*                          ).

*    connection->get_attributes(
*            IMPORTING
*                e_carrier_id    = DATA(carrier_id)
*                e_connection_id = DATA(connection_id)
*            ).

*    out->write( '----------------------------------------------' ).
*    out->write( |carrier_id { carrier_id }| ).
*    out->write( |connection_id { connection_id }| ).
*    out->write( |conn_counter { lcl_connection=>conn_counter }| ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Instance Constructor Use...

*    data conn1 type ref to lcl_connection.
*    data conn2 type ref to lcl_connection.

*    conn1 = new #(  ).
*    conn2 = new #(  ).

*    conn1->set_attributes(
*      i_carrier_id    = 'LH'
*      i_connection_id = '0400'
*    ).

*    conn2->set_attributes(
*      i_carrier_id    = 'AA'
*      i_connection_id = '0017'
*    ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Instance Constructor Use...

    data conn3 type ref to lcl_connection.

    try.

        conn3 = new #( carrier_id = 'LH'
                                 connection_id = '0400'
                               ).

         conn3->get_attributes(
            IMPORTING
                e_carrier_id    = DATA(carrier_id)
                e_connection_id = DATA(connection_id)
         ).

         out->write( '----------------------------------------------' ).
         out->write( |carrier_id { carrier_id }| ).
         out->write( |connection_id { connection_id }| ).
         out->write( |conn_counter { lcl_connection=>conn_counter }| ).

        CATCH cx_abap_invalid_value.

            out->write( 'Inválid value!' ).

    endtry.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Static Constructor Use...


  ENDMETHOD.

ENDCLASS.



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   LOCAL TYPES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS lcl_connection DEFINITION.

  " Note: quick fix to change the visibility of an attribute.
  " To use it place the cursor in the attribute name, press Ctrl + 1, and choose Make <attribute> private...

  PUBLIC SECTION.

     " In ADT, you can use a quick fix to generate a constructor method. To use this quick fix proceed as follows:
     " Either in the definition or implementation part, place the cursor in the class name and press Ctrl + 1.
     " From the list of available quick fixes, choose Generate constructor
     " On the dialog window that appears, select the attributes you want to initialize with the constructor and choose Finish
     " Once you generated the constructor you can adjust its definition and implementation to your needs.

    METHODS constructor
        IMPORTING
            carrier_id type /dmo/carrier_id
            connection_id type /dmo/connection_id
        RAISING
            cx_abap_invalid_value.

    " In ADT, you can use a quick fix to generate a class constructor method. To use this quick fix proceed as follows:
    " Either in the definition or implementation part, place the cursor in the class name and press Ctrl + 1.
    " From the list of available quick fixes, choose Generate class constructor

    CLASS-METHODS class_constructor.

    CLASS-DATA conn_counter TYPE i.

    " NOTE: CTRL + 1  ....  to view possible errors... and implement it...
    METHODS set_attributes
      IMPORTING i_carrier_id    TYPE /dmo/carrier_id OPTIONAL
                i_connection_id TYPE /dmo/connection_id
      RAISING
                cx_abap_invalid_value.

    METHODS get_attributes
      EXPORTING e_carrier_id    TYPE /dmo/carrier_id
                e_connection_id TYPE /dmo/connection_id.

    " Functional Methods...
    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: carrier_id    TYPE /dmo/carrier_id,
          connection_id TYPE /dmo/connection_id.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_attributes.

      e_carrier_id = carrier_id.
      e_connection_id = connection_id.

  ENDMETHOD.

  METHOD get_output.

  ENDMETHOD.

  METHOD set_attributes.

      carrier_id = i_carrier_id.
      connection_id = i_connection_id.
      conn_counter = conn_counter + 1.

  ENDMETHOD.

  METHOD constructor.

    if carrier_id is initial or connection_id is initial.

        RAISE EXCEPTION TYPE cx_abap_invalid_value.

    endif.

    me->carrier_id = carrier_id.
    me->connection_id = connection_id.

    conn_counter = conn_counter + 1.

  ENDMETHOD.

  METHOD class_constructor.

        conn_counter = 500.

  ENDMETHOD.

ENDCLASS.

