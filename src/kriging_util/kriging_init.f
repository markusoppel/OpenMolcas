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
      Subroutine Kriging_Init()
      Implicit Real*8 (a-h,o-z)
#include "AI.fh"
C
C     Initiate Kriging parameters.
C
      Kriging = .False.
      nspAI = 3
      anAI = .True.
      pAI = 2
      npxAI = 100
      lbAI(1) = 0.1
      lbAI(2) = 6.0
      lbAI(3) = 10
      miAI = 100
      meAI = -10e-6
*
      Return
      End
