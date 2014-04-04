CREATE OR REPLACE FUNCTION say_my_name(_name text) RETURNS TEXT AS $$
  BEGIN
    RETURN _name;
  END;
$$ LANGUAGE plpgsql;

CREATE TABLE "public"."names" (
	"id" int4 NOT NULL,
	"name" varchar NOT NULL,
	"age" numeric NOT NULL
);

INSERT INTO "public"."names"(id, name, age) values
  (1, 'John', 20),
  (2, 'Nick', 22),
  (3, 'Kate', 17),
  (4, 'Bill', 30);

CREATE SCHEMA "sp";

CREATE OR REPLACE FUNCTION sp.show_names() RETURNS TABLE (id integer, name varchar, age numeric) AS $$
  BEGIN
    RETURN QUERY SELECT * FROM "public"."names";
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sp.drop_teenagers() RETURNS VOID AS $$
  BEGIN
    DELETE FROM "public"."names" WHERE age < 20;
  END;
$$ LANGUAGE plpgsql;