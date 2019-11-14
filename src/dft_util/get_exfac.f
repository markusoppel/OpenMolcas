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
      function get_ExFac(KSDFT) result(ExFac)
************************************************************************
*     Return the factor which determine how much "exact exchange" that *
*     should be included.                                              *
************************************************************************
      implicit none
      character*(*), intent(in) :: KSDFT
      real*8 :: ExFac

#include "real.fh"
#include "hflda.fh"
#include "ksdft.fh"
      character(16) ::cTmp
      logical :: l_casdft
*                                                                      *
************************************************************************
*                                                                      *
      ExFac=One
c      ExFac=HFLDA
*
*     Write functional to run file.
*
      If (KSDFT.ne.'Overlap') Then
         cTmp=KSDFT
         Call Put_cArray('DFT functional',cTmp,16)
      End If
*                                                                      *
************************************************************************
* Global variable for MCPDFT                                           *

       l_casdft = KSDFT .in. MCPDFT_functionals

*                                                                      *
************************************************************************
*                                                                      *
*      LSDA LDA SVWN                                                   *
*                                                                      *
       If (KSDFT.eq.'LSDA ' .or.
     &     KSDFT.eq.'LDA '  .or.
     &     KSDFT.eq.'SVWN ') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*      MC-PDFT                                                         *
*                                                                      *
       Else If ( l_casdft ) Then
         ExFac=Zero
*                                                                      *
************************************************************************
************************************************************************
*                                                                      *
*      TST                                                             *
*                                                                      *
       Else If (KSDFT.eq.'TST' ) Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*      LSDA5 LDA5 SVWN5                                                *
*                                                                      *
       Else If (KSDFT.eq.'LSDA5' .or.
     &          KSDFT.eq.'LDA5'  .or.
     &          KSDFT.eq.'SVWN5') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     HFB                                                              *
*                                                                      *
       Else If (KSDFT.eq.'HFB') Then
         ExFac=Zero
************************************************************************
*                                                                      *
*     HFO                                                              *
*                                                                      *
       Else If (KSDFT.eq.'HFO') Then
         ExFac=Zero
************************************************************************
*                                                                      *
*     HFG                                                              *
*                                                                      *
       Else If (KSDFT.eq.'HFG') Then
         ExFac=Zero
************************************************************************
*                                                                      *
*     HFB86                                                            *
*                                                                      *
       Else If (KSDFT.eq.'HFB86') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*      HFS                                                             *
*                                                                      *
       Else If (KSDFT.eq.'HFS') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*      XALPHA                                                          *
*                                                                      *
       Else If (KSDFT.eq.'XALPHA') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     Overlap                                                          *
*                                                                      *
      Else If (KSDFT.eq.'Overlap') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     BWIG                                                             *
*                                                                      *
      Else If (KSDFT.eq.'BWIG') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     BLYP                                                             *
*                                                                      *
      Else If (KSDFT.eq.'BLYP') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     OLYP                                                             *
*                                                                      *
      Else If (KSDFT.eq.'OLYP') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     KT3                                                              *
*                                                                      *
      Else If (KSDFT.eq.'KT3') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     KT2                                                              *
*                                                                      *
      Else If (KSDFT.eq.'KT2') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     BPBE                                                             *
*                                                                      *
      Else If (KSDFT.eq.'BPBE') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     GLYP                                                             *
*                                                                      *
      Else If (KSDFT.eq.'GLYP') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     GPBE                                                             *
*                                                                      *
      Else If (KSDFT.eq.'GPBE') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     B86LYP                                                           *
*                                                                      *
      Else If (KSDFT.eq.'B86LYP') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     B86PBE                                                           *
*                                                                      *
      Else If (KSDFT.eq.'B86PBE') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     OPBE                                                             *
*                                                                      *
      Else If (KSDFT.eq.'OPBE') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     TLYP                                                             *
*                                                                      *
      Else If (KSDFT.eq.'TLYP') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     NLYP                                                             *
*                                                                      *
      Else If (KSDFT.eq.'NLYP') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     NEWF0                                                            *
*                                                                      *
      Else If (KSDFT.eq.'NEWF0') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     NEWF1                                                            *
*                                                                      *
      Else If (KSDFT.eq.'NEWF1') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     B3LYP                                                            *
