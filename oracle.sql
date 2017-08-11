insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.01_SP_20170623','12.2.0.01',sysdate);
commit;






insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.02_SP_20170630','12.2.0.02',sysdate);
commit;









update OA_CUSTMENU set menu_blone=(select id from OA_CUSTMENU where menucodeset='newKq'),menu_location=(select id from OA_CUSTMENU where menucodeset='newKq'),
menu_mantbl_subtbl=(select id from OA_CUSTMENU where menucodeset='newKq') where menucodeset='newKq';
commit;
create table oa_locktable  (
   id                   number(20),
   jlid                 number(20),
   userid               number(20),
   username             nvarchar2(200),
   lockdate             DATE
);
commit;
comment on table oa_locktable is
'oa锁机制表';
commit;
comment on column oa_locktable.jlid is
'当前记录id';
commit;
comment on column oa_locktable.userid is
'当前用户id';
commit;
comment on column oa_locktable.username is
'当前用户名';
commit;
comment on column oa_locktable.lockdate is
'当前时间';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.03_SP_20170710','12.2.0.03',sysdate);
commit;









insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.04_SP_20170717','12.2.0.04',sysdate);
commit;










alter table GOV_ORGASSISTANT add createEmp number(20);
commit;
comment  on  column GOV_ORGASSISTANT.CreateEmp is '创建人id';
commit;
alter table GOV_ORGASSISTANT add createOrg number(20);
commit;
comment  on  column GOV_ORGASSISTANT.createOrg is '创建人所属组织id';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.05_SP_20170724','12.2.0.05',sysdate);
commit;








insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.06_SP_20170731','12.2.0.06',sysdate);
commit;









insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.2.0.07_SP_20170809','12.2.0.07',sysdate);
commit;