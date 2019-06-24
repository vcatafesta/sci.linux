#require "hbunix"

REQUEST HB_GT_CGI_DEFAULT

PROCEDURE Main()

   LOCAL cLogFile, cLogText

   cLogFile := hb_ps() + CurDir() + hb_ps() + hb_FNameExtSet( __FILE__, ".txt" )

   ? hb_StrFormat( "Parent(%d) launching child... ", posix_getpid() )

   if unix_daemon( 0, 0 ) == -1
      ? hb_StrFormat( "failed with errno=%d", posix_errno() )
      ErrorLevel( 1 )
   else
      if hb_FileExists( cLogFile )
         FErase( cLogFile )
      endif

      ? "***" + hb_eol() + "* if you see this, something is b0rked" + hb_eol() + "***"

      cLogText := hb_StrFormat( "Hello, this is the daemon child(%d) writing.", posix_getpid() ) + hb_eol()
      cLogText += hb_StrFormat( "I am currenty residing in %s and ", hb_ps() + CurDir() ) + hb_eol()
      cLogText += hb_StrFormat( "am writing this message to %s", cLogFile ) + hb_eol()
      cLogText += "Good bye now." + hb_eol()

      hb_MemoWrit( cLogFile, cLogText )
   endif

   return