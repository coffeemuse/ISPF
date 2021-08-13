//ISPLOAD  JOB (TSO),
//             'Load tape',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1                         
//*                                                                  
//* Load ISPF datasets from tape
//* UNIT=SYSALLDA, VOL=PUB001 for MVS/CE
//* This is based on the JCL job provided by Wally
//* buat tailored to MVS/CE                      
//*                                                                  
//LOAD     PROC HIL=ISP,DSN=LLIB,LABEL=1,                            
//         UNIT=SYSALLDA,VOL=PUB001,CYL=2,MEM=20                         
//STEP1    EXEC PGM=IEBCOPY                                          
//SYSPRINT DD   SYSOUT=*                                             
//SYSUT1   DD   DSN=ISP.V2R2M0.&DSN..UNLOAD,DISP=(OLD,KEEP),         
//         VOL=(PRIVATE,RETAIN,SER=ISP220),UNIT=TAPE,                
//         LABEL=(&LABEL,SL,,IN)                                     
//SYSUT2   DD   DSN=&HIL..V2R2M0.&DSN,DISP=(,CATLG),                 
//         VOL=SER=&VOL,UNIT=&UNIT,SPACE=(CYL,(&CYL,0,&MEM),RLSE)    
//SYSIN    DD   DUMMY                                                
//         PEND                                                      
//DELETE   EXEC PGM=IEHPROGM                                         
//*                                                                  
//* UNIT=SYSALLDA,VOL=SER=PUB001 for MVS/CE                      
//*                                                                  
//SYSPRINT DD   SYSOUT=*                                             
//DASD     DD   UNIT=SYSALLDA,VOL=SER=PUB001,DISP=SHR                    
//SYSIN    DD   *                                                    
 SCRATCH DSNAME=ISP.V2R2M0.INSTALL,VOL=SYSDA=WORK01                   
 UNCATLG DSNAME=ISP.V2R2M0.INSTALL                                   
 SCRATCH DSNAME=ISP.V2R2M0.DOC,VOL=SYSDA=WORK01 
 UNCATLG DSNAME=ISP.V2R2M0.DOC                                         
 SCRATCH DSNAME=ISP.V2R2M0.CLIB,VOL=SYSDA=WORK01                        
 UNCATLG DSNAME=ISP.V2R2M0.CLIB                                        
 SCRATCH DSNAME=ISP.V2R2M0.LLIB,VOL=SYSDA=WORK01                        
 UNCATLG DSNAME=ISP.V2R2M0.LLIB                                        
 SCRATCH DSNAME=ISP.V2R2M0.MLIB,VOL=SYSDA=WORK01                        
 UNCATLG DSNAME=ISP.V2R2M0.MLIB                                        
 SCRATCH DSNAME=ISP.V2R2M0.PLIB,VOL=SYSDA=WORK01                        
 UNCATLG DSNAME=ISP.V2R2M0.PLIB                                        
 SCRATCH DSNAME=ISP.V2R2M0.SLIB,VOL=SYSDA=WORK01                        
 UNCATLG DSNAME=ISP.V2R2M0.SLIB                                        
 SCRATCH DSNAME=ISP.V2R2M0.TLIB,VOL=SYSDA=WORK01                        
 UNCATLG DSNAME=ISP.V2R2M0.TLIB                                        
 SCRATCH DSNAME=ISP.V2R2M0.OPTDOC,VOL=SYSDA=WORK01                      
 UNCATLG DSNAME=ISP.V2R2M0.OPTDOC                                      
 SCRATCH DSNAME=ISP.V2R2M0.OPTCLIB,VOL=SYSDA=WORK01                     
 UNCATLG DSNAME=ISP.V2R2M0.OPTCLIB                                     
 SCRATCH DSNAME=ISP.V2R2M0.OPTLLIB,VOL=SYSDA=WORK01                     
 UNCATLG DSNAME=ISP.V2R2M0.OPTLLIB                                     
 SCRATCH DSNAME=ISP.V2R2M0.OPTMLIB,VOL=SYSDA=WORK01                     
 UNCATLG DSNAME=ISP.V2R2M0.OPTMLIB                                     
 SCRATCH DSNAME=ISP.V2R2M0.OPTPLIB,VOL=SYSDA=WORK01                     
 UNCATLG DSNAME=ISP.V2R2M0.OPTPLIB                                     
 SCRATCH DSNAME=ISP.V2R2M0.OPTSLIB,VOL=SYSDA=WORK01                    
 UNCATLG DSNAME=ISP.V2R2M0.OPTSLIB                                     
