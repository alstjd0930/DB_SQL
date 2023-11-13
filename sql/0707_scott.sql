SELECT *
FROM emp
;
SELECT *
FROM DEPT
;

SELECT *
FROM salgrade
;

select *
from tb_student
;

select empno, ename, sal --3. 무슨 열 추출
from emp    --1. 무슨 테이블 선택
where DEPTNO=20 AND SAL>1500 --2. 무슨 행 선택
;
--select 열 추출 조건 / where 행 선택 조건

SELECT EMPNO,ENAME, SAL
FROM EMP
; --EMP의 사번, 이름, 월급 조회

SELECT DNAME LOC
FROM DEPT
;
SELECT EMPNO, ENAME , JOB, mgr, hiredate, sal, comm, deptno
from emp;

SELECT    *FROM EMP;
SELECT    *FROM DEPT;
SELECT    *FROM salgrade;
SELECT    *FROM bonus;

--Q 사원명과 연봉을 조회
SELECT ename 사원명 , sal*12 연봉, sal*12 + nvl(comm,0) "보너스 포함 연봉"
FROM emp
;

SELECT comm, nvl(comm, 0)   --nvl : comm의 컬럼값이 none인거 > 0
FROM emp
;

SELECT '안녕' as hello    --as : hello;컬럼  안녕;컬럼값  emp table 길이만큼
FROM emp                    --distinct : 중복값 삭제
;

SELECT ename, sal
FROM emp
where sal > 1500 and sal < 2800
;
SELECT ename, sal
FROM emp
where sal BETWEEN 1600 and 2800
;

SELECT 
    *
FROM EMP
where not deptno = 20 and comm is null  --null은 is로 비교
;

-----------------------------------------
-- from = dual >> 임시 테이블 
--Ltrim  010 제거
--Lpad ename이 10자가 되도록 left쪽에 s를 채워줘
SELECT Lpad(ename, 10 ,'S') 
FROM emp;

--문자열(컬럼) 이어붙이기
SELECT concat(ename, comm)
FROM emp;

--해당 컬럼에서 SM을 A로 바꿈
SELECT replace(ename,'SM', 'A')
FROM emp;

--직원들의 평균 급여 조회
select avg(sal) 평균급여
from emp;

--부서별 평균급여 조회
select avg(sal) 평균급여
from emp GROUP by deptno;

--1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT *
FROM emp
where comm is not null;
--2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT *
FROM emp
where comm is null or comm =0;
--3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM emp
where mgr is null;
--4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT *
FROM emp 
order by sal desc ;
--5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT *
FROM emp 
order by sal desc;
--6. EMP테이블에서 사원번호, 사원명, 직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT empno, ename, job, hiredate
FROM emp 
order by hiredate desc ;

--7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT empno, ename
FROM emp 
order by empno desc ;

