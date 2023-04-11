CREATE TABLE "Countries" (
	"id" varchar(2) NOT NULL,
	"country_name" varchar(45) NOT NULL,
	CONSTRAINT "Countries_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX countries_country_name_idx ON "Countries" (country_name);

CREATE TABLE "Regions" (
	"id" serial NOT NULL,
	"region_name" varchar(255) NOT NULL,
	"fk_country_id" varchar(2) NOT NULL,
	CONSTRAINT "Regions_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX regions_region_name_idx ON "Regions" (region_name);


CREATE TABLE "Cities" (
	"id" serial NOT NULL,
	"city_name" varchar(255) NOT NULL,
	"fk_region_id" bigint NOT NULL,
	"fk_country_id" varchar(2) NOT NULL,
	CONSTRAINT "Cities_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX cities_city_name_idx ON "Cities" (city_name);


CREATE TABLE "Streets" (
	"id" serial NOT NULL,
	"street_name" varchar(255) NOT NULL,
	"fk_city_id" bigint NOT NULL,
	CONSTRAINT "Streets_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Addreses" (
	"id" serial NOT NULL,
	"postal_code" varchar(10) NOT NULL,
	"address_line" varchar(255) NOT NULL,
	"address_line2" varchar(255) NOT NULL,
	"comments" varchar(255) NOT NULL,
	"fk_street_id" bigint NOT NULL,
	CONSTRAINT "Addreses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Products" (
	"id" serial NOT NULL,
	"product_name" varchar(255) NOT NULL,
	"createdAt" TIMESTAMP NOT NULL,
	"fk_category_id" bigint NOT NULL,
	CONSTRAINT "Products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX products_product_name_idx ON "Products" (product_name);

CREATE TABLE "Categories" (
	"id" serial NOT NULL,
	"category_name" varchar(255) NOT NULL,
	"parent_category" bigint NOT NULL,
	CONSTRAINT "Categories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX categories_category_name_idx ON "Categories" (category_name);

CREATE TABLE "Product_params" (
	"id" serial NOT NULL,
	"fk_product_id" bigint NOT NULL,
	"fk_category_param_id" bigint NOT NULL,
	CONSTRAINT "Product_params_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Category_params" (
	"id" serial NOT NULL,
	"param_name" varchar(255) NOT NULL,
	"param_type" varchar(255) NOT NULL,
	"default_value" varchar(255) NOT NULL,
	CONSTRAINT "Category_params_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX category_params_param_name_idx ON "Category_params" (param_name);
CREATE INDEX category_params_param_type_idx ON "Category_params" (param_type);

CREATE TABLE "cross_category_params" (
	"fk_category_id" bigint NOT NULL,
	"fk_category_param_id" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Manufactures" (
	"id" serial NOT NULL,
	"title" varchar(255) NOT NULL,
	"fk_address_id" bigint NOT NULL,
	CONSTRAINT "Manufactures_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX manufactures_title_idx ON "Manufactures" (title);

CREATE TABLE "Providers" (
	"id" serial NOT NULL,
	"title" varchar(255) NOT NULL,
	CONSTRAINT "Providers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE INDEX providers_title_idx ON "Providers" (title);

CREATE TABLE "Stock" (
	"id" serial NOT NULL,
	"fk_manufacture_id" bigint NOT NULL,
	"fk_provider_id" bigint NOT NULL,
	"count" int NOT NULL CHECK (count > 0),
	"fk_product_id" bigint NOT NULL,
	CONSTRAINT "Stock_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Prices" (
	"id" serial NOT NULL,
	"price" money NOT NULL,
	"fk_product_id" bigint NOT NULL,
	"created_at" timestamp NOT NULL,
	"fk_currecy_id" bigint NOT NULL,
	CONSTRAINT "Prices_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Currencies" (
	"id" serial NOT NULL,
	"code" varchar(4) NOT NULL,
	"title" varchar(40) NOT NULL,
	CONSTRAINT "Currencies_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TYPE gender AS ENUM ('male', 'female');

CREATE TYPE marital_status AS ENUM ('idle', 'married', 'divorsed');

CREATE TABLE "Customers" (
	"id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"secondary_name" varchar(255) NOT NULL,
	"birth_day" DATE NOT NULL CHECK (EXTRACT(YEAR from age(date(birth_day))) > 18 AND EXTRACT(YEAR from age(date(birth_day))) < 80),
	"marital_status" marital_status,
	"gender" gender,
	CONSTRAINT "Customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "Languages" (
	"id" serial NOT NULL,
	"appeal_lang" varchar(3) NOT NULL,
	CONSTRAINT "Languages_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Sales" (
	"id" serial NOT NULL,
	"fk_customer_id" bigint NOT NULL,
	"fk_appeal_lang_id" bigint NOT NULL,
	"fk_product_id" bigint NOT NULL,
	"fk_price_id" bigint NOT NULL,
	"count" int NOT NULL CHECK (count > 0),
	"fk_address_id" bigint NOT NULL,
	CONSTRAINT "Sales_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Regions" ADD CONSTRAINT "Regions_fk0" FOREIGN KEY ("fk_country_id") REFERENCES "Countries"("id");
ALTER TABLE "Cities" ADD CONSTRAINT "Cities_fk0" FOREIGN KEY ("fk_region_id") REFERENCES "Regions"("id");
ALTER TABLE "Cities" ADD CONSTRAINT "Cities_fk1" FOREIGN KEY ("fk_country_id") REFERENCES "Countries"("id");
ALTER TABLE "Streets" ADD CONSTRAINT "Streets_fk0" FOREIGN KEY ("fk_city_id") REFERENCES "Cities"("id");
ALTER TABLE "Addreses" ADD CONSTRAINT "Addreses_fk0" FOREIGN KEY ("fk_street_id") REFERENCES "Streets"("id");
ALTER TABLE "Products" ADD CONSTRAINT "Products_fk0" FOREIGN KEY ("fk_category_id") REFERENCES "Categories"("id");
ALTER TABLE "Categories" ADD CONSTRAINT "Categories_fk0" FOREIGN KEY ("parent_category") REFERENCES "Categories"("id");
ALTER TABLE "Product_params" ADD CONSTRAINT "Product_params_fk0" FOREIGN KEY ("fk_product_id") REFERENCES "Products"("id");
ALTER TABLE "Product_params" ADD CONSTRAINT "Product_params_fk1" FOREIGN KEY ("fk_category_param_id") REFERENCES "Category_params"("id");
ALTER TABLE "cross_category_params" ADD CONSTRAINT "cross_category_params_fk0" FOREIGN KEY ("fk_category_id") REFERENCES "Categories"("id");
ALTER TABLE "cross_category_params" ADD CONSTRAINT "cross_category_params_fk1" FOREIGN KEY ("fk_category_param_id") REFERENCES "Category_params"("id");
ALTER TABLE "Manufactures" ADD CONSTRAINT "Manufactures_fk0" FOREIGN KEY ("fk_address_id") REFERENCES "Addreses"("id");
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_fk0" FOREIGN KEY ("fk_manufacture_id") REFERENCES "Manufactures"("id");
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_fk1" FOREIGN KEY ("fk_provider_id") REFERENCES "Providers"("id");
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_fk2" FOREIGN KEY ("fk_product_id") REFERENCES "Products"("id");
ALTER TABLE "Prices" ADD CONSTRAINT "Prices_fk0" FOREIGN KEY ("fk_product_id") REFERENCES "Products"("id");
ALTER TABLE "Prices" ADD CONSTRAINT "Prices_fk1" FOREIGN KEY ("fk_currecy_id") REFERENCES "Currencies"("id");
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_fk0" FOREIGN KEY ("fk_customer_id") REFERENCES "Customers"("id");
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_fk1" FOREIGN KEY ("fk_appeal_lang_id") REFERENCES "Languages"("id");
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_fk2" FOREIGN KEY ("fk_product_id") REFERENCES "Products"("id");
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_fk3" FOREIGN KEY ("fk_price_id") REFERENCES "Prices"("id");
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_fk4" FOREIGN KEY ("fk_address_id") REFERENCES "Addreses"("id");









