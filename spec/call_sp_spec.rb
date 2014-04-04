require 'spec_helper'

describe CallSp do

  before(:all) {
    conn = YAML.load(File.read("#{File.expand_path('../', __FILE__)}/database.yml"))
    ActiveRecord::Base.establish_connection conn[ENV["RAILS_ENV"]]

    ActiveRecord::Base.connection.execute File.read("#{File.expand_path('../', __FILE__)}/sql/up.sql")
  }

  after(:all) {
    conn = YAML.load(File.read("#{File.expand_path('../', __FILE__)}/database.yml"))
    ActiveRecord::Base.establish_connection conn[ENV["RAILS_ENV"]]

    ActiveRecord::Base.connection.execute File.read("#{File.expand_path('../', __FILE__)}/sql/down.sql")
  }

  it 'fetch one' do
    SpClass.my_name(['John']).should == 'John'
    SpClass.my_name(['John Doe']).should == 'John Doe'
  end

  it 'fetch many' do

    collection = [
      {"id"=>"1", "name"=>"John", "age"=>"20"},
      {"id"=>"2", "name"=>"Nick", "age"=>"22"},
      {"id"=>"3", "name"=>"Kate", "age"=>"17"},
      {"id"=>"4", "name"=>"Bill", "age"=>"30"}
    ]

    i = 0
    SpClass.show_names().each do |row|
      row["id"].should == collection.at(i)["id"]
      row["name"].should == collection.at(i)["name"]
      row["age"].should == collection.at(i)["age"]

      i += 1
    end


  end

  it 'fetch many with conditions' do
    collection2 = [
        {"id"=>"2", "name"=>"Nick", "age"=>"22"},
        {"id"=>"4", "name"=>"Bill", "age"=>"30"}
    ]

    i = 0
    SpClass.show_names([], { conditions: ["age > ?", 20] }).each do |row|
      row["id"].should == collection2.at(i)["id"]
      row["name"].should == collection2.at(i)["name"]
      row["age"].should == collection2.at(i)["age"]

      i += 1
    end
  end

  it 'fetch many with conditions and order' do
    collection2 = [
      {"id"=>"4", "name"=>"Bill", "age"=>"30"},
      {"id"=>"2", "name"=>"Nick", "age"=>"22"}
    ]

    i = 0
    SpClass.show_names([], { conditions: ["age > ?", 20], order: "age DESC" }).each do |row|
      row["id"].should == collection2.at(i)["id"]
      row["name"].should == collection2.at(i)["name"]
      row["age"].should == collection2.at(i)["age"]

      i += 1
    end
  end

  it 'execute' do

    collection = [
        {"id"=>"1", "name"=>"John", "age"=>"20"},
        {"id"=>"2", "name"=>"Nick", "age"=>"22"},
        {"id"=>"4", "name"=>"Bill", "age"=>"30"}
    ]

    SpClass.drop_teenagers()

    i = 0
    SpClass.show_names().each do |row|
      row["id"].should == collection.at(i)["id"]
      row["name"].should == collection.at(i)["name"]
      row["age"].should == collection.at(i)["age"]

      i += 1
    end
  end

end
