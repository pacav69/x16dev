4 REM --TERIMAKASIH J.C.--C2019--
5 GOSUB1050:GOSUB2000
6 REM G=1WEAK GRAPPLE;G=2STRONG;U CAN ONLY BE KO'D FROM STRONG GRAPPLE MOVE
7 REMDIM P$(5,5):DIMPT$(5,5)
8 XO=19:XT=20:SG=1:MX=27:MN=12:E(1)=50:E(2)=50:K$(1)="\X1E\X12 \X92":K$(2)="\X1E\X12 \X92":PR=0
9 REM SG=1 IN RING/SG=2 OUT RING
10 PRINT"\X93":N$(1)="PLR 1":N$(2)="PLR 2"
15 ONSGGOSUB1000,1100
16 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";:IFSG=2THENPRINT"\X11\X11\X11\X11";
18 PRINT TAB(XO);PO$
20 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";:IFSG=2THENPRINT"\X11\X11\X11\X11";
22 PRINT TAB(XT);PT$
30 GETA$
31 IFE(1)<50THENE(1)=E(1)+.05
32 IFE(2)<50THENE(2)=E(2)+.05
33 IFA$=""THEN30
34 IFA$="\X1D"ANDXO<MXANDXO+1<>XTTHENXO=XO+1:GOTO15
35 IFA$="\X9D"ANDXO>MNTHENXO=XO-1:GOTO15
36 IFA$="A"ANDXT>MNANDXT-1<>XOTHENXT=XT-1:GOTO15
38 IFA$="D"ANDXT<MXTHENXT=XT+1:GOTO15
40 IFA$="\X91"ANDXO+1=XTTHENG=1:GOTO200
42 IFA$="W"ANDXT-1=XOTHENG=1:GOTO300
44 IFA$="\X11"ANDXO+1=XTTHENG=2:GOTO250
46 IFA$="S"ANDXT-1=XOTHENG=2:GOTO350
48 IFSG=1THENIFA$="1"THENSG=2:MN=6:MX=33:GOTO10
50 IFSG=2THENIFA$="1"THENSG=1:MN=12:MX=27:XO=19:XT=20:GOTO10
52 IFA$="2"THENEG=1:GOTO15
54 GOTO30
100 REM -GLOBAL PLR MOVE-
110 ONSGGOSUB1000,1100
111 IFSG=2THEND$="\X11\X11\X11\X11"
112 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";D$;TAB(U);M$:FORI=1TO100:NEXT
114 ONSGGOSUB1000,1100
116 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";D$;TAB(U);MT$:FORI=1TO100:NEXT
118 U=0:M$="":MT$="":D$=""
120 E(L)=E(L)-PR
122 IFE(L)>36THENK$(L)="\X1E\X12 \X92"
124 IFE(L)<37THENIFE(L)>24THENK$(L)="\X9E\X12 \X92"
126 IFE(L)<25THENIFE(L)>12THENK$(L)="\X1C\X12 \X92"
128 IFE(L)>0THENIFE(L)<13THENK$(L)="\X9A\X12 \X92"
130 IFE(L)<1THENK$(L)="\X90\X12 \X92"
140 IFG=2THENIFE(L)<1THENR=INT(RND(1)*2+1)
142 IFR=2THENPRINT"\X9A\X13\X11\X11\X11\X11\X11\X11\X11\X11\X1D\X1D\X1D\X1D\X1D\X1D\X1D\X1D\X1D\X1D";N$(L);" GOT K.O.'D":END
144 IFE(L)<1THENIFS=1THENPRINT"\X9A\X13\X11\X11\X11\X11\X11\X11\X11\X11\X1D\X1D\X1D\X1D\X1D\X1D\X1D\X1D\X1D\X1D";N$(L);" GOT K.O.'D":END
199 GOTO15
200 IFSG=2THEND$="\X11\X11\X11\X11"
201 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";D$;TAB(XT);C$(1,2);"\X11\XBD":U=XO:PR=2:L=2
202 GETA$:IFA$=""THEN202:REM WEAK
204 IFA$="\X91"ANDXO=MX-1THENM$="\X91\X91\X91\X91\X1D\X1D"+P$(1,1):MT$=PT$(1,1):GOTO100
206 IFA$="\X91"THENM$=P$(1,1):MT$=PT$(1,1):GOTO100
208 IFA$="\X11"THENM$=P$(1,6):MT$=PT$(1,6):GOTO100
210 GOTO16
250 IFSG=2THEND$="\X11\X11\X11\X11"
251 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";D$;TAB(XT);C$(1,2);"\X11\XBD":U=XO:PR=5:L=2
252 GETA$:IFA$=""THEN252:REM STRONG
254 REMIFA$="\X11"ANDXO=MX-1THENM$="\X91\X91\X91\X91\X1D\X1D"+P$(2,2):MT$=PT$(2,2):GOTO100
256 IFA$="\X11"THENM$=P$(1,2):MT$=PT$(1,2):GOTO100
258 IFA$="\X91"THENM$=P$(1,3):MT$=PT$(1,3):GOTO100
260 IFA$="\X1D"THENM$=P$(1,4):MT$=PT$(1,4):GOTO100
262 IFA$="\X9D"THENM$=P$(1,5):MT$=PT$(1,5):GOTO100
264 GOTO16
300 IFSG=2THEND$="\X11\X11\X11\X11"
301 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";D$;TAB(XO);C$(2,2);"\X11\XAD":U=XT:PR=2:L=1
302 GETA$:IFA$=""THEN302:REM WEAK
304 IFA$="W"ANDXT=MN+1THENM$="\X91\X91\X91\X91\X9D\X9D"+P$(2,1):MT$=PT$(2,1):GOTO100
306 IFA$="W"THENM$=P$(2,1):MT$=PT$(2,1):GOTO100
308 IFA$="S"THENM$=P$(2,6):MT$=PT$(2,6):GOTO100
310 GOTO16
350 IFSG=2THEND$="\X11\X11\X11\X11"
351 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11\X11\X11\X11";D$;TAB(XO);C$(2,2);"\X11\XAD":U=XT:PR=5:L=1
352 GETA$:IFA$=""THEN352:REM STRONG
354 IFA$="S"THENM$=P$(2,2):MT$=PT$(2,2):GOTO100
356 IFA$="W"THENM$=P$(2,3):MT$=PT$(2,3):GOTO100
358 IFA$="A"THENM$=P$(2,4):MT$=PT$(2,4):GOTO100
360 IFA$="D"THENM$=P$(2,5):MT$=PT$(2,5):GOTO100
362 GOTO16
1000 REM -DRAW RING-
1010 PRINT"\X13\X11\X11\X11";
1012 PRINT"                                "
1014 PRINT"                                "
1016 PRINT"                                "
1018 PRINT"                                "
1020 PRINT"                                "
1022 PRINT"                                "
1024 PRINT"                                "
1026 PRINT"           \X81\XAB\X05\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\X81\XB3   "
1028 PRINT"          \X05\XCE\X81\XAB\X05\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\X81\XB3\X05\XCD     "
1030 PRINT"\X9B\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\X05\XCE\XCE\X81\XAB\X05\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\XC3\X81\XB3\X05\XCD\XCD\X9B\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF"
1032 PRINT"        \X81\XAB\X05\XCE\XCE\X9B\XCE\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XCD\X05\XCD\XCD\X81\XB3   "
1034 PRINT"        \X81\XAB\X05\XCE\X9B\XCE                  \XCD\X05\XCD\X81\XB3   "
1036 PRINT"        \X81\XAB\X9B\XCE                    \XCD\X81\XB3   "
1038 PRINT"         \X12\X9BRETRO                 \X92   "
1039 PRINT"         \X12\X9BWRESTLING             \X92\X9A   "
1040 PRINTTAB(9);K$(1);" \X9A";N$(1):PRINTTAB(9);K$(2);" \X9A";N$(2)
1042 PRINT"\X9B\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7"
1044 IFEG=1THENPRINT"\X9A8-BIT GUY VS LGR!"
1046 RETURN
1050 C$(1,1)="\X9E":C$(1,2)="\X9E":C$(1,3)="\X90":C$(1,4)="\X05"
1052 C$(2,1)="\X9E":C$(2,2)="\X9E":C$(2,3)="\X90":C$(2,4)="\X05"
1054 PO$=C$(1,1)+"\XD1\X11\X9D"+C$(1,2)+"\XAB\X11\X9D"+C$(1,3)+"\XDD\X11\X9D"+C$(1,4)+"\XAD"
1056 PT$=C$(2,1)+"\XD1\X11\X9D"+C$(2,2)+"\XB3\X11\X9D"+C$(2,3)+"\XDD\X11\X9D"+C$(2,4)+"\XBD"
1058 RETURN
1100 PRINT"\X13\X11\X11\X11\X11\X11\X11\X11";
1102 PRINT"                                       "
1104 PRINT"                                       "
1106 PRINT"                                       "
1108 PRINT"                                   \X81\XAB\X05\XC3\XC3\XC3"
1110 PRINT"                                   \X81\XAB\X05\XCD\XC3\XC3"
1112 PRINT"\X9B\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\XAF\X81\XAB\X05\XCD\XCD\XC3"
1114 PRINT"                                  \X9B\XAA\X12\XDF\X92\X05\XCD\XCD\X81\XAB"
1116 PRINT"   \X95\X12\XA9 \X92\XA9\X98\XB4                           \X9B\XAA\X12 \XDF\X92\X05\XCD\X81\XAB"
1118 PRINT"  \X95\X12\XA9 \X92\XA9 \X98\XB4                            \X9B\XDF\X12 \XDF\X92\X81\XAB"
1120 PRINT"  \X98\XCF\XD0                                \X9B\XDF\X12  \X92"
1122 PRINT"  \X98\XB4\XAA                                 \X9B\XDF\X12 \X92"
1124 PRINT"                                       "
1126 PRINT"                                       "
1128 PRINT"\X9B\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7\XB7"
1130 PRINTTAB(9);K$(1);" \X9A";N$(1):PRINTTAB(9);K$(2);" \X9A";N$(2)
1132 RETURN
2000 GOSUB3114:GOSUB3010:P$(1,1)="\X91\X91\X91"+BB$+"\X9D"+B$
2002 GOSUB3122:GOSUB3020:PT$(1,1)="\X11\X11\X11\X9D\X9D\X9D\X9D\X9D\X9D"+BB$+"\X9D"+B$
2004 GOSUB3010:GOSUB3122:P$(1,2)="\X9D"+BB$+"\X9D\X9D\X9D"+B$
2006 PT$(1,2)=B$+"\X1D"+BB$
2010 GOSUB3016:GOSUB3112:P$(2,1)="\X91\X91\X91"+B$+"\X9D"+BB$
2012 GOSUB3122:GOSUB3020:PT$(2,1)="\X11\X11\X11\X1D\X1D\X1D"+B$+"\X9D\X9D\X9D\X9D\X9D\X9D\X9D"+BB$
2014 GOSUB3112:GOSUB3020:P$(2,2)="\X9D\X9D"+B$+"\X9D\X9D"+BB$
2016 PT$(2,2)="\X11\X11\X11\X9D\X9D\X9D\X9D\X9D"+B$+"\X91\X91\X91\X1D"+BB$
2020 B$=PO$:GOSUB3116:P$(1,3)="\X91\X91\X1D"+BB$+"\X91\X9D\X9D"+B$
2022 GOSUB3030:PT$(1,3)="\X1D"+BB$+"\X91\X91\X9D\X9D"+B$
2024 GOSUB3012:GOSUB3124:P$(1,4)=B$+"\X91\X91\X9D"+BB$
2026 GOSUB3036:PT$(1,4)="\X9D\X9D\X11\X11\X11"+B$+"\X11\X9D"+BB$
2030 BB$=PT$:GOSUB3014:P$(2,3)="\X9D\X91\X91"+B$+"\X91"+BB$
2032 GOSUB3130:PT$(2,3)="\X9D"+B$+"\X91\X91"+BB$
2036 GOSUB3110:GOSUB3026:P$(2,4)=BB$+"\X91\X91\X9D\X9D\X9D\X9D"+B$
2038 GOSUB3136:PT$(2,4)="\X11\X11"+BB$+"\X9D\X9D\X9D\X9D\X9D\X9D"+B$
2040 B$=PO$:GOSUB3132:P$(1,5)=B$+"\X91\X91\X9D"+BB$
2042 GOSUB3020:GOSUB3134:PT$(1,5)="\X11\X11\X11\X9D\X9D\X9D"+B$+"\X9D\X9D\X9D\X91\X91"+BB$
2050 GOSUB3038:BB$=PT$:P$(1,6)=B$+"\X91\X91"+BB$
2052 GOSUB3040:GOSUB3122:PT$(1,6)="\X11\X11\X11\X9D\X9D"+BB$+"\X91\X91\X9D\X9D"+B$
2060 BB$=PT$:GOSUB3032:P$(2,5)=BB$+"\X91\X9D\X9D\X9D"+B$
2062 GOSUB3122:GOSUB3034:PT$(2,5)="\X11\X11\X11"+BB$+"\X9D\X9D\X9D\X91\X91"+B$
2070 GOSUB3138:B$=PO$:P$(2,6)="\X9D"+BB$+"\X91\X91\X9D\X9D"+B$
2072 GOSUB3140:GOSUB3022:PT$(2,6)="\X11\X11\X11\X9D\X9D"+B$+"\X9D\X9D\X91\X91"+BB$
2099 BB$="":B$=""
2100 RETURN
3000 REM -POSITIONS-LATEST UPDATE SINCE C64'S LATEST ONE-
3009 REM -PLR 1-
3010 B$=C$(1,1)+"\XD1\X11\X9D"+C$(1,2)+"\XAB\X11\X9D"+C$(1,3)+"\XDD\X11\X9D"+C$(1,4)+"\XAD":REM S R
3011 RETURN
3012 B$=C$(1,1)+"\XD1\X11\X9D"+C$(1,2)+"\XB3\X11\X9D"+C$(1,3)+"\XDD\X11\X9D"+C$(1,4)+"\XBD":REM S L
3013 RETURN
3014 B$=C$(1,4)+"\XB0\X11\X9D"+C$(1,3)+"\XDD\X11\X9D"+C$(1,2)+"\XAB\X11\X9D"+C$(1,1)+"\XD1":REM USD R
3015 RETURN
3016 B$=C$(1,4)+"\XAE\X11\X9D"+C$(1,3)+"\XDD\X11\X9D"+C$(1,2)+"\XB3\X11\X9D"+C$(1,1)+"\XD1":REM USD L
3017 RETURN
3019 REM -LYING DOWN-
3020 B$=C$(1,1)+"\XD1"+C$(1,2)+"\XB1"+C$(1,3)+"\XC3"+C$(1,4)+"\XBD":REM FUL
3021 RETURN
3022 B$=C$(1,4)+"\XAD"+C$(1,3)+"\XC3"+C$(1,2)+"\XB1"+C$(1,1)+"\XD1":REM FUR
3023 RETURN
3024 B$=C$(1,1)+"\XD1"+C$(1,2)+"\XB2"+C$(1,3)+"\XC3"+C$(1,4)+"\XAE":REM FDL
3025 RETURN
3026 B$=C$(1,4)+"\XB0"+C$(1,3)+"\XC3"+C$(1,2)+"\XB2"+C$(1,1)+"\XD1":REM FDR
3027 RETURN
3030 B$=C$(1,1)+"\XD1"+C$(1,2)+"\X11\X9D\XAB"+C$(1,3)+"\X11\X9D\XAD"+C$(1,4)+"\XBD":REM SR
3031 RETURN
3032 B$=C$(1,4)+"\XAD\X91\X9D"+C$(1,3)+"\XB0"+C$(1,2)+"\XB2"+C$(1,1)+"\XD1":REM RS RR
3033 RETURN
3034 B$=C$(1,4)+"\XB0"+C$(1,3)+"\XAE"+C$(1,2)+"\X11\X9D\XB3"+C$(1,1)+"\X11\X9D\XD1":REM RS RD
3035 RETURN
3036 B$=C$(1,4)+"\XAD"+C$(1,3)+"\XC3"+C$(1,2)+"\XBD"+C$(1,1)+"\X91\X9D\XD1":REM BULLDOG
3037 RETURN
3038 B$=C$(1,3)+"\XB0"+C$(1,4)+"\XBD"+C$(1,2)+"\X11\X9D\X9D\XB3"+C$(1,1)+"\X11\X9D\XD1":RETURN
3040 B$=C$(1,1)+"\XD1"+C$(1,2)+"\X11\X9D\XAB"+C$(1,3)+"\X11\X9D\XBD":RETURN
3109 REM -PLR 2-
3110 BB$=C$(2,1)+"\XD1\X11\X9D"+C$(2,2)+"\XAB\X11\X9D"+C$(2,3)+"\XDD\X11\X9D"+C$(2,4)+"\XAD":REM S R
3111 RETURN
3112 BB$=C$(2,1)+"\XD1\X11\X9D"+C$(2,2)+"\XB3\X11\X9D"+C$(2,3)+"\XDD\X11\X9D"+C$(2,4)+"\XBD":REM S L
3113 RETURN
3114 BB$=C$(2,4)+"\XB0\X11\X9D"+C$(2,3)+"\XDD\X11\X9D"+C$(2,2)+"\XAB\X11\X9D"+C$(2,1)+"\XD1":REM USD R
3115 RETURN
3116 BB$=C$(2,4)+"\XAE\X11\X9D"+C$(2,3)+"\XDD\X11\X9D"+C$(2,2)+"\XB3\X11\X9D"+C$(2,1)+"\XD1":REM USD L
3117 RETURN
3119 REM -LYING DOWN-
3120 BB$=C$(2,1)+"\XD1"+C$(2,2)+"\XB1"+C$(2,3)+"\XC3"+C$(2,4)+"\XBD":REM FUL
3121 RETURN
3122 BB$=C$(2,4)+"\XAD"+C$(2,3)+"\XC3"+C$(2,2)+"\XB1"+C$(2,1)+"\XD1":REM FUR
3123 RETURN
3124 BB$=C$(2,1)+"\XD1"+C$(2,2)+"\XB2"+C$(2,3)+"\XC3"+C$(2,4)+"\XAE":REM FDL
3125 RETURN
3126 BB$=C$(2,4)+"\XB0"+C$(2,3)+"\XC3"+C$(2,2)+"\XB2"+C$(2,1)+"\XD1":REM FDR
3127 RETURN
3130 BB$=C$(2,1)+"\XD1"+C$(2,2)+"\X11\X9D\XB3"+C$(2,4)+"\X11\X9D\X9D\XAD"+C$(2,3)+"\XBD":REM SL
3131 RETURN
3132 BB$=C$(1,1)+"\XD1"+C$(1,2)+"\XB2"+C$(1,3)+"\XAE"+C$(1,4)+"\X11\X9D\XBD":REM LS RL
3133 RETURN
3134 BB$=C$(2,3)+"\XB0"+C$(2,4)+"\XAE"+C$(2,2)+"\X11\X9D\X9D\XAB"+C$(2,1)+"\X11\X9D\XD1":REM LS RD
3135 RETURN
3136 BB$=C$(2,1)+"\XD1\X11\X9D"+C$(2,2)+"\XAD"+C$(2,3)+"\XC3"+C$(2,4)+"\XBD":REM BULLDOG
3137 RETURN
3138 BB$=C$(2,4)+"\XAD"+C$(2,3)+"\XAE"+C$(2,2)+"\X11\X9D\XAB"+C$(2,1)+"\X11\X9D\XD1":RETURN
3140 BB$=C$(2,1)+"\XD1"+C$(2,2)+"\X11\X9D\XAB"+C$(2,3)+"\X11\X9D\XBD":RETURN