*                                                                      *
      Else If (KSDFT.eq.'B3LYP ') Then
         ExFac=One-0.80D0
*                                                                      *
************************************************************************
*                                                                      *
*     O3LYP                                                            *
*                                                                      *
      Else If (KSDFT.eq.'O3LYP ') Then
         ExFac = 0.1161D0
*                                                                      *
************************************************************************
*                                                                      *
*     B2PLYP                                                           *
*                                                                      *
      Else If (KSDFT(1:6).eq.'B2PLYP') Then
         ExFac=0.530D0
*                                                                      *
************************************************************************
*                                                                      *
*     O2PLYP                                                           *
*                                                                      *
      Else If (KSDFT(1:6).eq.'O2PLYP') Then
         ExFac=0.50D0
*                                                                      *
************************************************************************
*                                                                      *
*     B3LYP5                                                           *
*                                                                      *
      Else If (KSDFT.eq.'B3LYP5') Then
         ExFac=One-0.80D0
*                                                                      *
************************************************************************
*                                                                      *
*     CASDFT                                                           *
*                                                                      *
      Else If (KSDFT.eq.'CASDFT') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     SCF                                                              *
*                                                                      *
      Else If (KSDFT.eq.'SCF') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     PAM                                                              *
*                                                                      *
      Else If (KSDFT(1:3).eq.'PAM') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     CS                                                               *
*                                                                      *
      Else If (KSDFT(1:2).eq.'CS') Then
         ExFac=One
*                                                                      *
************************************************************************
*                                                                      *
*     PBE                                                              *
*                                                                      *
      Else If (KSDFT(1:4).eq.'PBE') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     REVPBE                                                           *
*                                                                      *
      Else If (KSDFT(1:6).eq.'REVPBE') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     SSBSW                                                            *
*                                                                      *
      Else If (KSDFT(1:5).eq.'SSBSW') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     SSBD                                                             *
*                                                                      *
      Else If (KSDFT(1:4).eq.'SSBD') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     S12G                                                             *
*                                                                      *
      Else If (KSDFT(1:4).eq.'S12G') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     S12H                                                             *
*                                                                      *
      Else If (KSDFT(1:4).eq.'S12H') Then
         ExFac=0.25d0
*                                                                      *
************************************************************************
*                                                                      *
*     PBEsol                                                           *
*                                                                      *
      Else If (KSDFT(1:6).eq.'PBESOL') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     RGE2                                                             *
*                                                                      *
      Else If (KSDFT(1:6).eq.'RGE2') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     TCA                                                              *
*                                                                      *
      Else If (KSDFT(1:6).eq.'PTCA') Then
         ExFac=Zero

*                                                                      *
************************************************************************
*                                                                      *
*     M06-L                                                            *
*                                                                      *
      Else If (KSDFT(1:4).eq.'M06L') Then
         ExFac=Zero
*                                                                      *
************************************************************************
*                                                                      *
*     M06                                                              *
*                                                                      *
      Else If (KSDFT(1:4).eq.'M06 ') Then
         ExFac=0.27D0
*                                                                      *
************************************************************************
*                                                                      *
*     M06-2X                                                           *
*                                                                      *
      Else If (KSDFT(1:5).eq.'M062X') Then
         ExFac=0.54D0
*                                                                      *
************************************************************************
*                                                                      *
*     M06-HF                                                           *
*                                                                      *
      Else If (KSDFT(1:5).eq.'M06HF ') Then
         ExFac=1.0D0
*
************************************************************************
*                                                                      *
*     Hybrid functionals with varying HF exchange                      *
*                                                                      *
      else if (KSDFT .in. hybrid_DFT_vary_HF_exc) then
        if (hf_exc_given) then
          ExFac = hf_exc
        else
          if (KSDFT(1:4) == 'PBE0') then
            ExFac = 0.25d0
          end if
        end if
*                                                                      *
************************************************************************
*                                                                      *
      Else
         Call WarningMessage(2,
     &               'Unknown DFT functional;')
         Write (6,*) 'KSDFT=',KSDFT
         Call Quit_OnUserError()
      End If
*                                                                      *
************************************************************************
*                                                                      *
      Return
      End
