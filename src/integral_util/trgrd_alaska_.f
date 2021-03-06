************************************************************************
* This file is part of OpenMolcas.                                     *
*                                                                      *
* OpenMolcas is free software; you can redistribute it and/or modify   *
* it under the terms of the GNU Lesser General Public License, v. 2.1. *
* OpenMolcas is distributed in the hope that it will be useful, but it *
* is provided "as is" and without any express or implied warranties.   *
* For more details see the full text of the license in the file        *
* LICENSE or in <http://www.gnu.org/licenses/>.                        *
*                                                                      *
* Copyright (C) 1996, Anders Bernhardsson                              *
*               2006, Giovanni Ghigo                                   *
************************************************************************
      SubRoutine TrGrd_Alaska_(CGrad,CNames,GradIn,nGrad,iCen)
************************************************************************
*                                                                      *
*      Transforms a symmetry adapted gradient to unsymmetric form.     *
*                                                                      *
*       Written by Anders Bernhardsson                                 *
*       Adapted by Giovanni Ghigo                                      *
*       University of Torino, July 2006                                *
************************************************************************
      Implicit Real*8(a-h,o-z)
      Parameter (tol=1d-8)
#include "itmax.fh"
#include "info.fh"
#include "disp.fh"
#include "real.fh"
#include "WrkSpc.fh"
#include "SysDef.fh"
      Real*8 CGrad(3,MxAtom)
      Dimension GradIn(nGrad)
      Character CNames(MxAtom)*(LENIN5)
      Logical TF,TstFnc
      TF(mdc,iIrrep,iComp) = TstFnc(iOper,nIrrep,iCoSet(0,0,mdc),
     &                       nIrrep/nStab(mdc),iChTbl,iIrrep,iComp,
     &                       nStab(mdc))
      mdc=0
      iIrrep=0
*
      call dcopy_(3*MxAtom,[Zero],0,CGrad,1)
      iCen=0
*     nCnttp_Valence=0
*     Do iCnttp = 1, nCnttp
*        If (AuxCnttp(iCnttp)) Go To 999
*        nCnttp_Valence = nCnttp_Valence+1
*     End Do
*999  Continue
*
      Do iCnttp=1,nCnttp
         If (.Not.(pChrg(iCnttp).or.FragCnttp(iCnttp).or.
     &             AuxCnttp(iCnttp))) Then
            ixyz = ipCntr(iCnttp)
            Do iCnt=1,nCntr(iCnttp)
               mdc=mdc+1
               Do iCo=0,nIrrep/nStab(mdc)-1
                  kop=iCoSet(iCo,0,mdc)
                  nDispS = IndDsp(mdc,iIrrep)
                  iCen=iCen+1
                  Do iCar=0,2
                     iComp = 2**iCar
                     If ( TF(mdc,iIrrep,iComp)) Then
                        nDispS = nDispS + 1
                        XR=DBLE(iPrmt(NrOpr(kop,iOper,nIrrep),icomp))
                        CGrad(iCar+1,iCen)=XR*GradIn(nDispS)
                     End If
                  End Do
                  CNames(iCen)=LblCnt(mdc)
               End Do
            End Do
            ixyz=ixyz+3
         End If
      End Do
*
      Return
      End
