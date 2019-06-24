#include <hbsqlit3.ch>
#require "hbsqlit3"

PROCEDURE Main()
 
 LOCAL db := sqlite3_open( "novodb.db", .T. )   // .T.  = criar banco se não existir
 Local sql := ""
 
 LOCAL tabcliente := "CREATE TABLE cliente( " +;
                     " idcliente INTEGER PRIMARY KEY AUTOINCREMENT, " +;
                " nome CHAR(100), "+;
                " idade INTEGER, "+;
                " dtnascimento DATE ); "

 LOCAL tabusuario := "CREATE TABLE usuario( " +;
                     " idusuario INTEGER PRIMARY KEY AUTOINCREMENT, " +;
                " nome CHAR(100), "+;
                " senha CHAR(15), "+;
                " nivel INTEGER NOT NULL DEFAULT (1) ); "
                
    IF sqlite3_exec( db, tabcliente ) == SQLITE_OK
         ? " Tabela clientes criada com sucesso..." 
   ENDIF

    IF sqlite3_exec( db, tabusuario ) == SQLITE_OK
         ? " Tabela usuario criada com sucesso..." 
   ENDIF

   // vamos adicionar dados ao banco
   
   sql := CrudAdd()
   
    IF sqlite3_exec( db, sql ) == SQLITE_OK
        ? " Novos usuarios cadastrados..." 

   ? "Numero Linhas incluídas: " + hb_ntos( sqlite3_changes( db ) )
   ? "Total Alterações: " + hb_ntos( sqlite3_total_changes( db ) )
      
   ELSE   
      ? "Erro: ao gravar novos usuários"
   ENDIF   
   
      
   //sqlite3_sleep( 6000 )
   

RETURN

Function CrudAdd(sql)
   sql := " " + ;     
   "BEGIN TRANSACTION;" + ;
         "INSERT INTO usuario ( nome, senha , nivel ) VALUES( 'Carlos', '999999', 3 );" + ;
         "INSERT INTO usuario ( nome, senha ) VALUES( 'Jose', '123' );" + ;
         "INSERT INTO usuario ( nome, senha ) VALUES( 'Simone', '123' );" + ;
         "INSERT INTO usuario ( nome, senha ) VALUES( 'Zeca', '123' ); " + ;
   "COMMIT;" 

RETURN (sql)
   