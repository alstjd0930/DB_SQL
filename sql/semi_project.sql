DESC member_tbl_02
desc money_tbl_02

select *
from member_tbl_02;
select *
from money_tbl_02;

SELECT A.CUSTNO, A.CUSTNAME, A.GRADE, SUM(B.PRICE) AS TOTAL FROM MEMBER_TBL_02 A JOIN MONEY_TBL_02 B ON A.CUSTNO = B.CUSTNO GROUP BY(A.CUSTNO, A.CUSTNAME, A.GRADE) ORDER BY TOTAL DESC;

select a.custno, a.custname, case when a.grade = 'A' then 'VIP' when a.grade = 'B' then '일반' when a.grade = 'C' then '직원' end as 등급, sum(b.price) total from member_tbl_02 a join money_tbl_02 b on a.custno=b.custno group by(a.custno, a.custname, a.grade) order by total desc ;