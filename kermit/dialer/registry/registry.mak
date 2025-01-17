# K95 Registry and Desktop Tool makefile

#    nmake -f k95dial.mak winnt       

# Be sure to set the LIB and INCLUDE environment variables for Zinc, e.g.:
#    set INCLUDE=.;C:\ZINC\INCLUDE;C:\MSVC\INCLUDE
#    set LIB=.;C:\ZINC\LIB\MVCPP400;C:\MSVC\LIB

# ----- Windows NT compiler options -----------------------------------------
# for debug:    add /Zi to CPP_OPTS
#               add /DEBUG:MAPPED,FULL /DEBUGTYPE:CV to LINK_OPTS

!message Attempting to detect compiler...
!include ..\..\k95\compiler_detect.mak

!message
!message
!message ===============================================================================
!message C-Kermit Dialer Build Configuration
!message ===============================================================================
!message  Architecture:             $(TARGET_CPU)
!message  Compiler:                 $(COMPILER)
!message  Compiler Version:         $(COMPILER_VERSION)
!message  Compiler Target Platform: $(TARGET_PLATFORM)
!message ===============================================================================
!message
!message

WNT_CPP=cl /nologo
WNT_LINK=link /nologo
WNT_LIBRARIAN=lib /nologo

!if "$(CMP)" == "VCXX"

#WNT_CPP_OPTS= -c -MT -W3 -D_X86_=1 -DWIN32 -DOS2 -DNT -I.\.. /Zi -J -noBool
#WNT_LINK_OPTS=-align:0x1000 -subsystem:windows -entry:WinMainCRTStartup /MAP /Debug:full /Debugtype:cv 
WNT_CPP_OPTS=-c -MT -W3 -DWIN32 -DOS2 -DNT -I.\.. -J -noBool
WNT_LINK_OPTS=-subsystem:windows -entry:WinMainCRTStartup /MAP
WNT_CON_LINK_OPTS=-subsystem:console -entry:mainCRTStartup
WNT_LIBS=wnt_zil.lib ndirect.lib nservice.lib nstorage.lib libcmt.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib shell32.lib ole32.lib uuid.lib advapi32.lib oldnames.lib # compmgr.lib
!if $(MSC_VER) < 130
!message Using ctl3d32
# CTL3D32 is only available on Visual C++ 6.0 and earlier.
WNT_LIBS=$(WNT_LIBS) ctl3d32.lib
!endif

!else

WNT_CPP_OPTS=-c -MT -W3 -DWIN32 -DOS2 -DNT -I.\.. -J
WNT_LINK_OPTS=-subsystem:windows -entry:WinMainCRTStartup /MAP
WNT_CON_LINK_OPTS=-subsystem:console -entry:mainCRTStartup
WNT_LIBS=wnt_zil.lib ndirect.lib nservice.lib nstorage.lib # compmgr.lib

!endif

WNT_LIB_OPTS=/machine:i386 /subsystem:WINDOWS
WNT_OBJS=

.cpp.obn:
	$(WNT_CPP) $(WNT_CPP_OPTS) -Fo$*.obn $<

.c.obn:
	$(WNT_CPP) $(WNT_CPP_OPTS) -Fo$*.obn $<


# ----- Usage --------------------------------------------------------------
usage:
	@echo ...........
	@echo ...........
	@echo To make the K95 Dialer type:
	@echo nmake -f k95dial.mak winnt
	@echo ...........
	@echo ...........

# ----- Clean ---------------------------------------------------------------
clean:
	z_clean

# ----- Windows NT ----------------------------------------------------------
winnt: k95regtl.exe

k95regtl.exe: main.obn kregistry.obn registry.obn k95regtl.res
	$(WNT_LINK) $(WNT_LINK_OPTS) -out:k95regtl.exe $(WNT_OBJS) \
    main.obn kregistry.obn registry.obn k95regtl.res $(WNT_LIBS)

k95regtl.res: k95regtl.rc k95f.ico
    rc -v -dWINVER=0x0400 -fo k95regtl.res k95regtl.rc

main.obn: main.cpp kregistry.hpp registry.hpp

registry.obn: registry.cpp registry.hpp

kregistry.obn:  kregistry.cpp kregistry.hpp

