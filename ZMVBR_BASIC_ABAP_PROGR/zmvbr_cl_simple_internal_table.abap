
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_simple_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_simple_internal_table IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Internal Tables

    DATA my_table_numbers TYPE TABLE OF i.

    out->write( my_table_numbers  ).

    APPEND 1234 TO my_table_numbers.
    APPEND 33 TO my_table_numbers.
    APPEND 234567 TO my_table_numbers.

    out->write( my_table_numbers  ).

    out->write( '--------------------------------------------------------' ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Table Types

    DATA flights TYPE /dmo/flight.

    out->write( flights  ).

    out->write( '--------------------------------------------------------' ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Data Processing with a Simple Internal Table

    DATA my_table_numbers02 TYPE TABLE OF i.

    APPEND 324324324 TO my_table_numbers02.
    APPEND 12 TO my_table_numbers02.
    out->write( my_table_numbers02  ).

    out->write( '--------------------------------------------------------' ).

    CLEAR my_table_numbers02.
    out->write( ' out->write( my_table_numbers02  ).'  ).
    out->write( my_table_numbers02  ).

    out->write( '--------------------------------------------------------' ).

    APPEND 324324324 TO my_table_numbers02.
    APPEND 12 TO my_table_numbers02.
    APPEND 1000 TO my_table_numbers02.
    out->write( my_table_numbers02  ).
    DATA my_number_position_2 TYPE i.
    my_number_position_2 = my_table_numbers02[ 2 ].
    out->write( my_number_position_2  ).

    out->write( '--------------------------------------------------------' ).

    data my_work_area_number type i.
    LOOP AT my_table_numbers02 into my_work_area_number.

      out->write( |{ my_work_area_number  }| ).

    ENDLOOP.


    out->write( '--------------------------------------------------------' ).


    LOOP AT my_table_numbers02 into data(my_wa_number).

      out->write( |{ my_wa_number  }| ).

    ENDLOOP.





  ENDMETHOD.
ENDCLASS.

