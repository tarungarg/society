CREATE TABLE "tenants" ("id" serial primary key, "name" character varying, "domain" character varying, "image_url" character varying, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX  "index_tenants_on_domain" ON "tenants" USING btree ("domain");
INSERT INTO schema_migrations (version) VALUES (20161105040315);
