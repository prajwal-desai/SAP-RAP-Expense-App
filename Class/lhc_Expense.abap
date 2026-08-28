CLASS lhc_Expense DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Expense RESULT result.

    METHODS ApproveExpense FOR MODIFY
      IMPORTING keys FOR ACTION Expense~ApproveExpense RESULT result.
      
    METHODS RejectExpense FOR MODIFY
      IMPORTING keys FOR ACTION Expense~RejectExpense RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Expense~setInitialStatus.
      
    METHODS validateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR Expense~validateAmount.
ENDCLASS.

CLASS lhc_Expense IMPLEMENTATION.

  METHOD ApproveExpense.
    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses).

    MODIFY ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense UPDATE FIELDS ( Status )
      WITH VALUE #( FOR exp IN lt_expenses ( %tky = exp-%tky Status = 'A' ) ).

    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses_updated).

    result = VALUE #( FOR exp_upd IN lt_expenses_updated ( %tky = exp_upd-%tky %param = exp_upd ) ).
  ENDMETHOD.

  METHOD RejectExpense.
    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses).

    MODIFY ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense UPDATE FIELDS ( Status )
      WITH VALUE #( FOR exp IN lt_expenses ( %tky = exp-%tky Status = 'R' ) ).

    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses_updated).

    result = VALUE #( FOR exp_upd IN lt_expenses_updated ( %tky = exp_upd-%tky %param = exp_upd ) ).
  ENDMETHOD.

  METHOD setInitialStatus.
    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses).

    DELETE lt_expenses WHERE Status IS NOT INITIAL.
    CHECK lt_expenses IS NOT INITIAL.

    MODIFY ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense UPDATE FIELDS ( Status )
      WITH VALUE #( FOR exp IN lt_expenses ( %tky = exp-%tky Status = 'N' ) ).
  ENDMETHOD.

  METHOD validateAmount.
    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense FIELDS ( Amount ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses).

    LOOP AT lt_expenses INTO DATA(ls_expense).
      IF ls_expense-Amount <= 0.
        APPEND VALUE #( %tky = ls_expense-%tky ) TO failed-expense.
        APPEND VALUE #( %tky = ls_expense-%tky
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = 'Amount must be greater than zero.' )
                      ) TO reported-expense.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF ZI_Expense IN LOCAL MODE
      ENTITY Expense FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_expenses).

    result = VALUE #( FOR ls_exp IN lt_expenses (
                        %tky = ls_exp-%tky
                        %action-ApproveExpense = COND #( WHEN ls_exp-Status = 'A' THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
                        %action-RejectExpense  = COND #( WHEN ls_exp-Status = 'R' THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
                      ) ).
  ENDMETHOD.
ENDCLASS.