//INSTALL  EXEC LOAD,DSN=INSTALL,LABEL=1                               
//DOC      EXEC LOAD,DSN=DOC,LABEL=2                                   
//CLIB     EXEC LOAD,DSN=CLIB,LABEL=3
//LLIB     EXEC LOAD,DSN=LLIB,LABEL=4                                  
//MLIB     EXEC LOAD,DSN=MLIB,LABEL=5                                  
//PLIB     EXEC LOAD,DSN=PLIB,LABEL=6                                  
//SLIB     EXEC LOAD,DSN=SLIB,LABEL=7                                  
//TLIB     EXEC LOAD,DSN=TLIB,LABEL=8                                  
//OPTDOC   EXEC LOAD,DSN=OPTDOC,LABEL=9                                
//OPTCLIB  EXEC LOAD,DSN=OPTCLIB,LABEL=10                              
//OPTLLIB  EXEC LOAD,DSN=OPTLLIB,LABEL=11                              
//OPTMLIB  EXEC LOAD,DSN=OPTMLIB,LABEL=12                              
//OPTPLIB  EXEC LOAD,DSN=OPTPLIB,LABEL=13                              
//OPTSLIB  EXEC LOAD,DSN=OPTSLIB,LABEL=14                              
//*
//* EDIT TSOLOGON PROC PER ISP.V2R2M0.DOC(INSTALL)
//*
//EDITTSOL EXEC PGM=IKJEFT01,REGION=1024K,DYNAMNBR=50
//SYSPRINT DD  SYSOUT=*
//SYSTSPRT DD  SYSOUT=*
//SYSTERM  DD  SYSOUT=*
//SYSTSIN  DD  *
EDIT 'SYS1.CMDPROC(TSOLOGON)' DATA NONUM OLD
LIST
TOP
FIND \%STDLOGON
UP
INSERT ALLOC F(ISPPROF) DA('&SYSUID..ISP.PROF') SHR
INSERT ALLOC F(REVPROF) DA('&SYSUID..ISP.PROF') SHR
LIST
END SAVE
/*
//*
//* BACKUP IKJACCNT to IKJORIG
//*
//IKJCOPY EXEC PGM=IEBGENER 
//SYSPRINT DD SYSOUT=*
//SYSUT1 DD DSN=SYS1.PROCLIB(IKJACCNT),
//          DISP=SHR
//SYSUT2 DD DSN=SYS1.PROCLIB(IKJORIG),
//          DISP=SHR
//SYSIN DD DUMMY
//*
//* EDIT IKJACCNT PROC PER ISP.V2R2M0.DOC(INSTALL)
//*
//* OK, this is a nasty hack. I am just deleting
//* the lines in the existing member and then 
//* inserting new ones.  It is tailored to
//* MVS/CE
//EDITIKJA EXEC PGM=IKJEFT01,REGION=1024K,DYNAMNBR=50
//SYSPRINT DD  SYSOUT=*
//SYSTSPRT DD  SYSOUT=*
//SYSTERM  DD  SYSOUT=*
//SYSTSIN  DD  *
EDIT 'SYS1.PROCLIB(IKJACCNT)' DATA OLD
LIST
TOP
DELETE * 1000
INSERT //IKJACCNT PROC 
INSERT //IKJACCNT EXEC PGM=IKJEFT01,DYNAMNBR=64,
INSERT //            PARM='EX ''SYS1.CMDPROC(TSOLOGON)''',TIME=1440
INSERT //STEPLIB  DD  DSN=ISP.V2R2M0.LLIB,DISP=SHR
INSERT //ISPCLIB  DD  DSN=ISP.V2R2M0.CLIB,DISP=SHR
INSERT //ISPLLIB  DD  DSN=ISP.V2R2M0.LLIB,DISP=SHR
INSERT //ISPMLIB  DD  DSN=ISP.V2R2M0.MLIB,DISP=SHR
INSERT //ISPPLIB  DD  DSN=ISP.V2R2M0.PLIB,DISP=SHR
INSERT //ISPSLIB  DD  DSN=ISP.V2R2M0.SLIB,DISP=SHR
INSERT //ISPTLIB  DD  DSN=ISP.V2R2M0.TLIB,DISP=SHR
INSERT //ISPTABL  DD  DSN=ISP.V2R2M0.TLIB,DISP=SHR
INSERT //ISPTRACE DD  TERM=TS
INSERT //SYSHELP  DD  DSN=SYS1.HELP,DISP=SHR
INSERT //         DD  DSN=SYS2.HELP,DISP=SHR
INSERT //SYSPROC  DD  DSN=SYS1.CMDPROC,DISP=SHR
INSERT //SYSUADS  DD  DSN=SYS1.UADS,DISP=SHR
INSERT //DD1      DD  DYNAM
INSERT //DD2      DD  DYNAM
INSERT //DD3      DD  DYNAM
INSERT //DD4      DD  DYNAM
INSERT //DD5      DD  DYNAM
INSERT //DD6      DD  DYNAM
INSERT //DD7      DD  DYNAM
INSERT //DD8      DD  DYNAM
INSERT //DD9      DD  DYNAM
INSERT //DDA      DD  DYNAM
INSERT //DDB      DD  DYNAM
INSERT //DDC      DD  DYNAM 
INSERT //DDD      DD  DYNAM
INSERT //DDE      DD  DYNAM 
INSERT //DDF      DD  DYNAM
TOP
RENUM 10 100 
LIST
END SAVE
/*
//*
//* INSTALL MAINT PATCH PER ISP.V2R2M0.DOC(INSTALL)
//*
//IMASPZAP EXEC PGM=IMASPZAP,PARM=IGNIDRFULL  
//SYSLIB   DD   DSN=ISP.V2R2M0.LLIB,DISP=SHR  
//SYSPRINT DD   SYSOUT=*                      
//SYSIN    DD   *                             
*                                             
*--------------------*                        
* UPGRADE VERSION ID *                        
*--------------------*                        
*                                             
 NAME ISPF     ISPVERSN                       
 REP 05  F0F0F0                               
//