
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GLOBAL CLASS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


CLASS zmvbr_cl_structured_data_obj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmvbr_cl_structured_data_obj IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Structured Data Objects...

    data airport_from_id type /dmo/airport_from_id.
    data airport_to_id     type /dmo/airport_to_id.

    select single
    from /DMO/I_Connection
    fields DepartureAirport, DestinationAirport
    where AirlineID = 'LH' and
                ConnectionID = '0400'
    into ( @airport_from_id, @airport_to_id ).

    out->write( '-------------------------------------------------' ).
    out->write( |AirlineID: LH | ).
    out->write( |ConnectionID: 0400 | ).
    out->write( |DepartureAirport: { airport_from_id } | ).
    out->write( |DestinationAirport: { airport_to_id } | ).
    out->write( '-------------------------------------------------' ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Structure based on repository object of type Structure...

    data connection_full type /DMO/I_Connection.

    select single
    from /DMO/I_Connection
    FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
                DepartureTime, ArrivalTime, Distance, DistanceUnit
    where AirlineID = 'LH' and
                ConnectionID = '0400'
    into @connection_full.


    out->write( '-------------------------------------------------' ).
    out->write( |AirlineID: { connection_full-AirlineID } | ).
    out->write( |ConnectionID: { connection_full-ConnectionID } | ).
    out->write( |DepartureAirport: { connection_full-DepartureAirport } | ).
    out->write( |DestinationAirport: { connection_full-DestinationAirport } | ).
    out->write( |DepartureTime: { connection_full-DepartureTime } | ).
    out->write( |ArrivalTime: { connection_full-ArrivalTime } | ).
    out->write( |Distance: { connection_full-Distance } | ).
    out->write( |DistanceUnit: { connection_full-DistanceUnit } | ).
    out->write( '-------------------------------------------------' ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Local Structured Type...

    data message type symsg.

    types: BEGIN OF st_connection_local_struct,
           airport_from_id type /dmo/airport_from_id,
           airport_to_id     type /dmo/airport_to_id,
           carrier_name    type /dmo/carrier_name,
    end of st_connection_local_struct.

    data connection_local_struct type st_connection_local_struct.


    select single
    from /DMO/I_Connection
    fields DepartureAirport, DestinationAirport, \_Airline-Name
    where AirlineID = 'LH' and
                ConnectionID = '0400'
    into @connection_local_struct.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Nested Structured Type...

    TYPES: BEGIN OF st_connection_nested_struct,
         airport_from_id TYPE /dmo/airport_from_id,
         airport_to_id   TYPE /dmo/airport_to_id,
         message         TYPE symsg,
        carrier_name    TYPE /dmo/carrier_name,
    END OF st_connection_nested_struct.

    DATA connection_nested_struct TYPE st_connection_nested_struct.


  ENDMETHOD.


ENDCLASS.
