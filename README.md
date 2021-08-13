# ISPF
Package for [mvs-sysgen (MVS/CE)](https://github.com/MVS-sysgen/sysgen) to auto install Wally Mclaughlin's reimplementation/clone of ISPF. 

## Note
You must obtain the tape file directly from Wally.  This repo only provides the supporting pieces to automate the installation.  He has not given me permission to distribute his ISPF, therefore I leave it up to you to obtain the tape from Wally.

## VERY IMPORTANT NOTE
This install updates the logon procedure and will fail if users are currently logged into your system when those steps are exectuted.

## How to Install
1. Ensure all users are logged out.
2. Obtain `ISPF.V2R2M0.aws` from Wally and place it in the `SOFTWARE/ISPF` folder.
3. Logon to TSO as `IBMUSER` and run `INSTALL ISPF`
4. Immediately `LOGOFF` and do not logon again until ISPF installs.
5. Once install completes, login and type `ISPF` at the `READY` prompt to start ISPF.

## Thank you
Thanks go out to the [Soldier of Fortran](https://github.com/mainframed) and Wally Mclaughlin.