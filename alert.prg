Function Main()

// harmless message
		cls
      cMessage := "Major Database Corruption Detected!;" +  ;
                  "(deadline in few hours);;"            +  ;
                  "where DO you want to go today?"

      // define response option
      aOptions := { "Ok", "www.jobs.com", "Oops" }

      // show message and let end user select panic level
      nChoice := ALERT( cMessage, aOptions, "w+/g" )
      DO CASE
         CASE nChoice == 0
              // do nothing, blame it on some one else
         CASE nChoice == 1
              ? "Please call home and tell them you're gonn'a be late"
         CASE nChoice == 2
              // make sure your resume is up to date
         CASE nChoice == 3
              ? "Oops mode is not working in this version"
      ENDCASE
