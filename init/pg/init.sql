CREATE TABLE "public.Countries" (
	"id" varchar(2) NOT NULL,
	"country_name" varchar(45) NOT NULL,
	CONSTRAINT "Countries_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Regions" (
	"id" serial NOT NULL,
	"region_name" varchar(255) NOT NULL,
	"fk_country_id" varchar(2) NOT NULL,
	CONSTRAINT "Regions_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Cities" (
	"id" serial NOT NULL,
	"city_name" varchar(255) NOT NULL,
	"fk_region_id" bigint NOT NULL,
	"fk_country_id" varchar(2) NOT NULL,
	CONSTRAINT "Cities_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Streets" (
	"id" serial NOT NULL,
	"street_name" varchar(255) NOT NULL,
	"fk_city_id" bigint NOT NULL,
	CONSTRAINT "Streets_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Addreses" (
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



CREATE TABLE "public.Products" (
	"id" serial NOT NULL,
	"product_name" varchar(255) NOT NULL,
	"createdAt" TIMESTAMP NOT NULL,
	"fk_category_id" bigint NOT NULL,
	CONSTRAINT "Products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Categories" (
	"id" serial NOT NULL,
	"category_name" varchar(255) NOT NULL,
	"parent_category" bigint NOT NULL,
	CONSTRAINT "Categories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Product_params" (
	"id" serial NOT NULL,
	"fk_product_id" bigint NOT NULL,
	"fk_category_param_id" bigint NOT NULL,
	CONSTRAINT "Product_params_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Category_params" (
	"id" serial NOT NULL,
	"param_name" varchar(255) NOT NULL,
	"param_type" varchar(255) NOT NULL,
	"default_value" varchar(255) NOT NULL,
	CONSTRAINT "Category_params_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.cross_category_params" (
	"fk_category_id" bigint NOT NULL,
	"fk_category_param_id" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Manufactures" (
	"id" serial NOT NULL,
	"title" varchar(255) NOT NULL,
	"fk_address_id" bigint NOT NULL,
	CONSTRAINT "Manufactures_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Providers" (
	"id" serial NOT NULL,
	"title" varchar(255) NOT NULL,
	CONSTRAINT "Providers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Stock" (
	"id" serial NOT NULL,
	"fk_manufacture_id" bigint NOT NULL,
	"fk_provider_id" bigint NOT NULL,
	"count" int NOT NULL,
	"fk_product_id" bigint NOT NULL,
	CONSTRAINT "Stock_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Prices" (
	"id" serial NOT NULL,
	"price" money NOT NULL,
	"fk_product_id" bigint NOT NULL,
	"created_at" timestamp NOT NULL,
	"fk_currecy_id" bigint NOT NULL,
	CONSTRAINT "Prices_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Currencies" (
	"id" serial NOT NULL,
	"code" varchar(4) NOT NULL,
	"title" varchar(40) NOT NULL,
	CONSTRAINT "Currencies_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Customers" (
	"id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"secondary_name" varchar(255) NOT NULL,
	"birth_day" DATE NOT NULL,
	"marital_status" varchar(25) NOT NULL,
	"gender" varchar(5) NOT NULL,
	CONSTRAINT "Customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Languages" (
	"id" serial NOT NULL,
	"appeal_lang" varchar(3) NOT NULL,
	CONSTRAINT "Languages_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Sales" (
	"id" serial NOT NULL,
	"fk_customer_id" bigint NOT NULL,
	"fk_appeal_lang_id" bigint NOT NULL,
	"fk_product_id" bigint NOT NULL,
	"fk_price_id" bigint NOT NULL,
	"count" int NOT NULL,
	"fk_address_id" bigint NOT NULL,
	CONSTRAINT "Sales_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "public.Regions" ADD CONSTRAINT "Regions_fk0" FOREIGN KEY ("fk_country_id") REFERENCES "public.Countries"("id");
ALTER TABLE "public.Cities" ADD CONSTRAINT "Cities_fk0" FOREIGN KEY ("fk_region_id") REFERENCES "public.Regions"("id");
ALTER TABLE "public.Cities" ADD CONSTRAINT "Cities_fk1" FOREIGN KEY ("fk_country_id") REFERENCES "public.Countries"("id");
ALTER TABLE "public.Streets" ADD CONSTRAINT "Streets_fk0" FOREIGN KEY ("fk_city_id") REFERENCES "public.Cities"("id");
ALTER TABLE "public.Addreses" ADD CONSTRAINT "Addreses_fk0" FOREIGN KEY ("fk_street_id") REFERENCES "public.Streets"("id");
ALTER TABLE "public.Products" ADD CONSTRAINT "Products_fk0" FOREIGN KEY ("fk_category_id") REFERENCES "public.Categories"("id");
ALTER TABLE "public.Categories" ADD CONSTRAINT "Categories_fk0" FOREIGN KEY ("parent_category") REFERENCES "public.Categories"("id");
ALTER TABLE "public.Product_params" ADD CONSTRAINT "Product_params_fk0" FOREIGN KEY ("fk_product_id") REFERENCES "public.Products"("id");
ALTER TABLE "public.Product_params" ADD CONSTRAINT "Product_params_fk1" FOREIGN KEY ("fk_category_param_id") REFERENCES "public.Category_params"("id");
ALTER TABLE "public.cross_category_params" ADD CONSTRAINT "cross_category_params_fk0" FOREIGN KEY ("fk_category_id") REFERENCES "public.Categories"("id");
ALTER TABLE "public.cross_category_params" ADD CONSTRAINT "cross_category_params_fk1" FOREIGN KEY ("fk_category_param_id") REFERENCES "public.Category_params"("id");
ALTER TABLE "public.Manufactures" ADD CONSTRAINT "Manufactures_fk0" FOREIGN KEY ("fk_address_id") REFERENCES "public.Addreses"("id");
ALTER TABLE "public.Stock" ADD CONSTRAINT "Stock_fk0" FOREIGN KEY ("fk_manufacture_id") REFERENCES "public.Manufactures"("id");
ALTER TABLE "public.Stock" ADD CONSTRAINT "Stock_fk1" FOREIGN KEY ("fk_provider_id") REFERENCES "public.Providers"("id");
ALTER TABLE "public.Stock" ADD CONSTRAINT "Stock_fk2" FOREIGN KEY ("fk_product_id") REFERENCES "public.Products"("id");
ALTER TABLE "public.Prices" ADD CONSTRAINT "Prices_fk0" FOREIGN KEY ("fk_product_id") REFERENCES "public.Products"("id");
ALTER TABLE "public.Prices" ADD CONSTRAINT "Prices_fk1" FOREIGN KEY ("fk_currecy_id") REFERENCES "public.Currencies"("id");
ALTER TABLE "public.Sales" ADD CONSTRAINT "Sales_fk0" FOREIGN KEY ("fk_customer_id") REFERENCES "public.Customers"("id");
ALTER TABLE "public.Sales" ADD CONSTRAINT "Sales_fk1" FOREIGN KEY ("fk_appeal_lang_id") REFERENCES "public.Languages"("id");
ALTER TABLE "public.Sales" ADD CONSTRAINT "Sales_fk2" FOREIGN KEY ("fk_product_id") REFERENCES "public.Products"("id");
ALTER TABLE "public.Sales" ADD CONSTRAINT "Sales_fk3" FOREIGN KEY ("fk_price_id") REFERENCES "public.Prices"("id");
ALTER TABLE "public.Sales" ADD CONSTRAINT "Sales_fk4" FOREIGN KEY ("fk_address_id") REFERENCES "public.Addreses"("id");









