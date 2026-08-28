@EndUserText.label : 'Expense Header Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zrap_expense {

  key client      : abap.clnt not null;
  key exp_uuid    : sysuuid_x16 not null;
  expense_id      : abap.char(10);
  employee_id     : abap.char(10);
  description     : abap.char(255);
  @Semantics.amount.currencyCode : 'zrap_expense.currency'
  amount          : abap.curr(15,2);
  currency        : waers;
  status          : abap.char(1);
  created_by      : syuname;
  created_at      : tzntstmps;
  last_changed_by : syuname;
  last_changed_at : tzntstmps;

}
