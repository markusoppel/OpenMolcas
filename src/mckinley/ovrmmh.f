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
      Subroutine OvrMmH(nHer,MmOvrH,la,lb,lr)
*
      nHer=(la+lb+1+4)/2
      MmOvrH = 3*nHer*(la+3) +
     &        3*nHer*(lb+3) +
     &        3*nHer +
     &        3*(la+3)*(lb+3) + 2
*
      Return
c Avoid unused argument warnings
      If (.False.) Call Unused_integer(lr)
      End
