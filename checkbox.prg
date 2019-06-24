	STORE SPACE (25) TO Name
   STORE .T. TO Married
   STORE SPACE (19) TO Phone
   CLS

   @  5,10 SAY "Customer Name: " GET Name
   @  6,10 SAY "Married?:      " GET Married CHECKBOX
   @  7,10 SAY "Home Phone:    " GET Phone
   READ
   ? ALLTRIM (Name) + " IS " + Iif(Married,"","NOT") + "Married."