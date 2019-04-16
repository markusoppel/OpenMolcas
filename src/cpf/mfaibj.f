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
* Copyright (C) 1986, Per E. M. Siegbahn                               *
*               1986, Margareta R. A. Blomberg                         *
************************************************************************
      SUBROUTINE MFAIBJ(JSY,INDEX,C,S,ABIJ,AIBJ,AJBI,BUFIN,IBUFIN,A,B,
     &                  F,FSEC,W,THET,ENP,EPP,NII)
      IMPLICIT REAL*8 (A-H,O-Z)
#include "SysDef.fh"
#include "cpfmcpf.fh"
#include "files_cpf.fh"
      DIMENSION JSY(*),INDEX(*),C(*),S(*),ABIJ(*),AIBJ(*),AJBI(*)
      DIMENSION BUFIN(*),IBUFIN(*),A(*),B(*),F(*),FSEC(*),W(*)
      DIMENSION THET(NII,NII),ENP(*),EPP(*)
      DIMENSION IPOF(9),IPOA(9),IPOB(9)
      PARAMETER (IPOW5=2**5,IPOW13=2**13,IPOW18=2**18)
      PARAMETER (IPOW10=2**10)
*
      JSYM(L)=JSUNP_CPF(JSY,L)
*
      ITYP   = 0 ! dummy initialize
      ICOUP  = 0 ! dummy initialize
      ICOUP1 = 0 ! dummy initialize
      INUM=IRC(4)-IRC(3)
      CALL MPSQ2(C,S,W,MUL,INDEX,JSY,NDIAG,INUM,IRC(3),LSYM,NVIRT,SQ2)
      NVT=IROW(NVIRT+1)
      ICHK=0
      IFAB=0
      NOVST=LN*NVIRT+1+NVT
      LBUF0=RTOI*LBUF
      LBUF1=LBUF0+LBUF+1
      LBUF2=LBUF1+1
      NOT2=IROW(LN+1)
      IADD10=IAD10(6)
300   CALL dDAFILE(Lu_CIGuga,2,COP,nCOP,IADD10)
      CALL iDAFILE(Lu_CIGuga,2,iCOP1,nCOP+1,IADD10)
      LEN=ICOP1(nCOP+1)
      IF(LEN.EQ.0)GO TO 300
      IF(LEN.LT.0)GO TO 350
      DO 260 II=1,LEN
      IND=ICOP1(II)
      IF(ICHK.NE.0)GO TO 460
      IF(IND.NE.0)GO TO 371
      ICHK=1
      GO TO 260
460   ICHK=0
      INDI=IND
*      NI=MOD(INDI,IPOW10)
*      NJ=MOD(INDI/IPOW10,IPOW10)
      NI=IBITS(INDI,0,10)
      NJ=IBITS(INDI,10,10)
      NSIJ=MUL(NSM(NI),NSM(NJ))
      CALL IPO_CPF(IPOF,NVIR,MUL,NSYM,NSIJ,-1)
      IJ1=IROW(NI)+NJ
      ILIM=IPOF(NSYM+1)
      CALL FZERO(ABIJ,ILIM)
      CALL FZERO(AIBJ,ILIM)
      CALL FZERO(AJBI,ILIM)
      IF(ITER.EQ.1)GO TO 207
C     READ (AB/IJ) INTEGRALS
      IADR=LASTAD(NOVST+IJ1)
      JTURN=0
201   CALL iDAFILE(Lu_TiABIJ,2,IBUFIN,LBUF2,IADR)
      LENGTH=IBUFIN(LBUF1)
      IADR=IBUFIN(LBUF2)
      IF(LENGTH.EQ.0)GO TO 209
      IF(JTURN.EQ.1)GO TO 203
      CALL SCATTER(LENGTH,ABIJ,IBUFIN(LBUF0+1),BUFIN)
      GO TO 209
203   CALL SCATTER(LENGTH,AIBJ,IBUFIN(LBUF0+1),BUFIN)
209   IF(IADR.EQ.-1) GO TO 206
      GO TO 201
206   IF(JTURN.EQ.1)GO TO 360
C     READ (AI/BJ) INTEGRALS
207   IADR=LASTAD(NOVST+NOT2+IJ1)
      JTURN=1
      GO TO 201
C     CONSTRUCT FIRST ORDER MATRICES
360   FAC=D1/D2
      IF(NI.NE.NJ)FAC=D2*FAC
      IN=0
      IFT=0
      CALL IPO_CPF(IPOA,NVIR,MUL,NSYM,NSIJ,IFT)