--8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회 (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT empno, hiredate, ename, sal
FROM emp 
order by deptno asc , hiredate asc;

--9. 오늘 날짜에 대한 정보 조회
SELECT sysdate
from dual ;

--10. EMP테이블에서 사번, 사원명, 급여 조회 (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT empno, ename, trunc(sal,-2)
FROM emp 
order by sal asc;

--11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM emp 
where mod(empno,2)=1;

--12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT  ename, extract(year from hiredate) 입사년도,extract(MONTH from hiredate) 월
FROM emp ;

--13. EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT *
FROM emp 
where extract(MONTH from hiredate)=9;

--14. EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
FROM emp 
where extract(year from hiredate)=1981;

--15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM emp 
where substr(ename,-1)='E';

--16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
SELECT *
FROM emp 
where ename like '__R%';
--where substr(ename,3)='R';

--17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT empno ,ename, hiredate, add_months(hiredate,480)
FROM emp; 
--18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
--19. 오늘 날짜에서 년도만 추출
SELECT extract(year from sysdate)
FROM dual; 
--group by 사용시 select 컬럼명으로 group by에서 사용된 컬럼명, 그룹함수만 사용가능

--3-12
SELECT e.empno, e.ename, sal,loc, 
    case loc            --loc이 뉴옥일떄 case문
        when 'NEW YORK' then sal*0.02
        when 'DALLAS' then sal*0.05
        when 'CHICAGO' then sal*0.03
    end       
    as sal_subsidy  -- as 다음은 추가별칭
FROM emp e join dept d using (deptno)
order by sal_subsidy-sal desc;
--group으로 loc를 묶으면 뉴옥에 하나 다른 도시에 하나 씩만 나와서 안됨


create or replace view view_emp_salgrade
as
select e.empno, e.ename, job, mgr , hiredate , sal, comm, deptno, grade , losal ,hisal
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

create table t1( c1 char(5), c2 varchar2(2));
insert into t1 values('12','12');
commit;
SELECT*
FROM t1;



select empno, ename, sal
from emp
where sal in ( 1600, 1250,1500);

--관리자로 등록되어 있는 사원들 조회
select empno, ename
from emp e 
where exists (select empno from emp e2 where e.empno=e2.mgr)
;
--부서 번호가 30인 사원들의 급여와 부서번호를 메인쿼리로 전달
select *
from emp 
where (deptno,sal) in (select deptno,sal from emp where deptno=30);
--부서별 평균급여와 직원들의 정보를 조회해주세요
select e.*, 
    (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno) 평균
from emp e
;
--salesman, 관리자 조회
select *
from emp
where job in( 'SALESMAN', 'MANAGER'); 

desc user_constraints;
select * from user_constraints;

create table emp_copy1 as select*from emp;
select* from emp_copy1;
create view view_emp_copy1 as select*from emp;
select*from view_emp_copy1;
desc emp;
insert into emp values(8000, 'EJKIM','KH',7788, sysdate,3000 ,700,40);
commit;
insert into emp_copy1 values(8001, 'EJKIM','KH',7788, sysdate,3000 ,700,40);
commit;
insert into view_emp_copy1 values(8004, 'EJKIM','KH',7788, sysdate,3000 ,700,40);
commit;
create table emp_copy20 as 
select empno, ename 사원명, job, hiredate , sal, deptno
from emp
where deptno=20
;
SELECT * FROM USER_SOURCE;
--그룹by 시 select에서 사용하는 컬럼이나 그룹 함수만 사용가능
--Q. 3 DEPTNO가 20,30인 부서 사람들의 등급별 평균연봉
select sa.grade, avg(sal*12+nvl(comm,0)) "평균연봉"
from emp e join salgrade sa on e.sal> sa.losal and e.sal<sa.hisal
where e.deptno!=10
GROUP by sa.grade
ORDER by "평균연봉" desc
;
--Q. 4
select e.deptno, floor(avg(sal*12+nvl(comm,0))) "평균연봉"
from emp e join salgrade sa on e.sal> sa.losal and e.sal<sa.hisal
where e.deptno!=10
GROUP by e.deptno
ORDER by "평균연봉" desc
;
--Q. 5
select e.empno, e.ename, e.job, e.mgr , m.ename manager
from emp e, emp m
where m.empno=e.mgr
;
--Q. 6사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬 단, Select 절에 SubQuery를 이용하여 풀이
select e.empno, e.ename, e.job, e.mgr,(SELECT m.ename FROM emp m where m.empno=e.mgr)manager
from emp e
;
--Q. 7MARTIN의 월급보다 많으면서 ALLEN과 같은 부서이거나 20번부서인 사원 조회
select *
from emp
where sal > 1250 and (deptno=30 or deptno=20)
;
--Q. 8‘RESEARCH’부서의 사원 이름과 매니저 이름을 나타내시오.
select e.ename, (select ename from emp m where m.empno=e.mgr) 매니저
from emp e
where deptno=20
;
--Q. 9 GRADE별로 급여을 가장 작은 사원명을 조회
--Q. 10.GRADE별로 가장 많은 급여, 가장 작은 급여, 평균 급여를 조회
select sal.grade, min(e.sal),max(e.sal),floor(avg(e.sal))
from emp e, salgrade sal
where losal<=e.sal and sal.hisal>=e.sal
group by sal.grade
;
--Q. 11
--Q. 12
--insert into emp (컬럼명1, 컬럼명2, ...) values(값1, 값2);
desc emp;
insert into emp ( ename, empno, job, mgr, hiredate, deptno)
    values ('EJK',8006,'T',7788,sysdate,40);
    select *
    from emp;
insert into emp ( ename, empno, job, mgr, hiredate, deptno)
    values ('EJK2',8007,'P',null,to_date('2023-07-12', 'yyyy-mm-dd'),40);--날짜 형식 형변환 필수
commit;
update emp
    set mgr=7788
    where ename='EJK2'
    --update 명령문의 where 절에는 컬럼명 PK=값
;
--20번 부서 사람들이 mgr 7908로 업뎃
update emp
    set mgr=7908
    where deptno =20   
;commit;
--20번 부서에 신입사원 EJ3 (8008),EJ4 추가
insert into emp(ename, empno,deptno) values('EJ3',8008,50);
insert into emp(ename, empno,deptno) values('EJ4',8009,50);

select deptno, empno,sal , sum(sal) sumsal
from emp;

select deptno, empno, ename, sal, 
    rank() over(order by sal asc) ranksal
    from emp;
select deptno, empno, ename, sal,
rn ranksal 
from (select rownum rn, t1.* from(select deptno, empno, ename, sal from emp order by sal asc)t1);

select ename, sal
    ,CUME_DIST() over(order by sal) sal_cume_dist
from emp
where deptno=30;

--그룹함수 사용하지 않고 deptno를 묶어서 sum
SELECT deptno
, empno
, sal
, SUM(sal) OVER(PARTITION BY deptno) s_sal
FROM emp;

