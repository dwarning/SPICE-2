      SUBROUTINE ZERO4(ARRAY,LENGTH)
C     8 byte integer used, no real*4 used
      DOUBLE PRECISION ARRAY(LENGTH)
      IF(LENGTH.EQ.0) RETURN
      DO 10 I=1,LENGTH
         ARRAY(I)=0.0
  10  CONTINUE
      RETURN
      END
      SUBROUTINE ZERO8(ARRAY,LENGTH)
      DOUBLE PRECISION ARRAY(LENGTH)
      IF(LENGTH.EQ.0) RETURN
      DO 10 I=1,LENGTH
         ARRAY(I)=0.D0
  10  CONTINUE
      RETURN
      END
      SUBROUTINE ZERO16(ARRAY,LENGTH)
      COMPLEX ARRAY(LENGTH)
      IF(LENGTH.EQ.0) RETURN
      DO 10 I=1,LENGTH
         ARRAY(I)=(0.0,0.0)
  10  CONTINUE
      RETURN
      END
      SUBROUTINE COPY4(FROM,TO,NWORDS)
C     8 byte integer used, no real*4 used
      DOUBLE PRECISION FROM(1),TO(1)
      IF(NWORDS.EQ.0) RETURN
      IF(LOCF(FROM(1)).LT.LOCF(TO(1))) GOTO 20
      DO 10 I=1,NWORDS
       TO(I)=FROM(I)
  10    CONTINUE
      RETURN
  20    I=NWORDS
  30    TO(I)=FROM(I)
      I=I-1
      IF(I.NE.0) GOTO 30
      RETURN
      END
      SUBROUTINE COPY8(FROM,TO,NWORDS)
      DOUBLE PRECISION FROM(1),TO(1)
      IF(NWORDS.EQ.0) RETURN
      IF(LOCF(FROM(1)).LT.LOCF(TO(1))) GOTO 20
      DO 10 I=1,NWORDS
         TO(I)=FROM(I)
  10  CONTINUE
      RETURN
  20  I=NWORDS
  30  TO(I)=FROM(I)
      I=I-1
      IF(I.NE.0) GOTO 30
      RETURN
      END
      SUBROUTINE COPY16(FROM,TO,NWORDS)
      COMPLEX FROM(1),TO(1)
      IF(NWORDS.EQ.0) RETURN
      IF(LOCF(FROM(1)).LT.LOCF(TO(1))) GOTO 20
      DO 10 I=1,NWORDS
         TO(I)=FROM(I)
  10  CONTINUE
      RETURN
  20  I=NWORDS
  30  TO(I)=FROM(I)
      I=I-1
      IF(I.NE.0) GOTO 30
      RETURN
      END
      SUBROUTINE MOVE(A,I,B,J,N)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      CHARACTER*150 C,D
      DIMENSION A(*),B(*)
      XDA=(I+N-1)/8.
      IDA=INT(XDA)
      IF(XDA.GT.IDA) IDA=IDA+1
      XDB=(J+N-1)/8.
      IDB=INT(XDB)
      IF(XDB.GT.IDB) IDB=IDB+1
      WRITE(C,'(18A8)') (B(M),M=1,IDB)
      WRITE(D,'(18A8)') (A(M),M=1,IDA)
      D(I:I+N-1)=C(J:J+N-1)
      READ(D,'(18A8)') (A(M),M=1,IDA)
      RETURN
      END