852   DO 170 IASYM=1,NSYM
      IBSYM=MUL(NSIJ,IASYM)
      IF(IBSYM.GT.IASYM)GO TO 170
      IAB=IPOA(IASYM+1)-IPOA(IASYM)
      IF(IAB.EQ.0)GO TO 170
      CALL SECORD(AIBJ(IPOF(IASYM)+1),AIBJ(IPOF(IBSYM)+1),
     *FSEC(IN+1),FAC,NVIR(IASYM),NVIR(IBSYM),NSIJ,IFT)
      IN=IN+IAB
170   CONTINUE
      IF(IFT.EQ.1)GO TO 853
      INS=IN
      IFT=1
      FAC=D0
      GO TO 852
C     SQARE ABIJ
853   IF(ITER.EQ.1)GO TO 260
      DO 370 IASYM=1,NSYM
      IF(NVIR(IASYM).EQ.0)GO TO 370
      IBSYM=MUL(NSIJ,IASYM)
      IF(NVIR(IBSYM).EQ.0)GO TO 370
      IPF=IPOF(IASYM)+1
      IPF1=IPOF(IBSYM)+1
      IF(IASYM.GT.IBSYM)GO TO 369
      IF(NSIJ.NE.1)GO TO 361
      CALL SQUAR2_CPF(ABIJ(IPF),NVIR(IASYM))
      IF(NI.NE.NJ)GO TO 368
      CALL SQUAR2_CPF(AIBJ(IPF),NVIR(IASYM))
368   CALL MTRANS_CPF(AIBJ(IPF),AJBI(IPF),NVIR(IASYM),NVIR(IBSYM))
      GO TO 370
361   CALL MTRANS_CPF(ABIJ(IPF1),ABIJ(IPF),NVIR(IASYM),NVIR(IBSYM))
369   CALL MTRANS_CPF(AIBJ(IPF1),AJBI(IPF),NVIR(IASYM),NVIR(IBSYM))
370   CONTINUE
      GO TO 260
371   IF(IFAB.EQ.1)GO TO 262
CPAM97      IFAB=IAND(IND,1)
CPAM97      ITURN=IAND(ISHFT(IND,-1),1)
CPAM97      ITYP=IAND(ISHFT(IND,-2),7)
CPAM97      ICOUP=IAND(ISHFT(IND,-5),8191)
CPAM97      ICOUP1=IAND(ISHFT(IND,-18),8191)
*      IFAB=MOD(IND,2)
*      ITURN=MOD(IND/2,2)
*      ITYP=MOD(IND/4,8)
*      ICOUP=MOD(IND/IPOW5,IPOW13)
*      ICOUP1=MOD(IND/IPOW18,IPOW13)
      IFAB=IBITS(IND, 0,1)
      ITURN=IBITS(IND,1,1)
      ITYP=IBITS(IND,2,3)
      ICOUP=IBITS(IND,5,13)
      ICOUP1=IBITS(IND,18,13)
      CPL=COP(II)
      CPLA=D0
      IF(IFAB.NE.0)GO TO 260
      IF(ITURN.EQ.0)GO TO 263
      GO TO 100
262   CPLA=COP(II)
      IFAB=0
      GO TO 100
C     FIRST ORDER INTERACTION
263   INDA=ICOUP
      INDB=IRC(ITYP+1)+ICOUP1
      ISTAR=1
      IF(ITYP.EQ.1)ISTAR=INS+1
      IF(INS.EQ.0)GO TO 260
      IF(INDA.NE.IREF0)GO TO 342
      CPLL=CPL/SQRT(ENP(INDB))
      CALL DAXPY_(INS,CPLL,FSEC(ISTAR),1,S(INDEX(INDB)+1),1)
      IF(ITER.EQ.1)GO TO 260
      TERM=DDOT_(INS,C(INDEX(INDB)+1),1,FSEC(ISTAR),1)
      EPP(INDB)=EPP(INDB)+CPLL*TERM
      GO TO 260
