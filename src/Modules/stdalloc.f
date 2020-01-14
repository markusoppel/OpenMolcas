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

! This is just an encapsulation of the interface in
! src/Include/stdalloc.fh
! into a module.

      module stdalloc
      implicit none
      private
      public :: mma_allocate, mma_deallocate

#include "stdalloc.fh"
      save
      end module stdalloc
