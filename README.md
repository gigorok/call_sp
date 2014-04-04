# CallSp

A stored procedures wrapper.

## Installation

Add this line to your application's Gemfile:

    gem 'call_sp', '~> 0.0.3'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install call_sp

## Usage

Suppose your stored procedures are

    CREATE OR REPLACE FUNCTION say_my_name(_name text) RETURNS TEXT AS $$
      BEGIN
        RETURN _name;
      END;
    $$ LANGUAGE plpgsql;

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


Just include CallSp module into your own class and will describe the stored procedures

    class SpClass
      include ::CallSp

      procedure :my_name, { as: :say_my_name, mode: :fetch_sp_val }
      procedure :show_names, { schema: :sp, mode: :fetch_sp }
      procedure :drop_teenagers, { schema: :sp, mode: :execute_sp }
    end

After that module will create a methods my_name, show_names, drop_teenagers and you can call them with parameters of stored procedure

    SpClass.my_name(['John'])
    SpClass.show_names([], { conditions: ["age > ?", 20], order: "age DESC" }).each do |row|
       p row
    end
    SpClass.drop_teenagers()


## Contributing

1. Fork it ( http://github.com/gigorok/call_sp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