342   ENPQ=(D1-THET(INDA,INDB)/D2)*(ENP(INDA)+ENP(INDB)-D1)+
     *THET(INDA,INDB)/D2
      FACS=SQRT(ENP(INDA))*SQRT(ENP(INDB))/ENPQ
      FACW=FACS*(D2-THET(INDA,INDB))/ENPQ
      FACWA=FACW*ENP(INDA)-FACS
      FACWB=FACW*ENP(INDB)-FACS
      COPI=CPL*C(INDA)
      CALL DAXPY_(INS,COPI*FACS,FSEC(ISTAR),1,S(INDEX(INDB)+1),1)
      CALL DAXPY_(INS,COPI*FACWB,FSEC(ISTAR),1,W(INDEX(INDB)+1),1)
      TERM=DDOT_(INS,FSEC(ISTAR),1,C(INDEX(INDB)+1),1)
      S(INDA)=S(INDA)+CPL*FACS*TERM
      W(INDA)=W(INDA)+CPL*FACWA*TERM
      GO TO 260
C     INTERACTIONS BETWEEN DOUBLES AND
C     INTERACTIONS BETWEEN SINGLES
100   IF(ITER.EQ.1)GO TO 260
C     CALL JTIME(IST)
      IFTA=0
      IFTB=0
      GO TO (109,110,111,112,113),ITYP
109   INDA=IRC(2)+ICOUP1
      INDB=IRC(2)+ICOUP
      IFTA=1
      IFTB=1
      GO TO 115
110   INDA=IRC(3)+ICOUP1
      INDB=IRC(3)+ICOUP
      GO TO 115
111   INDA=IRC(2)+ICOUP1
      INDB=IRC(3)+ICOUP
      IFTA=1
      GO TO 115
112   INDA=IRC(3)+ICOUP1
      INDB=IRC(2)+ICOUP
      IFTB=1
      GO TO 115
113   INDA=IRC(1)+ICOUP1
      INDB=IRC(1)+ICOUP
115   MYSYM=JSYM(INDA)
      NYSYM=MUL(MYSYM,NSIJ)
      MYL=MUL(MYSYM,LSYM)
      NYL=MUL(NYSYM,LSYM)
      ENPQ=(D1-THET(INDA,INDB)/D2)*(ENP(INDA)+ENP(INDB)-D1)+
     *THET(INDA,INDB)/D2
      FACS=SQRT(ENP(INDA))*SQRT(ENP(INDB))/ENPQ
      FACW=FACS*(D2-THET(INDA,INDB))/ENPQ
      FACWA=FACW*ENP(INDA)-FACS
      FACWB=FACW*ENP(INDB)-FACS
      CALL IPO_CPF(IPOA,NVIR,MUL,NSYM,MYL,IFTA)
      CALL IPO_CPF(IPOB,NVIR,MUL,NSYM,NYL,IFTB)
      INMY=INDEX(INDA)+1
      INNY=INDEX(INDB)+1
      IF(ITYP.NE.5)GO TO 71
C     DOUBLET-DOUBLET INTERACTIONS
      IN=IPOF(MYL+1)-IPOF(MYL)
      IF(IN.EQ.0)GO TO 260
      IPF=IPOF(MYL)+1
      CALL SETZ(F,IN)
      CALL DAXPY_(IN,CPL,AIBJ(IPF),1,F,1)
      CALL DAXPY_(IN,CPLA,ABIJ(IPF),1,F,1)
      IF(INDA.EQ.INDB)CALL SETZZ_CPF(F,NVIR(MYL))
      CALL SETZ(A,NVIR(NYL))
      CALL FMMM(C(INMY),F,A,1,NVIR(NYL),NVIR(MYL))
      CALL DAXPY_(NVIR(NYL),FACS,A,1,S(INNY),1)
      CALL DAXPY_(NVIR(NYL),FACWB,A,1,W(INNY),1)
      IF(INDA.EQ.INDB)GO TO 260
      CALL SETZ(A,NVIR(MYL))
      CALL FMMM(F,C(INNY),A,NVIR(MYL),1,NVIR(NYL))
      CALL DAXPY_(NVIR(MYL),FACS,A,1,S(INMY),1)
      CALL DAXPY_(NVIR(MYL),FACWA,A,1,W(INMY),1)
      GO TO 260
C     TRIPLET-SINGLET , SINGLET-TRIPLET ,
C     TRIPLET-TRIPLET AND SINGLET-SINGLET INTERACTIONS
71    DO 70 IASYM=1,NSYM
      IAB=IPOF(IASYM+1)-IPOF(IASYM)
      IF(IAB.EQ.0)GO TO 70
      ICSYM=MUL(MYL,IASYM)
      IBSYM=MUL(NYL,ICSYM)
      IF(INDA.EQ.INDB.AND.IBSYM.GT.IASYM)GO TO 70
      IF(NVIR(ICSYM).EQ.0)GO TO 70
      NAC=NVIR(IASYM)*NVIR(ICSYM)
      NBC=NVIR(IBSYM)*NVIR(ICSYM)
      IF(ICSYM.GE.IASYM)GO TO 31
      IF(ICSYM.GE.IBSYM)GO TO 32
