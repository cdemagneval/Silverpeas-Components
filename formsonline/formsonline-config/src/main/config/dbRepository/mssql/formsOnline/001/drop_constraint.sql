ALTER TABLE SC_FormsOnline_Forms DROP CONSTRAINT PK_SC_FormsOnline_Form ;
ALTER TABLE SC_FormsOnline_FormInstances DROP CONSTRAINT PK_SC_FormsOnline_FormInstances ;
ALTER TABLE SC_FormsOnline_FormInstances DROP CONSTRAINT FK_FormInstance;
ALTER TABLE SC_FormsOnline_UserRights DROP CONSTRAINT FK_UserRights;
ALTER TABLE SC_FormsOnline_GroupRights DROP CONSTRAINT FK_GroupRights;
