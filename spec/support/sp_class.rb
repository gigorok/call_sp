class SpClass
  include ::CallSp

  procedure :my_name, { as: :say_my_name, mode: :fetch_sp_val }
  procedure :show_names, { schema: :sp, mode: :fetch_sp }
  procedure :drop_teenagers, { schema: :sp, mode: :execute_sp }
end