C     CASE 1 , IASYM > ICSYM AND IBSYM > ICSYM
      IPF=IPOF(IASYM)+1
      CALL SETZ(F,IAB)
      CALL DAXPY_(IAB,CPL,AIBJ(IPF),1,F,1)
      CALL DAXPY_(IAB,CPLA,ABIJ(IPF),1,F,1)
      IF(INDA.EQ.INDB)CALL SETZZ_CPF(F,NVIR(IASYM))
      CALL SETZ(A,NBC)
      CALL FMMM(C(INMY+IPOA(IASYM)),F,A,NVIR(ICSYM),
     *NVIR(IBSYM),NVIR(IASYM))
      CALL DAXPY_(NBC,FACS,A,1,S(INNY+IPOB(IBSYM)),1)
      CALL DAXPY_(NBC,FACWB,A,1,W(INNY+IPOB(IBSYM)),1)
      IF(INDA.EQ.INDB)GO TO 70
      IPF=IPOF(IBSYM)+1
      CALL SETZ(F,IAB)
      CALL DAXPY_(IAB,CPL,AJBI(IPF),1,F,1)
      CALL DAXPY_(IAB,CPLA,ABIJ(IPF),1,F,1)
      CALL SETZ(A,NAC)
      CALL FMMM(C(INNY+IPOB(IBSYM)),F,A,NVIR(ICSYM),
     *NVIR(IASYM),NVIR(IBSYM))
      CALL DAXPY_(NAC,FACS,A,1,S(INMY+IPOA(IASYM)),1)
      CALL DAXPY_(NAC,FACWA,A,1,W(INMY+IPOA(IASYM)),1)
      GO TO 70
