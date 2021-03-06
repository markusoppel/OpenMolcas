************************************************************************
* This file is part of OpenMolcas.                                     *
*                                                                      *
* OpenMolcas is free software; you can redistribute it and/or modify   *
* it under the terms of the GNU Lesser General Public License, v. 2.1. *
* OpenMolcas is distributed in the hope that it will be useful, but it *
* is provided "as is" and without any express or implied warranties.   *
* For more details see the full text of the license in the file        *
* LICENSE or in <http://www.gnu.org/licenses/>.                        *
************************************************************************
      SubRoutine Integral_WrOut_LDF_Diag(
     &                           iCmp,iShell,MapOrg,
     &                           iBas,jBas,kBas,lBas,kOp,
     &                           Shijij,IJeqKL,iAO,iAOst,ijkl,
     &                           AOInt,SOInt,nSOint,
     &                           iSOSym,nSkal,nSOs,
     &                           TInt,nTInt,FacInt,itOffs,nSym,
     &                           nShi,nShj,nShk,nShl,
     &                           nShOffi,nShOffj,nShOffk,nShOffl,
     &                           Dens,Fock,LDens,ExFac,NDens,
     &                           ind,nind,FckNoClmb,FckNoExch)
*     calls the proper routines IndSft/PLF
*     if IntOrd_jikl==.TRUE. integral order within symblk: jikl
*                      else  integral order within symblk: ijkl
      Implicit Real*8 (a-h,o-z)
*
#include "itmax.fh"
#include "info.fh"
*
      Real*8 AOInt(*), SOInt(*), TInt(nTInt)
      Integer iCmp(4), iShell(4), iAO(4),
     &        iAOst(4), kOp(4), iSOSym(2,nSOs),
     &        itOffs(0:nSym-1,0:nSym-1,0:nSym-1), MapOrg(4),
     &        nShi(0:7), nShj(0:7), nShk(0:7), nShl(0:7),
     &        nShOffi(0:7), nShOffj(0:7), nShOffk(0:7), nShOffl(0:7)
      Logical Shijij,IJeqKL,FckNoClmb,FckNoExch
      Real*8 Dens(lDens,nDens), Fock(lDens,nDens), ExFac(nDens)
      Integer Ind(nInd,nInd,2)
*
* some dummy assignments to avoid compiler warnings about unused
* variables.
*
      If (lDens.gt.0.and.nDens.gt.0.and.FckNoClmb.and.FckNoExch.and.
     &    nInd.gt.0.and.nSym.gt.0.and.nSkal.gt.0) Then
         xDummy_1  = Dens(1,1)
         xDummy_2  = Fock(1,1)
         xDummy_3  = FacInt
         xDummy_4  = ExFac(1)
         iDummy_1  = Ind(1,1,1)
         iDummy_2  = itOffs(0,0,0)
         iDummy_3  = MapOrg(1)
         iDummy_4  = nShOffi(0)
         iDummy_5  = nShOffj(0)
         iDummy_6  = nShOffk(0)
         iDummy_7  = nShOffl(0)
         iDummy_8  = nShi(0)
         iDummy_9  = nShj(0)
         iDummy_10 = nShk(0)
         iDummy_11 = nShl(0)
      End If
*
* call sorting routine
*
      If (Petite) Then
        Call PLF_LDF_Diag(TInt,nTInt,
     &           AOInt,ijkl,iCmp(1),iCmp(2),iCmp(3),iCmp(4),
     &           iShell,iAO,iAOst,Shijij.and.IJeqKL,
     &           iBas,jBas,kBas,lBas,kOp)
      Else
         Call WarningMessage(2,
     &            'Symmetry not implemented in Integral_WrOut_LDF_Diag')
         Call LDF_Quit(1)
      End If
*
      Return
c Avoid unused argument warnings
      If (.False.) Then
         Call Unused_real_array(SOInt)
         Call Unused_integer(nSOint)
         Call Unused_integer_array(iSOSym)
      End If
      End
