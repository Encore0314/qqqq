------------------------------------------------------
-- Export file for user STRUCT                      --
-- Created by Administrator on 2006-11-23, 15:16:53 --
------------------------------------------------------

spool struct.log

prompt
prompt Creating table SYSLOG
prompt =====================
prompt
create table SYSLOG
(
  USERID   VARCHAR2(100),
  IP       VARCHAR2(100),
  FID      VARCHAR2(500),
  SQL      VARCHAR2(4000),
  FLAG     VARCHAR2(50),
  MESSAGE  VARCHAR2(4000),
  DATETIME DATE
)
tablespace WORK
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USERS
prompt ====================
prompt
create table USERS
(
  USER_ID  VARCHAR2(20),
  PASSWORD VARCHAR2(200)
)
tablespace WORK
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence ID_SEQ
prompt ========================
prompt
create sequence ID_SEQ
minvalue 1
maxvalue 9999999999999999
start with 482
increment by 1
nocache;

prompt
prompt Creating function FORMAT_DATE
prompt =============================
prompt
create or replace function format_date(defaultValue in varchar2,format in varchar2) return date is
  Result date;
  --这个函数是用来格式化日期的，defaultValue为要格式化的字符串
  --format为日期格式
  --当defaultValue=sysdate时，返回系统时间，跟format没有关系了
begin
if defaultValue ='sysdate' then
return sysdate;
end if;
result:=to_date(defaultValue,format);
  return(Result);
end format_date;
/

prompt
prompt Creating function FORMAT_LIKE
prompt =============================
prompt
create or replace function format_like(str in varchar2) return varchar2 is
  Result varchar2(100);
    --这个函数是用来构造like语句后面的表达式
begin
  result:='%'||str||'%';
  return(Result);
end format_like;
/


spool off