C     CASE 2 , IASYM > ICSYM AND ICSYM > OR = IBSYM
32    IPF=IPOF(IBSYM)+1
      CALL SETZ(F,IAB)
      CALL DAXPY_(IAB,CPL,AJBI(IPF),1,F,1)
      CALL DAXPY_(IAB,CPLA,ABIJ(IPF),1,F,1)
      CALL MTRANS_CPF(C(INMY+IPOA(IASYM)),A,NVIR(IASYM),NVIR(ICSYM))
      CALL SETZ(B,NBC)
      CALL FMMM(F,A,B,NVIR(IBSYM),NVIR(ICSYM),NVIR(IASYM))
      IF(NYL.NE.1)GO TO 35
      CALL SETZ(A,NBC)
      CALL DAXPY_(NBC,FACS,B,1,A,1)
      IF(IFTB.EQ.1)GO TO 134
      CALL SIADD_CPF(A,S(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      CALL SETZ(A,NBC)
      CALL DAXPY_(NBC,FACWB,B,1,A,1)
      CALL SIADD_CPF(A,W(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      CALL SQUAR_CPF(C(INNY+IPOB(IBSYM)),A,NVIR(IBSYM))
      GO TO 36
134   CALL TRADD_CPF(A,S(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      CALL SETZ(A,NBC)
      CALL DAXPY_(NBC,FACWB,B,1,A,1)
      CALL TRADD_CPF(A,W(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      CALL SQUARN_CPF(C(INNY+IPOB(IBSYM)),A,NVIR(IBSYM))
      GO TO 36
35    IF(IFTB.EQ.1)GO TO 135
      CALL DAXPY_(NBC,FACS,B,1,S(INNY+IPOB(ICSYM)),1)
      CALL DAXPY_(NBC,FACWB,B,1,W(INNY+IPOB(ICSYM)),1)
      GO TO 136
135   CALL DAXPY_(NBC,-FACS,B,1,S(INNY+IPOB(ICSYM)),1)
      CALL DAXPY_(NBC,-FACWB,B,1,W(INNY+IPOB(ICSYM)),1)
136   CALL MTRANS_CPF(C(INNY+IPOB(ICSYM)),A,NVIR(ICSYM),NVIR(IBSYM))
      IF(IFTB.EQ.1)CALL VNEG_CPF(A,1,A,1,NBC)
36    CALL SETZ(B,NAC)
      CALL FMMM(A,F,B,NVIR(ICSYM),NVIR(IASYM),NVIR(IBSYM))
      CALL DAXPY_(NAC,FACS,B,1,S(INMY+IPOA(IASYM)),1)
      CALL DAXPY_(NAC,FACWA,B,1,W(INMY+IPOA(IASYM)),1)
      GO TO 70
31    IF(ICSYM.GE.IBSYM)GO TO 33
C     CASE 3 , ICSYM > OR = IASYM AND IBSYM > ICSYM
      IPF=IPOF(IASYM)+1
      CALL SETZ(F,IAB)
      CALL DAXPY_(IAB,CPL,AIBJ(IPF),1,F,1)
      CALL DAXPY_(IAB,CPLA,ABIJ(IPF),1,F,1)
      IF(MYL.NE.1)GO TO 39
      IF(IFTA.EQ.0)CALL SQUAR_CPF(C(INMY+IPOA(IASYM)),A,NVIR(IASYM))
      IF(IFTA.EQ.1)CALL SQUARN_CPF(C(INMY+IPOA(IASYM)),A,NVIR(IASYM))
      GO TO 40
39    CALL MTRANS_CPF(C(INMY+IPOA(ICSYM)),A,NVIR(ICSYM),NVIR(IASYM))
      IF(IFTA.EQ.1)CALL VNEG_CPF(A,1,A,1,NAC)
40    CALL SETZ(B,NBC)
      CALL FMMM(A,F,B,NVIR(ICSYM),NVIR(IBSYM),NVIR(IASYM))
      CALL DAXPY_(NBC,FACS,B,1,S(INNY+IPOB(IBSYM)),1)
      CALL DAXPY_(NBC,FACWB,B,1,W(INNY+IPOB(IBSYM)),1)
      CALL MTRANS_CPF(C(INNY+IPOB(IBSYM)),A,NVIR(IBSYM),NVIR(ICSYM))
      CALL SETZ(B,NAC)
      CALL FMMM(F,A,B,NVIR(IASYM),NVIR(ICSYM),NVIR(IBSYM))
      IF(MYL.NE.1)GO TO 46
      CALL SETZ(A,NAC)
      CALL DAXPY_(NAC,FACS,B,1,A,1)
      IF(IFTA.EQ.1)GO TO 146
      CALL SIADD_CPF(A,S(INMY+IPOA(IASYM)),NVIR(IASYM))
      CALL SETZ(A,NAC)
      CALL DAXPY_(NAC,FACWA,B,1,A,1)
      CALL SIADD_CPF(A,W(INMY+IPOA(IASYM)),NVIR(IASYM))
      GO TO 70
146   CALL TRADD_CPF(A,S(INMY+IPOA(IASYM)),NVIR(IASYM))
      CALL SETZ(A,NAC)
      CALL DAXPY_(NAC,FACWA,B,1,A,1)
      CALL TRADD_CPF(A,W(INMY+IPOA(IASYM)),NVIR(IASYM))
      GO TO 70
46    IF(IFTA.EQ.1)GO TO 1146
      CALL DAXPY_(NAC,FACS,B,1,S(INMY+IPOA(ICSYM)),1)
      CALL DAXPY_(NAC,FACWA,B,1,W(INMY+IPOA(ICSYM)),1)
      GO TO 70
1146  CALL DAXPY_(NAC,-FACS,B,1,S(INMY+IPOA(ICSYM)),1)
      CALL DAXPY_(NAC,-FACWA,B,1,W(INMY+IPOA(ICSYM)),1)
      GO TO 70
C     CASE 4 , ICSYM > OR = IASYM AND ICSYM > OR = IBSYM
33    IPF=IPOF(IBSYM)+1
      CALL SETZ(F,IAB)
      CALL DAXPY_(IAB,CPL,AJBI(IPF),1,F,1)
      CALL DAXPY_(IAB,CPLA,ABIJ(IPF),1,F,1)
      IF(INDA.EQ.INDB)CALL SETZZ_CPF(F,NVIR(IASYM))
      IF(MYL.NE.1)GO TO 41
      IF(IFTA.EQ.0)CALL SQUAR_CPF(C(INMY+IPOA(IASYM)),A,NVIR(IASYM))
      IF(IFTA.EQ.1)CALL SQUARM_CPF(C(INMY+IPOA(IASYM)),A,NVIR(IASYM))
      GO TO 42
41    IF(IFTA.EQ.0)CALL DCOPY_(NAC,C(INMY+IPOA(ICSYM)),1,A,1)
      IF(IFTA.EQ.1)CALL VNEG_CPF(C(INMY+IPOA(ICSYM)),1,A,1,NAC)
42    CALL SETZ(B,NBC)
      CALL FMMM(F,A,B,NVIR(IBSYM),NVIR(ICSYM),NVIR(IASYM))
      IF(NYL.NE.1)GO TO 43
      CALL SETZ(A,NBC)
      CALL DAXPY_(NBC,FACS,B,1,A,1)
      IF(IFTB.EQ.1)GO TO 143
      CALL SIADD_CPF(A,S(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      CALL SETZ(A,NBC)
      CALL DAXPY_(NBC,FACWB,B,1,A,1)
      CALL SIADD_CPF(A,W(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      GO TO 44
143   CALL TRADD_CPF(A,S(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      CALL SETZ(A,NBC)
      CALL DAXPY_(NBC,FACWB,B,1,A,1)
      CALL TRADD_CPF(A,W(INNY+IPOB(ICSYM)),NVIR(IBSYM))
      GO TO 44
43    IF(IFTB.EQ.1)GO TO 144
      CALL DAXPY_(NBC,FACS,B,1,S(INNY+IPOB(ICSYM)),1)
      CALL DAXPY_(NBC,FACWB,B,1,W(INNY+IPOB(ICSYM)),1)
      GO TO 44
144   CALL DAXPY_(NBC,-FACS,B,1,S(INNY+IPOB(ICSYM)),1)
      CALL DAXPY_(NBC,-FACWB,B,1,W(INNY+IPOB(ICSYM)),1)
44    IF(INDA.EQ.INDB)GO TO 70
      IPF=IPOF(IASYM)+1
      CALL SETZ(F,IAB)
      CALL DAXPY_(IAB,CPL,AIBJ(IPF),1,F,1)
      CALL DAXPY_(IAB,CPLA,ABIJ(IPF),1,F,1)
      IF(NYL.NE.1)GO TO 37
      IF(IFTB.EQ.0)CALL SQUAR_CPF(C(INNY+IPOB(IBSYM)),A,NVIR(IBSYM))
      IF(IFTB.EQ.1)CALL SQUARM_CPF(C(INNY+IPOB(IBSYM)),A,NVIR(IBSYM))
      GO TO 38
37    IF(IFTB.EQ.0)CALL DCOPY_(NBC,C(INNY+IPOB(ICSYM)),1,A,1)
      IF(IFTB.EQ.1)CALL VNEG_CPF(C(INNY+IPOB(ICSYM)),1,A,1,NBC)
38    CALL SETZ(B,NAC)
      CALL FMMM(F,A,B,NVIR(IASYM),NVIR(ICSYM),NVIR(IBSYM))
      IF(MYL.NE.1)GO TO 45
      CALL SETZ(A,NAC)
      CALL DAXPY_(NAC,FACS,B,1,A,1)
      IF(IFTA.EQ.1)GO TO 145
      CALL SIADD_CPF(A,S(INMY+IPOA(ICSYM)),NVIR(IASYM))
      CALL SETZ(A,NAC)
      CALL DAXPY_(NAC,FACWA,B,1,A,1)
      CALL SIADD_CPF(A,W(INMY+IPOA(ICSYM)),NVIR(IASYM))
      GO TO 70
145   CALL TRADD_CPF(A,S(INMY+IPOA(ICSYM)),NVIR(IASYM))
      CALL SETZ(A,NAC)
      CALL DAXPY_(NAC,FACWA,B,1,A,1)
      CALL TRADD_CPF(A,W(INMY+IPOA(ICSYM)),NVIR(IASYM))
      GO TO 70
45    IF(IFTA.EQ.1)GO TO 147
      CALL DAXPY_(NAC,FACS,B,1,S(INMY+IPOA(ICSYM)),1)
      CALL DAXPY_(NAC,FACWA,B,1,W(INMY+IPOA(ICSYM)),1)
      GO TO 70
147   CALL DAXPY_(NAC,-FACS,B,1,S(INMY+IPOA(ICSYM)),1)
      CALL DAXPY_(NAC,-FACWA,B,1,W(INMY+IPOA(ICSYM)),1)
70    CONTINUE
260   CONTINUE
      GO TO 300
350   CALL MDSQ2(C,S,W,MUL,INDEX,JSY,NDIAG,INUM,IRC(3),
     *LSYM,NVIRT,SQ2)
C      NCONF=JSC(4)
C      WRITE(6,787)(S(I),I=1,NCONF)
C  787 FORMAT(1X,'S,FAIBJ',5F10.6)
C      WRITE(6,786)(W(I),I=1,NCONF)
C  786 FORMAT(1X,'W,FAIBJ',5F10.6)
      RETURN
      END
