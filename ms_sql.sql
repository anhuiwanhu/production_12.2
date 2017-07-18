insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.2.0.01_SP_20170623','12.2.0.01',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.2.0.02_SP_20170630','12.2.0.02',getdate());
go









update OA_CUSTMENU set menu_blone=(select id from OA_CUSTMENU where menucodeset='newKq'),menu_location=(select id from OA_CUSTMENU where menucodeset='newKq'),
menu_mantbl_subtbl=(select id from OA_CUSTMENU where menucodeset='newKq') where menucodeset='newKq';
go
create table oa_locktable (
   id                   numeric(20)         identity(1,1),
   jlid                 numeric(20)          null,
   userid               numeric(20)          null,
   username             nvarchar(200)        null,
   lockdate             datetime             null
);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.2.0.03_SP_20170710','12.2.0.03',getdate());
go








insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.2.0.04_SP_20170717','12.2.0.04',getdate());
go