
ALTER TABLE SC_CRM_Contacts 	DROP CONSTRAINT FK_SC_CRM_Contacts_1;
ALTER TABLE SC_CRM_Delivery 	DROP CONSTRAINT FK_SC_CRM_Delivery_1;
ALTER TABLE SC_CRM_Delivery 	DROP CONSTRAINT FK_SC_CRM_Delivery_2;
ALTER TABLE SC_CRM_Events 	DROP CONSTRAINT FK_SC_CRM_Events_1;
ALTER TABLE SC_CRM_Participants DROP CONSTRAINT FK_SC_CRM_Participants_1;

ALTER TABLE SC_CRM_Contacts	DROP CONSTRAINT PK_Crm_Contacts;
ALTER TABLE SC_CRM_Delivery	DROP CONSTRAINT PK_Crm_Delivery;
ALTER TABLE SC_CRM_Events	DROP CONSTRAINT PK_Crm_Events;
ALTER TABLE SC_CRM_Infos	DROP CONSTRAINT PK_Crm_Infos;
ALTER TABLE SC_CRM_Participants	DROP CONSTRAINT PK_Crm_Participants;



